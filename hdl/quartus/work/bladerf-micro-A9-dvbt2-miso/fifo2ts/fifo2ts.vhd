/*
*   File:   fifo2ts.vhd
*   Author: Bastien Pillonel 
*   EMAIL:  bastien.pillonel@heig-vd.ch
*
*   Description:    This file describe an interface that read the 32bits sample fifo in the TX fifo and feed
*                   the TS interface of the DVB-T2 core with 8bits TS data.
*
*/

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL ;
use ieee.numeric_std.all;

library work;
    use work.fifo_readwrite_p.all;

entity fifo2ts is
    generic (
        NUM_STREAMS           : natural                 := 1;
        FIFO_READ_THROTTLE    : natural range 0 to 255  := 1;
        FIFO_USEDW_WIDTH      : natural                 := 12;
        FIFO_DATA_WIDTH       : natural                 := 32;
        META_FIFO_USEDW_WIDTH : natural                 := 3;
        META_FIFO_DATA_WIDTH  : natural                 := 128
    );
    port(
        fifo_clock            : in std_logic;                                    
        reset                 : in std_logic;
        enable              : in std_logic;

        usb_speed           : in std_logic;
        meta_en             :   in      std_logic;
        packet_en           :   in      std_logic;
        eight_bit_mode_en   :   in      std_logic;
        timestamp           :   in      unsigned(63 downto 0);

        fifo_usedw          :   in      std_logic_vector(FIFO_USEDW_WIDTH-1 downto 0);
        fifo_read           :   out     std_logic;
        fifo_empty          :   in      std_logic;
        fifo_data           :   in      std_logic_vector(FIFO_DATA_WIDTH-1 downto 0);
        fifo_holdoff        :   in      std_logic := '0';

        packet_control      :   out     packet_control_t;
        packet_empty        :   out     std_logic;
        packet_ready        :   in      std_logic;

        meta_fifo_usedw     :   in      std_logic_vector(META_FIFO_USEDW_WIDTH-1 downto 0);
        meta_fifo_read      :   buffer  std_logic := '0';
        meta_fifo_empty     :   in      std_logic;
        meta_fifo_data      :   in      std_logic_vector(META_FIFO_DATA_WIDTH-1 downto 0);

        in_sample_controls  :   in      sample_controls_t(0 to NUM_STREAMS-1) := (others => SAMPLE_CONTROL_DISABLE);
        out_samples         :   out     std_logic_vector(FIFO_DATA_WIDTH-1 downto 0)  := (others => '0');

        underflow_led       :   buffer  std_logic;
        underflow_count     :   buffer  unsigned(63 downto 0);
        underflow_duration  :   in      unsigned(15 downto 0);

        ts_data             : out std_logic_vector(7 downto 0);
        ts_valid            : out std_logic;
        ts_busy_g1          : in std_logic; 
        ts_busy_g2          : in std_logic                                     
    );
end fifo2ts;

