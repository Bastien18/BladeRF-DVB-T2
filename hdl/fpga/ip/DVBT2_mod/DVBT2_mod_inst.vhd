	component DVBT2_mod is
		port (
			clock            : in  std_logic                     := 'X';             -- clk
			reset_n          : in  std_logic                     := 'X';             -- reset_n
			reg_address      : in  std_logic_vector(19 downto 0) := (others => 'X'); -- address
			reg_wr_data      : in  std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			reg_wr_en        : in  std_logic                     := 'X';             -- write
			reg_chip_en      : in  std_logic                     := 'X';             -- chipselect
			reg_rd_data      : out std_logic_vector(31 downto 0);                    -- readdata
			reg_cmd_ack      : out std_logic;                                        -- waitrequest_n
			reg_irq          : out std_logic;                                        -- irq
			ts_data_clk      : in  std_logic                     := 'X';             -- clk
			ts_data_valid    : in  std_logic                     := 'X';             -- data_valid
			ts_data          : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- data
			ts_data_refclk   : out std_logic;                                        -- data_refclk
			ts_data_busy     : out std_logic;                                        -- data_busy
			ram_cs           : out std_logic;                                        -- cs
			ram_burst_access : out std_logic;                                        -- burst_access
			ram_burst_size   : out std_logic_vector(3 downto 0);                     -- burst_size
			ram_address      : out std_logic_vector(23 downto 0);                    -- address
			ram_wr_en        : out std_logic;                                        -- wr_en
			ram_wrdata       : out std_logic_vector(31 downto 0);                    -- wrdata
			ram_rd_en        : out std_logic;                                        -- rd_en
			ram_rddata       : in  std_logic_vector(31 downto 0) := (others => 'X'); -- rddata
			ram_rddata_valid : in  std_logic                     := 'X';             -- rddata_valid
			ram_busy         : in  std_logic                     := 'X';             -- busy
			ram_available    : in  std_logic                     := 'X';             -- available
			ram_empty        : in  std_logic                     := 'X';             -- empty
			fft_wr_addr      : out std_logic_vector(18 downto 0);                    -- fft_wr_addr
			fft_wr_data      : out std_logic_vector(35 downto 0);                    -- fft_wr_data
			fft_wr_ena       : out std_logic;                                        -- fft_wr_ena
			fft_rd_addr      : out std_logic_vector(18 downto 0);                    -- fft_rd_addr
			fft_rd_data      : in  std_logic_vector(35 downto 0) := (others => 'X'); -- fft_rd_data
			osg_wr_addr      : out std_logic_vector(18 downto 0);                    -- osg_wr_addr
			osg_wr_data      : out std_logic_vector(35 downto 0);                    -- osg_wr_data
			osg_wr_ena       : out std_logic;                                        -- osg_wr_ena
			osg_rd_addr      : out std_logic_vector(18 downto 0);                    -- osg_rd_addr
			osg_rd_data      : in  std_logic_vector(35 downto 0) := (others => 'X'); -- osg_rd_data
			baseband_i       : out std_logic_vector(13 downto 0);                    -- i
			baseband_q       : out std_logic_vector(13 downto 0);                    -- q
			baseband_valid   : out std_logic                                         -- valid
		);
	end component DVBT2_mod;

	u0 : component DVBT2_mod
		port map (
			clock            => CONNECTED_TO_clock,            -- cms0041_clock.clk
			reset_n          => CONNECTED_TO_reset_n,          --       reset_n.reset_n
			reg_address      => CONNECTED_TO_reg_address,      --  avalon_slave.address
			reg_wr_data      => CONNECTED_TO_reg_wr_data,      --              .writedata
			reg_wr_en        => CONNECTED_TO_reg_wr_en,        --              .write
			reg_chip_en      => CONNECTED_TO_reg_chip_en,      --              .chipselect
			reg_rd_data      => CONNECTED_TO_reg_rd_data,      --              .readdata
			reg_cmd_ack      => CONNECTED_TO_reg_cmd_ack,      --              .waitrequest_n
			reg_irq          => CONNECTED_TO_reg_irq,          --           irq.irq
			ts_data_clk      => CONNECTED_TO_ts_data_clk,      --        TS_Clk.clk
			ts_data_valid    => CONNECTED_TO_ts_data_valid,    --            TS.data_valid
			ts_data          => CONNECTED_TO_ts_data,          --              .data
			ts_data_refclk   => CONNECTED_TO_ts_data_refclk,   --              .data_refclk
			ts_data_busy     => CONNECTED_TO_ts_data_busy,     --              .data_busy
			ram_cs           => CONNECTED_TO_ram_cs,           --           RAM.cs
			ram_burst_access => CONNECTED_TO_ram_burst_access, --              .burst_access
			ram_burst_size   => CONNECTED_TO_ram_burst_size,   --              .burst_size
			ram_address      => CONNECTED_TO_ram_address,      --              .address
			ram_wr_en        => CONNECTED_TO_ram_wr_en,        --              .wr_en
			ram_wrdata       => CONNECTED_TO_ram_wrdata,       --              .wrdata
			ram_rd_en        => CONNECTED_TO_ram_rd_en,        --              .rd_en
			ram_rddata       => CONNECTED_TO_ram_rddata,       --              .rddata
			ram_rddata_valid => CONNECTED_TO_ram_rddata_valid, --              .rddata_valid
			ram_busy         => CONNECTED_TO_ram_busy,         --              .busy
			ram_available    => CONNECTED_TO_ram_available,    --              .available
			ram_empty        => CONNECTED_TO_ram_empty,        --              .empty
			fft_wr_addr      => CONNECTED_TO_fft_wr_addr,      --           QDR.fft_wr_addr
			fft_wr_data      => CONNECTED_TO_fft_wr_data,      --              .fft_wr_data
			fft_wr_ena       => CONNECTED_TO_fft_wr_ena,       --              .fft_wr_ena
			fft_rd_addr      => CONNECTED_TO_fft_rd_addr,      --              .fft_rd_addr
			fft_rd_data      => CONNECTED_TO_fft_rd_data,      --              .fft_rd_data
			osg_wr_addr      => CONNECTED_TO_osg_wr_addr,      --              .osg_wr_addr
			osg_wr_data      => CONNECTED_TO_osg_wr_data,      --              .osg_wr_data
			osg_wr_ena       => CONNECTED_TO_osg_wr_ena,       --              .osg_wr_ena
			osg_rd_addr      => CONNECTED_TO_osg_rd_addr,      --              .osg_rd_addr
			osg_rd_data      => CONNECTED_TO_osg_rd_data,      --              .osg_rd_data
			baseband_i       => CONNECTED_TO_baseband_i,       --      Baseband.i
			baseband_q       => CONNECTED_TO_baseband_q,       --              .q
			baseband_valid   => CONNECTED_TO_baseband_valid    --              .valid
		);