architecture internal of fifo2ts is
    constant DMA_BUF_SIZE_SS    : natural   := 512;
    constant DMA_BUF_SIZE_HS    : natural   := 256;

    signal   dma_buf_size       : natural range DMA_BUF_SIZE_HS to DMA_BUF_SIZE_SS := DMA_BUF_SIZE_SS;
    signal   underflow_detected : std_logic := '0';

    type meta_state_t is (
        META_LOAD,
        META_WAIT,
        META_DOWNCOUNT
    );

    type meta_fsm_t is record
        state           : meta_state_t;
        dma_downcount   : natural range 0 to DMA_BUF_SIZE_SS;
        meta_pkt_sop    : std_logic;
        meta_pkt_eop    : std_logic;
        skip_padding    : std_logic;
        meta_read       : std_logic;
        meta_cache      : std_logic_vector(META_FIFO_DATA_WIDTH-1 downto 0);
        meta_p_time     : unsigned(63 downto 0);
        meta_p_time_r   : unsigned(63 downto 0);
        meta_time_go    : std_logic;
        meta_fifo_empty : std_logic;
        meta_fifo_data  : std_logic_vector(META_FIFO_DATA_WIDTH-1 downto 0);
    end record;

    constant META_FSM_RESET_VALUE : meta_fsm_t := (
        state           => META_LOAD,
        dma_downcount   => 0,
        meta_pkt_sop    => '0',
        meta_pkt_eop    => '0',
        skip_padding    => '0',
        meta_read       => '0',
        meta_cache      => (others => '0'),
        meta_p_time     => (others => '-'),
        meta_p_time_r   => (others => '-'),
        meta_time_go    => '0',
        meta_fifo_empty => '1',
        meta_fifo_data  => (others => '0')
    );

    signal meta_current : meta_fsm_t := META_FSM_RESET_VALUE;
    signal meta_future  : meta_fsm_t := META_FSM_RESET_VALUE;

    type fifo_state_t is (
        COMPUTE_ENABLED_CHANNELS,
        COMPUTE_OFFSETS,
        READ_PACKET,
        IDLE_READ,
        READ_THROTTLE,
        READ_HOLDOFF,
        WRITE_TS
    );

    type ch_offsets_t is array( natural range <> ) of natural range fifo_data'low to fifo_data'high;

    type fifo_fsm_t is record
        state               : fifo_state_t;
        downcount           : natural range 0 to FIFO_READ_THROTTLE;
        sample_controls_reg : sample_controls_t(in_sample_controls'range);
        enabled_channels    : natural range 0 to in_sample_controls'length;
        ch_shift            : natural range 0 to out_samples'high;
        ch_offsets          : ch_offsets_t(in_sample_controls'range);
        samples_left_init   : natural range 0 to in_sample_controls'length;
        samples_left        : natural range 0 to in_sample_controls'length;
        packet_control      : packet_control_t;
        packet_data_cache   : std_logic_vector(31 downto 0);
        fifo_read           : std_logic;
        out_samples         : std_logic_vector(FIFO_DATA_WIDTH-1 downto 0);
        eight_bit_sample_sel: std_logic;
    end record;

    constant FIFO_FSM_RESET_VALUE : fifo_fsm_t := (
        state               => IDLE_READ,
        downcount           => FIFO_READ_THROTTLE,
        sample_controls_reg => (others => SAMPLE_CONTROL_DISABLE),
        enabled_channels    => 0,
        ch_shift            => 0,
        ch_offsets          => (others => 0),
        samples_left_init   => 0,
        samples_left        => 0,
        packet_control      => PACKET_CONTROL_DEFAULT,
        packet_data_cache   => (others => '0'),
        fifo_read           => '0',
        out_samples         => (others => '0'),
        eight_bit_sample_sel => '0'
    );

    signal fifo_current : fifo_fsm_t := FIFO_FSM_RESET_VALUE;
    signal fifo_future  : fifo_fsm_t := FIFO_FSM_RESET_VALUE;

    signal ts_busy_s    : std_logic;

    signal start_cntr_s : std_logic;
    signal cntr_fut_s, cntr_pres_s : integer range 0 to (FIFO_DATA_WIDTH/8)-1;
    signal fifo_read_fut_s, fifo_read_pres_s : std_logic;


begin

    -- Determine the DMA buffer size based on USB speed
    calc_buf_size : process( fifo_clock, reset )
    begin
        if( reset = '1' ) then
            dma_buf_size <= DMA_BUF_SIZE_SS;
        elsif( rising_edge(fifo_clock) ) then
            if( usb_speed = '0' ) then
                dma_buf_size <= DMA_BUF_SIZE_SS;
            else
                dma_buf_size <= DMA_BUF_SIZE_HS;
            end if;
        end if;
    end process;


    -- ------------------------------------------------------------------------
    -- META FIFO FSM
    -- ------------------------------------------------------------------------

    -- Meta FIFO synchronous process
    meta_fsm_sync : process( fifo_clock, reset )
    begin
        if( reset = '1' ) then
            meta_current <= META_FSM_RESET_VALUE;
        elsif( rising_edge(fifo_clock) ) then
            meta_current <= meta_future;
        end if;
    end process;

    packet_empty <= '1' when ( meta_current.meta_fifo_empty = '1' and meta_current.state /= META_WAIT ) else '0' ;

    -- Meta FIFO combinatorial process
    meta_fsm_comb : process( all )
        variable  meta_time : unsigned(63 downto 0);
    begin

        meta_future <= meta_current;

        meta_future.meta_read <= '0';
        meta_future.meta_pkt_sop <= '0';
        meta_future.meta_pkt_eop <= '0';
        meta_future.meta_fifo_empty <= meta_fifo_empty;
        meta_future.meta_fifo_data  <= meta_fifo_data;
        meta_time := unsigned(meta_current.meta_fifo_data(95 downto 32)) - 1;
        meta_future.meta_p_time_r <= meta_time;

        case meta_current.state is

            when META_LOAD =>

                meta_future.skip_padding <= '0';
                meta_future.meta_p_time <= meta_current.meta_p_time_r;
                meta_future.meta_cache  <= meta_current.meta_fifo_data;

                if( meta_current.dma_downcount = NUM_STREAMS ) then
                    meta_future.dma_downcount <= 0;
                end if;

                if( fifo_current.ch_shift = 0 ) then
                    if( meta_current.meta_fifo_empty = '0' and (packet_en = '0' or
                               (packet_en = '1' and packet_ready = '1') ) ) then
                       meta_future.meta_read <= '1';
                       meta_future.state     <= META_WAIT;
                       if( packet_en = '1' or meta_current.meta_p_time_r /= timestamp ) then
                             meta_future.meta_time_go  <= '0';
                          else
                             meta_future.meta_time_go  <= '1';
                       end if;
                    else
                       meta_future.meta_time_go  <= '0';
                    end if;
                end if;

            when META_WAIT =>

                if( packet_en = '1' ) then
                   meta_future.dma_downcount <= to_integer(unsigned(meta_current.meta_cache(15 downto 0)));
                else
                   meta_future.dma_downcount <= dma_buf_size - 4;
                end if;

                if( (timestamp >= meta_current.meta_p_time or meta_current.meta_p_time + 1 = 0)
                        and ( packet_en = '0' or ( packet_en = '1' and packet_ready = '1' ) ) ) then
                    meta_future.meta_time_go <= '1';
                    meta_future.state        <= META_DOWNCOUNT;
                    meta_future.meta_pkt_sop <= '1';
                else
                    meta_future.meta_time_go <= '0';
                end if;

            when META_DOWNCOUNT =>

                meta_future.meta_time_go  <= '1';
                if( packet_en = '0' ) then
                   if( fifo_current.fifo_read = '1') then
                      meta_future.dma_downcount <= meta_current.dma_downcount - NUM_STREAMS;
                   end if;
                   if( meta_current.dma_downcount <= NUM_STREAMS ) then
                       -- Look for 2 because of the 2 cycles passing
                       -- through META_LOAD and META_WAIT after this.
                       meta_future.state <= META_LOAD;
                   end if;
                else
                   if( fifo_current.packet_control.data_valid = '1') then
                      meta_future.dma_downcount <= meta_current.dma_downcount - 1;
                   end if;
                   if( meta_current.dma_downcount <= 1 and packet_ready = '1' ) then
                       meta_future.state <= META_LOAD;
                       meta_future.meta_pkt_eop <= '1';
                   end if;
                end if;

                if( meta_current.meta_cache(0) = '1' ) then
                   meta_future.skip_padding <= '1';
                end if;

            when others =>

                meta_future.state <= META_LOAD;

        end case;

        -- Abort?
        if( (enable = '0') or (meta_en = '0') ) then
            meta_future <= META_FSM_RESET_VALUE;
        end if;

        -- Output assignments
        meta_fifo_read <= meta_current.meta_read;

    end process;


    -- ------------------------------------------------------------------------
    -- SAMPLE FIFO FSM
    -- ------------------------------------------------------------------------

    ts_busy_s <= '0' when ts_busy_g1 = '0' and ts_busy_g2 = '0' else '1';

    -- Sample FIFO synchronous process
    fifo_fsm_sync : process( fifo_clock, reset )
    begin
        if( reset = '1' ) then
            fifo_current <= FIFO_FSM_RESET_VALUE;
            cntr_pres_s <= 0;
        elsif( rising_edge(fifo_clock) ) then
            fifo_current <= fifo_future;
            cntr_pres_s <= cntr_fut_s;
        elsif( falling_edge(fifo_clock) ) then
            fifo_read_pres_s <= fifo_read_fut_s;
        end if;
    end process;

    -- Sample FIFO combinatorial process
    fifo_fsm_comb : process( all )
    begin

        fifo_future <= fifo_current;

        fifo_future.fifo_read <= '0';
        fifo_future.packet_control.pkt_sop <= meta_current.meta_pkt_sop;

        fifo_future.packet_control.data_valid <= '0';
        
        fifo_future.out_samples <= fifo_data;
        start_cntr_s <= '0';

        case fifo_current.state is

            when IDLE_READ =>

                fifo_future.downcount <= FIFO_FSM_RESET_VALUE.downcount;

                if( fifo_holdoff = '1' ) then
                    -- Pause for a spell
                    fifo_future.state <= READ_HOLDOFF;

                elsif( fifo_empty = '0' and ts_busy_g1 = '0' ) then
                        fifo_future.state <= WRITE_TS;

                        if( FIFO_FSM_RESET_VALUE.downcount /= 0 ) then
                            fifo_future.state <= READ_THROTTLE;
                        end if;
                end if;

            when WRITE_TS =>
                if fifo_empty = '1' or ts_busy_g1 = '1' then 
                    fifo_future.state <= IDLE_READ;
                else
                    fifo_future.state <= WRITE_TS;
                    start_cntr_s <= '1';
                end if;

            when READ_THROTTLE =>

                -- If in this state, downcount is guaranteed to be >= 1
                if( fifo_current.downcount = 1 ) then
                    fifo_future.state     <= IDLE_READ;
                else
                    fifo_future.downcount <= fifo_current.downcount - 1;
                end if;

            when READ_HOLDOFF =>

                if( fifo_holdoff = '0' ) then
                    fifo_future.state <= IDLE_READ;
                end if;

            when others =>

                fifo_future.state <= FIFO_FSM_RESET_VALUE.state;

        end case;

        -- Abort?
        if( enable = '0' ) then
            fifo_future.fifo_read <= '0';
            fifo_future.state     <= FIFO_FSM_RESET_VALUE.state;
        end if;

        if( fifo_empty = '1' and packet_en = '0' ) then
            -- Re-evaluate the MIMO settings
            fifo_future.state <= FIFO_FSM_RESET_VALUE.state;
        end if;

        -- Output assignments
        out_samples <= fifo_current.out_samples;

        packet_control <= fifo_current.packet_control;

    end process;

    cntr_fut_s <=   0 when cntr_pres_s = 3 and start_cntr_s = '1' else
                    cntr_pres_s + 1 when start_cntr_s = '1' else 
                    cntr_pres_s;

    ts_data         <= fifo_data(((cntr_pres_s+1)*8)-1 downto (cntr_pres_s*8));
    ts_valid        <= '1' when start_cntr_s = '1' else '0';
    fifo_read_fut_s <= '1' when cntr_pres_s = 3 else '0';
    fifo_read       <= fifo_read_pres_s;

    -- ------------------------------------------------------------------------
    -- UNDERFLOW
    -- ------------------------------------------------------------------------

    -- Underflow detection
    detect_underflows : process( fifo_clock, reset )
    begin
        if( reset = '1' ) then
            underflow_detected <= '0';
        elsif( rising_edge( fifo_clock ) ) then
            underflow_detected <= '0';
            if( enable = '1' and fifo_empty = '1' and
                (meta_en = '0' or (meta_en = '1' and meta_current.meta_time_go = '1')) ) then
                underflow_detected <= '1';
            end if;
        end if;
    end process;

    -- Count the number of times we underflow, but only if they are discontinuous
    -- meaning we have an underflow condition, a non-underflow condition, then
    -- another underflow condition counts as 2 underflows, but an underflow condition
    -- followed by N underflow conditions counts as a single underflow condition.
    count_underflows : process( fifo_clock, reset )
        variable prev_underflow : std_logic := '0';
    begin
        if( reset = '1' ) then
            prev_underflow  := '0';
            underflow_count <= (others =>'0');
        elsif( rising_edge( fifo_clock ) ) then
            if( prev_underflow = '0' and underflow_detected = '1' ) then
                underflow_count <= underflow_count + 1;
            end if;
            prev_underflow := underflow_detected;
        end if;
    end process;

    -- Active high assertion for underflow_duration when the underflow
    -- condition has been detected.  The LED will stay asserted
    -- if multiple underflows have occurred
    blink_underflow_led : process( fifo_clock, reset )
        variable downcount : natural range 0 to 2**underflow_duration'length-1 := 0;
    begin
        if( reset = '1' ) then
            downcount     := 0;
            underflow_led <= '0';
        elsif( rising_edge(fifo_clock) ) then
            -- Default to not being asserted
            underflow_led <= '0';

            -- Countdown so we can see what happened
            if( downcount /= 0 ) then
                downcount     := downcount - 1;
                underflow_led <= '1';
            end if;

            -- Underflow occurred so light it up
            if( underflow_detected = '1' ) then
                downcount := to_integer(underflow_duration);
            end if;
        end if;
    end process;

end architecture;