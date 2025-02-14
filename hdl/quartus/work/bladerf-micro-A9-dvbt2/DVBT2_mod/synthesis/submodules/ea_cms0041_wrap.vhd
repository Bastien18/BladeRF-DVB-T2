LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

LIBRARY cms0041_lib;

ENTITY cms0041_wrap IS 
  GENERIC ( BUILD_DEVICE_FAMILY              : STRING  := "ALT_GENERIC";
            BUILD_BROADCAST_ONLY             : INTEGER := 0;
            BUILD_SDRAM_WORD_ADDR_WIDTH      : INTEGER := 24;  
            BUILD_CODE_CONFIG                : INTEGER := -1;
            BUILD_SHORT_CONFIG               : INTEGER := -1;
            BUILD_QAM_CONFIG                 : INTEGER := -1;
            BUILD_CPU_BYTE_ADDR_WIDTH        : INTEGER := 20;
            BUILD_T2ADAPT                    : INTEGER := 0;       
            BUILD_T2MI                       : INTEGER := 0;       
            BUILD_L1ACE_PROCESSOR            : INTEGER := 0;      
            BUILD_IDV_ADDR_EXTRACTION        : INTEGER := 0;      
            BUILD_P2_BIAS_CELLS              : INTEGER := 0;
            BUILD_INPUT_SMOOTHING_FIFO       : INTEGER := 0;
            CLOCK_FREQUENCY_KHZ              : INTEGER := 100000; 
            CLOCK_RIF_FREQUENCY_KHZ          : INTEGER := 0;
            BUILD_RIF                        : INTEGER := 0;
            BUILD_BASE_TO_IF                 : INTEGER := 0;
            BUILD_PRE_DISTORT                : INTEGER := 0;
            BUILD_INBAND_EQUALISER           : INTEGER := 0;
            BUILD_FEF_SUPPORT                : INTEGER := 0;
            BUILD_MAX_FFT_SIZE               : INTEGER := 32768;
            BUILD_PAPR                       : INTEGER := 0;
            BUILD_FFT_WINDOW                 : INTEGER := 0;
            BUILD_CRITICAL_FILTER            : INTEGER := 1;
            BUILD_IF_ONLY                    : INTEGER := 0;
            BUILD_PCR_SUPPORT                : INTEGER := 0;
            BUILD_CALCULATE_TS_RATE          : INTEGER := 0;
            BUILD_PRBS_PACKETS               : INTEGER := 0;
            BUILD_CITL_CACHE                 : INTEGER := 0;
            BUILD_OSG_USE_EXTERNAL_RAM       : INTEGER := 1;
            BUILD_T2ADAPT_USE_EXTERNAL_RAM   : INTEGER := 1;
            BUILD_SUPPORTED_PLP_NUM          : INTEGER := 1;
            BUILD_SFN_SUPPORT                : INTEGER := 0;
            BUILD_AD9857_SUPPORT             : INTEGER := 0;
            BUILD_AD9957_SUPPORT             : INTEGER := 0;
            BUILD_AD9789_SUPPORT             : INTEGER := 0;
            BUILD_REGBANK_INITIALISATION     : INTEGER := 0;
            BUILD_RAM_TEST_SUPPORT           : INTEGER := 0;
            BUILD_IDV_ADDR_PROCESSOR         : INTEGER := 0;
            BUILD_PLL_PROGRAM                : INTEGER := 0;
            PLL_PROG_CLOCK_FREQUENCY_KHZ     : INTEGER := 0;
            BUILD_DAC_PROGRAM                : INTEGER := 0;
            DAC_PROG_CLOCK_FREQUENCY_KHZ     : INTEGER := 0 );

  PORT(
    clock                     : IN  STD_LOGIC;                                                 -- System clock
    clock_x2                  : IN  STD_LOGIC := '0';                                          -- System clock x2 - only required for internal OSG memory
    clock_rif                 : IN  STD_LOGIC := '0';                                          -- Radio interface clock
    reset_n                   : IN  STD_LOGIC;                                                 -- Active-low asynchronous reset
  
    -- Processor Interface
    reg_address               : IN  STD_LOGIC_VECTOR(BUILD_CPU_BYTE_ADDR_WIDTH-1 DOWNTO 0);    -- Processor interface address
    reg_wr_data               : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);                             -- Processor interface write data
    reg_wr_en                 : IN  STD_LOGIC;                                                 -- Processor Interface write enable 
    reg_chip_en               : IN  STD_LOGIC;                                                 -- Processor Interface chip enable 
    reg_rd_data               : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);                             -- Processor interface read data
    reg_irq                   : OUT STD_LOGIC;                                                 -- Processor interface interrupt
    reg_cmd_ack               : OUT STD_LOGIC;
    
    -- TS interface
    ts_data_sync              : IN  STD_LOGIC := '0';                                          -- Transport Stream Input Sync
    ts_data_valid             : IN  STD_LOGIC := '0';                                          -- Transport Stream Input Valid
    ts_data                   : IN  STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');           -- Transport Stream Input
    ts_data_rdy               : OUT STD_LOGIC;                                                 -- TS Data interface ready
    ts_data_busy              : OUT STD_LOGIC;                                                 -- TS Data interface busy
    -- CY7B9334/ASI interface
    ts_data_rvs               : IN  STD_LOGIC := '0';       
    ts_data_scd               : IN  STD_LOGIC := '0';       
    ts_reframe_enable         : OUT STD_LOGIC;                                                 --  Reframe enable pin
    -- TS PCR interface
    ts_data_clk               : IN  STD_LOGIC := '0';                                          -- Transport Stream Input Clock
    ts_data_refclk            : OUT STD_LOGIC;                                                 -- Transport Stream reference Clock


    -- SFN interface
    clock_1s                  : IN  STD_LOGIC := '0';                                          -- 1 second pps clock (single core clock_rif pulse)
    seconds_since_2000        : IN  STD_LOGIC_VECTOR(39 DOWNTO 0) := (OTHERS => '0');          -- SFN absolute timestamp seconds reference - latched with clock_1s

    -- Baseband symbol output at clock rate
    baseband_i                : OUT   STD_LOGIC_VECTOR(13 DOWNTO 0);
    baseband_q                : OUT   STD_LOGIC_VECTOR(13 DOWNTO 0);
    baseband_valid            : OUT   STD_LOGIC;
    
    -- Radio-Interface
    dac_data_i                : OUT   STD_LOGIC_VECTOR(13 DOWNTO 0);
    dac_data_q                : OUT   STD_LOGIC_VECTOR(13 DOWNTO 0);
    
    -- AD9857 Interface
    ad9857_pdclk              : IN    STD_LOGIC := '0';                                          -- AD9857 PDClock
    ad9857_data               : OUT   STD_LOGIC_VECTOR(13 DOWNTO 0);                             -- AD9857 multiplexed databus
    ad9857_txenable           : OUT   STD_LOGIC;                                                 -- AD9857 databus strobe
    
    -- AD9957 Interface
    ad9957_pdclk              : IN    STD_LOGIC := '0';                                          -- AD9957 PDClock
    ad9957_data               : OUT   STD_LOGIC_VECTOR(17 DOWNTO 0);                             -- AD9957 multiplexed databus
    ad9957_txenable           : OUT   STD_LOGIC;                                                 -- AD9957 databus strobe    
    
    -- AD9789 Interface
    ad9789_dco                : IN    STD_LOGIC := '0';                                          -- AD9789 DCO Clock
    ad9789_fs                 : IN    STD_LOGIC := '0';                                          -- AD9789 FS strobe
    ad9789_data_i             : OUT   STD_LOGIC_VECTOR(15 DOWNTO 0);                             -- AD9789 I databus 
    ad9789_data_q             : OUT   STD_LOGIC_VECTOR(15 DOWNTO 0);                             -- AD9789 Q databus 
    
    -- DAC programming...
    clock_dac_prog            : IN  STD_LOGIC := '0';                                            -- Independent clock used to drive DAC serial programming logic.
                                                                                                 -- If DAC_PROG_CLOCK_FREQUENCY_KHZ=0, the clock port is used.
                                                                                                 -- (Typically used to allow the DAC to be programmed by the FPGA
                                                                                                 --    when the DAC generates the main system clocks - e.g. the clock port ).
    dac_prog_complete         : OUT STD_LOGIC;                                                   -- Active-high flag indicating programming has been completed and DAC locked
    dac_prog_reset_n          : IN  STD_LOGIC := '1';                                            -- Independent active-low reset used to drive DAC serial programming logic
                                                                                                 --    reset line when DAC_PROG_CLOCK_FREQUENCY_KHZ /= 0
    -- AD9857 serial interface
    ad9857_reset              : OUT STD_LOGIC;                          
    ad9857_sclk               : OUT STD_LOGIC;                          
    ad9857_sdio               : OUT STD_LOGIC;
    ad9857_sdo                : IN  STD_LOGIC := '0';
    -- Optional, but can be ommitted to reduce pinout
    ad9857_pll_lock           : IN  STD_LOGIC := '1';                                            -- AD9857 PLL locked flag (tie high into core if ommitted)
    ad9857_cs_n               : OUT STD_LOGIC;                                                   -- Tie-low on AD9857 if ommitted
    ad9857_sync_io            : OUT STD_LOGIC;                                                   -- Tie-low on AD9857 if ommittedS
    
    -- AD9957 serial interface
    ad9957_reset              : OUT STD_LOGIC;                          
    ad9957_sclk               : OUT STD_LOGIC;                          
    ad9957_sdio               : OUT STD_LOGIC;
    ad9957_sdo                : IN  STD_LOGIC := '0';
    ad9957_io_update          : OUT STD_LOGIC;                                        
    -- Optional, but can be ommitted to reduce pinout
    ad9957_pll_lock           : IN  STD_LOGIC := '1';                                            -- AD9957 PLL locked flag (tie high into core if ommitted)
    ad9957_cs_n               : OUT STD_LOGIC;                                                   -- Tie-low on AD9957 if ommitted
    ad9957_sync_io            : OUT STD_LOGIC;                                                   -- Tie-low on AD9957 if ommitted
    
    -- AD9789 serial interface
    ad9789_reset              : OUT STD_LOGIC;                                        
    ad9789_sclk               : OUT STD_LOGIC;                                        
    ad9789_sdio               : OUT STD_LOGIC;                                        
    ad9789_sdo                : IN  STD_LOGIC := '0';                                 
    -- Optional, but can be ommitted to reduce pinout
    ad9789_cs_n               : OUT STD_LOGIC;                                                   -- Tie-low on AD9789 if ommitted
    ad9789_dco_fpga_pll_reset : OUT STD_LOGIC;                                                   -- '1' - hold FPGA PLL for DCO clock in reset
    ad9789_dco_pll_locked     : IN  STD_LOGIC := '1';                                            -- Active-high flag indicating that the FPGA PLL for the AD9789 DCO clock is locked.
    
    
    
    -- PLL programming...
    clock_pll_prog            : IN  STD_LOGIC := '0';                                            -- Independent clock used to drive PLL serial programming logic.
                                                                                                 -- If PLL_PROG_CLOCK_FREQUENCY_KHZ=0, the clock port is used.
                                                                                                 -- (Typically used to allow the PLL to be programmed by the FPGA
                                                                                                 --    when the PLL generates the main system clocks - e.g. the clock port ).
    pll_prog_complete         : OUT STD_LOGIC;                                                   -- Active-high flag indicating programming has been completed and PLL locked
    pll_prog_reset_n          : IN  STD_LOGIC := '1';                                            -- Independent active-low reset used to drive PLL serial programming logic
                                                                                                 --    reset line when PLL_PROG_CLOCK_FREQUENCY_KHZ /= 0
    -- AD9516 serial interface
    ad9516_reset_n            : OUT STD_LOGIC;                                                 
    ad9516_sclk               : OUT STD_LOGIC;                                                 
    ad9516_sdio               : OUT STD_LOGIC;                                                 
    ad9516_sdo                : IN  STD_LOGIC := '0';
    -- Optional, but can be ommitted to reduce pinout
    ad9516_ld                 : IN  STD_LOGIC := '1';                                            -- PLL Lock detect output from AD9516
    ad9516_cs_n               : OUT STD_LOGIC;                                                   -- Tie-low on AD9516 if ommitted
    
    -- ADF4350 serial interface
    adf4350_clk               : OUT STD_LOGIC;                                          
    adf4350_data              : OUT STD_LOGIC;                                          
    adf4350_le                : OUT STD_LOGIC;                                          
    -- Optional, but can be ommitted to reduce pinout
    adf4350_ld                : IN  STD_LOGIC := '1';                                            -- PLL Lock detect output from ADF4350
  
    -- External Memory interface...
    ram_cs                    : OUT STD_LOGIC;                                                   -- Active-high external RAM chip-select
    ram_burst_access          : OUT STD_LOGIC;                                                   -- Active-high external RAM burst-access enable (indicates that this is the start of 
                                                                                                 --   a multiple write or read from consecutive addresses).
    ram_burst_size            : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);                                -- Number of words within the RAM burst                                                                 
    ram_address               : OUT STD_LOGIC_VECTOR(BUILD_SDRAM_WORD_ADDR_WIDTH-1 DOWNTO 0);
    ram_wr_en                 : OUT STD_LOGIC;                                                   -- Active-high external RAM write-enable
    ram_wrdata                : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    ram_rd_en                 : OUT STD_LOGIC;                                                   -- Active-high external RAM read-enable
    ram_rddata                : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
    ram_rddata_valid          : IN  STD_LOGIC;                                                   -- Active-high external RAM read-data valid .. indicates that ram_rddata should be latched
    ram_busy                  : IN  STD_LOGIC;                                                   -- Active-high external RAM is busy - stop sending commands as soon as possible
    ram_available             : IN  STD_LOGIC;                                                   -- Active-high external RAM is available for more commands
    ram_empty                 : IN  STD_LOGIC;                                                   -- Active-high flag indicating all external RAMs are empty - used for initialisation following
                                                                                                 --   reset
    -- External Memory interface auto testing ..
    ram_test_running          : OUT STD_LOGIC;
    ram_test_complete         : OUT STD_LOGIC;
    ram_test_pass             : OUT STD_LOGIC;
    ram_test_error            : OUT STD_LOGIC;

    -- QDR Memory interface...
    fft_wr_addr               : OUT STD_LOGIC_VECTOR(18 DOWNTO 0);
    fft_wr_data               : OUT STD_LOGIC_VECTOR(35 DOWNTO 0);
    fft_wr_ena                : OUT STD_LOGIC;
    fft_rd_addr               : OUT STD_LOGIC_VECTOR(18 DOWNTO 0);
    fft_rd_data               : IN  STD_LOGIC_VECTOR(35 DOWNTO 0) := (OTHERS => '0');

    osg_wr_addr               : OUT STD_LOGIC_VECTOR(18 DOWNTO 0);
    osg_wr_data               : OUT STD_LOGIC_VECTOR(35 DOWNTO 0);
    osg_wr_ena                : OUT STD_LOGIC;
    osg_rd_addr               : OUT STD_LOGIC_VECTOR(18 DOWNTO 0);
    osg_rd_data               : IN  STD_LOGIC_VECTOR(35 DOWNTO 0) := (OTHERS => '0') );
END cms0041_wrap;



ARCHITECTURE rtl OF cms0041_wrap IS

  COMPONENT cms0041 GENERIC ( BUILD_DEVICE_FAMILY              : STRING;
                              BUILD_BROADCAST_ONLY             : INTEGER := 0;
                              BUILD_CODE_CONFIG                : INTEGER := -1;
                              BUILD_SHORT_CONFIG               : INTEGER := -1;
                              BUILD_QAM_CONFIG                 : INTEGER := -1;
                              BUILD_CPU_BYTE_ADDR_WIDTH        : INTEGER := 20;
                              BUILD_T2ADAPT                    : INTEGER := 0;       
                              BUILD_T2MI                       : INTEGER := 0;       
                              BUILD_L1ACE_PROCESSOR            : INTEGER := 0;      
                              BUILD_IDV_ADDR_EXTRACTION        : INTEGER := 0;      
                              BUILD_P2_BIAS_CELLS              : INTEGER := 0;
                              BUILD_INPUT_SMOOTHING_FIFO       : INTEGER := 0;
                              CLOCK_FREQUENCY_KHZ              : INTEGER := 100000; 
                              CLOCK_RIF_FREQUENCY_KHZ          : INTEGER := 0;
                              BUILD_RIF                        : INTEGER := 0;
                              BUILD_BASE_TO_IF                 : INTEGER := 0;
                              BUILD_PRE_DISTORT                : INTEGER := 0;
                              BUILD_INBAND_EQUALISER           : INTEGER := 0;
                              BUILD_FEF_SUPPORT                : INTEGER := 0;
                              BUILD_MAX_FFT_SIZE               : INTEGER := 32768;
                              BUILD_PAPR                       : INTEGER := 0;
                              BUILD_FFT_WINDOW                 : INTEGER := 0;
                              BUILD_CRITICAL_FILTER            : INTEGER := 1;
                              BUILD_IF_ONLY                    : INTEGER := 0;
                              BUILD_PCR_SUPPORT                : INTEGER := 0;
                              BUILD_CALCULATE_TS_RATE          : INTEGER := 0;
                              BUILD_PRBS_PACKETS               : INTEGER := 0;
                              BUILD_CITL_CACHE                 : INTEGER := 0;
                              BUILD_OSG_USE_EXTERNAL_RAM       : INTEGER := 1;
                              BUILD_T2ADAPT_USE_EXTERNAL_RAM   : INTEGER := 1;
                              BUILD_SUPPORTED_PLP_NUM          : INTEGER := 1;
                              BUILD_SFN_SUPPORT                : INTEGER := 0;
                              BUILD_AD9857_SUPPORT             : INTEGER := 0;
                              BUILD_AD9957_SUPPORT             : INTEGER := 0;
                              BUILD_AD9789_SUPPORT             : INTEGER := 0;
                              BUILD_REGBANK_INITIALISATION     : INTEGER := 0;
                              BUILD_RAM_TEST_SUPPORT           : INTEGER := 0;
                              BUILD_IDV_ADDR_PROCESSOR         : INTEGER := 0;
                              BUILD_PLL_PROGRAM                : INTEGER := 0;
                              PLL_PROG_CLOCK_FREQUENCY_KHZ     : INTEGER := 0;
                              BUILD_DAC_PROGRAM                : INTEGER := 0;
                              DAC_PROG_CLOCK_FREQUENCY_KHZ     : INTEGER := 0 );
                              
                              
  PORT (
    clock                     : IN  STD_LOGIC;                                                 -- System clock
    clock_x2                  : IN  STD_LOGIC := '0';                                          -- System clock x2 - only required for internal OSG memory
    clock_rif                 : IN  STD_LOGIC := '0';                                          -- Radio interface clock
    reset_n                   : IN  STD_LOGIC;                                                 -- Active-low asynchronous reset
  
    -- Processor Interface
    reg_address               : IN  STD_LOGIC_VECTOR(BUILD_CPU_BYTE_ADDR_WIDTH-1 DOWNTO 0);    -- Processor interface address
    reg_wr_data               : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);                             -- Processor interface write data
    reg_wr_en                 : IN  STD_LOGIC;                                                 -- Processor Interface write enable 
    reg_chip_en               : IN  STD_LOGIC;                                                 -- Processor Interface chip enable 
    reg_rd_data               : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);                             -- Processor interface read data
    reg_irq                   : OUT STD_LOGIC;                                                 -- Processor interface interrupt
    reg_cmd_ack               : OUT STD_LOGIC;
    
    -- TS interface
    ts_data_sync              : IN  STD_LOGIC := '0';                                          -- Transport Stream Input Sync
    ts_data_valid             : IN  STD_LOGIC := '0';                                          -- Transport Stream Input Valid
    ts_data                   : IN  STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');           -- Transport Stream Input
    ts_data_rdy               : OUT STD_LOGIC;                                                 -- TS Data interface ready
    ts_data_busy              : OUT STD_LOGIC;                                                 -- TS Data interface busy
    -- CY7B9334/ASI interface
    ts_data_rvs               : IN  STD_LOGIC := '0';       
    ts_data_scd               : IN  STD_LOGIC := '0';       
    ts_reframe_enable         : OUT STD_LOGIC;                                                 --  Reframe enable pin
    -- TS PCR interface
    ts_data_clk               : IN  STD_LOGIC := '0';                                          -- Transport Stream Input Clock
    ts_data_refclk            : OUT STD_LOGIC;                                                 -- Transport Stream reference Clock

    -- SFN interface
    clock_1s                  : IN  STD_LOGIC := '0';                                          -- 1 second pps clock (single core clock_rif pulse)
    seconds_since_2000        : IN  STD_LOGIC_VECTOR(39 DOWNTO 0) := (OTHERS => '0');          -- SFN absolute timestamp seconds reference - latched with clock_1s


    -- Baseband symbol output at clock rate
    baseband_i                : OUT STD_LOGIC_VECTOR(13 DOWNTO 0);
    baseband_q                : OUT STD_LOGIC_VECTOR(13 DOWNTO 0);
    baseband_valid            : OUT STD_LOGIC;
    
    -- Radio-Interface
    dac_data_i                : OUT STD_LOGIC_VECTOR(13 DOWNTO 0);
    dac_data_q                : OUT STD_LOGIC_VECTOR(13 DOWNTO 0);
    
    -- AD9857 Interface
    ad9857_pdclk              : IN  STD_LOGIC := '0';                                          -- AD9857 PDClock
    ad9857_data               : OUT STD_LOGIC_VECTOR(13 DOWNTO 0);                             -- AD9857 multiplexed databus
    ad9857_txenable           : OUT STD_LOGIC;                                                 -- AD9857 databus strobe
    
    -- AD9957 Interface
    ad9957_pdclk              : IN    STD_LOGIC := '0';                                        -- AD9957 PDClock
    ad9957_data               : OUT   STD_LOGIC_VECTOR(17 DOWNTO 0);                           -- AD9957 multiplexed databus
    ad9957_txenable           : OUT   STD_LOGIC;                                               -- AD9957 databus strobe    
    
    -- AD9789 Interface
    ad9789_dco                : IN  STD_LOGIC := '0';                                          -- AD9789 DCO Clock
    ad9789_fs                 : IN  STD_LOGIC := '0';                                          -- AD9789 FS strobe
    ad9789_data_i             : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);                             -- AD9789 I databus 
    ad9789_data_q             : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);                             -- AD9789 Q databus 
    
    -- DAC programming...
    clock_dac_prog            : IN  STD_LOGIC := '0';                                          -- Independent clock used to drive DAC serial programming logic.
                                                                                               -- If DAC_PROG_CLOCK_FREQUENCY_KHZ=0, the clock port is used.
                                                                                               -- (Typically used to allow the DAC to be programmed by the FPGA
                                                                                               --    when the DAC generates the main system clocks - e.g. the clock port ).
    dac_prog_complete         : OUT STD_LOGIC;                                                 -- Active-high flag indicating programming has been completed and DAC locked
    dac_prog_reset_n          : IN  STD_LOGIC := '1';                                          -- Independent active-low reset used to drive DAC serial programming logic
                                                                                               --    reset line when DAC_PROG_CLOCK_FREQUENCY_KHZ /= 0
    -- AD9857 serial interface
    ad9857_reset              : OUT STD_LOGIC;                          
    ad9857_sclk               : OUT STD_LOGIC;                          
    ad9857_sdio               : OUT STD_LOGIC;
    ad9857_sdo                : IN  STD_LOGIC := '0';
    -- Optional, but can be ommitted to reduce pinout
    ad9857_pll_lock           : IN  STD_LOGIC := '1';                                          -- AD9857 PLL locked flag (tie high into core if ommitted)
    ad9857_cs_n               : OUT STD_LOGIC;                                                 -- Tie-low on AD9857 if ommitted
    ad9857_sync_io            : OUT STD_LOGIC;                                                 -- Tie-low on AD9857 if ommittedS
    
    -- AD9957 serial interface
    ad9957_reset              : OUT STD_LOGIC;                          
    ad9957_sclk               : OUT STD_LOGIC;                          
    ad9957_sdio               : OUT STD_LOGIC;
    ad9957_sdo                : IN  STD_LOGIC := '0';
    ad9957_io_update          : OUT STD_LOGIC;                                        
    -- Optional, but can be ommitted to reduce pinout
    ad9957_pll_lock           : IN  STD_LOGIC := '1';                                          -- AD9957 PLL locked flag (tie high into core if ommitted)
    ad9957_cs_n               : OUT STD_LOGIC;                                                 -- Tie-low on AD9957 if ommitted
    ad9957_sync_io            : OUT STD_LOGIC;                                                 -- Tie-low on AD9957 if ommitted
    
    -- AD9789 serial interface
    ad9789_reset              : OUT STD_LOGIC;                                        
    ad9789_sclk               : OUT STD_LOGIC;                                        
    ad9789_sdio               : OUT STD_LOGIC;                                        
    ad9789_sdo                : IN  STD_LOGIC := '0';                                 
    -- Optional, but can be ommitted to reduce pinout
    ad9789_cs_n               : OUT STD_LOGIC;                                                 -- Tie-low on AD9789 if ommitted
    ad9789_dco_fpga_pll_reset : OUT STD_LOGIC;                                                 -- '1' - hold FPGA PLL for DCO clock in reset
    ad9789_dco_pll_locked     : IN  STD_LOGIC := '1';                                          -- Active-high flag indicating that the FPGA PLL for the AD9789 DCO clock is locked.
    
    
    
    -- PLL programming...
    clock_pll_prog            : IN  STD_LOGIC := '0';                                          -- Independent clock used to drive PLL serial programming logic.
                                                                                               -- If PLL_PROG_CLOCK_FREQUENCY_KHZ=0, the clock port is used.
                                                                                               -- (Typically used to allow the PLL to be programmed by the FPGA
                                                                                               --    when the PLL generates the main system clocks - e.g. the clock port ).
    pll_prog_complete         : OUT STD_LOGIC;                                                 -- Active-high flag indicating programming has been completed and PLL locked
    pll_prog_reset_n          : IN  STD_LOGIC := '1';                                          -- Independent active-low reset used to drive PLL serial programming logic
                                                                                               --    reset line when PLL_PROG_CLOCK_FREQUENCY_KHZ /= 0
    -- AD9516 serial interface
    ad9516_reset_n            : OUT STD_LOGIC;                                                 
    ad9516_sclk               : OUT STD_LOGIC;                                                 
    ad9516_sdio               : OUT STD_LOGIC;                                                 
    ad9516_sdo                : IN  STD_LOGIC := '0';
    -- Optional, but can be ommitted to reduce pinout
    ad9516_ld                 : IN  STD_LOGIC := '1';                                          -- PLL Lock detect output from AD9516
    ad9516_cs_n               : OUT STD_LOGIC;                                                 -- Tie-low on AD9516 if ommitted
    
    -- ADF4350 serial interface
    adf4350_clk               : OUT STD_LOGIC;                                          
    adf4350_data              : OUT STD_LOGIC;                                          
    adf4350_le                : OUT STD_LOGIC;                                          
    -- Optional, but can be ommitted to reduce pinout
    adf4350_ld                : IN  STD_LOGIC := '1';                                          -- PLL Lock detect output from ADF4350
  
    -- External Memory interface...
    ram_cs                    : OUT STD_LOGIC;                                                 -- Active-high external RAM chip-select
    ram_burst_access          : OUT STD_LOGIC;                                                 -- Active-high external RAM burst-access enable (indicates that this is the start of 
                                                                                               --   a multiple write or read from consecutive addresses).
    ram_burst_size            : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);                              -- Number of words within the RAM burst                                                                 
    ram_address               : OUT STD_LOGIC_VECTOR;
    ram_wr_en                 : OUT STD_LOGIC;                                                 -- Active-high external RAM write-enable
    ram_wrdata                : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    ram_rd_en                 : OUT STD_LOGIC;                                                 -- Active-high external RAM read-enable
    ram_rddata                : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
    ram_rddata_valid          : IN  STD_LOGIC;                                                 -- Active-high external RAM read-data valid .. indicates that ram_rddata should be latched
    ram_busy                  : IN  STD_LOGIC;                                                 -- Active-high external RAM is busy - stop sending commands as soon as possible
    ram_available             : IN  STD_LOGIC;                                                 -- Active-high external RAM is available for more commands
    ram_empty                 : IN  STD_LOGIC;                                                 -- Active-high flag indicating all external RAMs are empty - used for initialisation following
                                                                                               --   reset
    -- External Memory interface auto testing ..
    ram_test_running          : OUT STD_LOGIC;
    ram_test_complete         : OUT STD_LOGIC;
    ram_test_pass             : OUT STD_LOGIC;
    ram_test_error            : OUT STD_LOGIC;

    -- QDR Memory interface...
    fft_wr_addr               : OUT STD_LOGIC_VECTOR(18 DOWNTO 0);
    fft_wr_data               : OUT STD_LOGIC_VECTOR(35 DOWNTO 0);
    fft_wr_ena                : OUT STD_LOGIC;
    fft_rd_addr               : OUT STD_LOGIC_VECTOR(18 DOWNTO 0);
    fft_rd_data               : IN  STD_LOGIC_VECTOR(35 DOWNTO 0) := (OTHERS => '0');

    osg_wr_addr               : OUT STD_LOGIC_VECTOR(18 DOWNTO 0);
    osg_wr_data               : OUT STD_LOGIC_VECTOR(35 DOWNTO 0);
    osg_wr_ena                : OUT STD_LOGIC;
    osg_rd_addr               : OUT STD_LOGIC_VECTOR(18 DOWNTO 0);
    osg_rd_data               : IN  STD_LOGIC_VECTOR(35 DOWNTO 0) := (OTHERS => '0') );
  END COMPONENT;

BEGIN
    
  cms0041_1 : cms0041 GENERIC MAP ( BUILD_DEVICE_FAMILY              => BUILD_DEVICE_FAMILY,
                                    BUILD_BROADCAST_ONLY             => BUILD_BROADCAST_ONLY,          
                                    BUILD_CODE_CONFIG                => BUILD_CODE_CONFIG,             
                                    BUILD_SHORT_CONFIG               => BUILD_SHORT_CONFIG,            
                                    BUILD_QAM_CONFIG                 => BUILD_QAM_CONFIG,              
                                    BUILD_CPU_BYTE_ADDR_WIDTH        => BUILD_CPU_BYTE_ADDR_WIDTH,     
                                    BUILD_T2ADAPT                    => BUILD_T2ADAPT,                 
                                    BUILD_T2MI                       => BUILD_T2MI,                    
                                    BUILD_L1ACE_PROCESSOR            => BUILD_L1ACE_PROCESSOR,
                                    BUILD_IDV_ADDR_EXTRACTION        => BUILD_IDV_ADDR_EXTRACTION,
                                    BUILD_P2_BIAS_CELLS              => BUILD_P2_BIAS_CELLS,
                                    BUILD_INPUT_SMOOTHING_FIFO       => BUILD_INPUT_SMOOTHING_FIFO,
                                    CLOCK_FREQUENCY_KHZ              => CLOCK_FREQUENCY_KHZ,           
                                    CLOCK_RIF_FREQUENCY_KHZ          => CLOCK_RIF_FREQUENCY_KHZ,
                                    BUILD_RIF                        => BUILD_RIF,                     
                                    BUILD_BASE_TO_IF                 => BUILD_BASE_TO_IF,
                                    BUILD_PRE_DISTORT                => BUILD_PRE_DISTORT,             
                                    BUILD_INBAND_EQUALISER           => BUILD_INBAND_EQUALISER,    
                                    BUILD_FEF_SUPPORT                => BUILD_FEF_SUPPORT,
                                    BUILD_MAX_FFT_SIZE               => BUILD_MAX_FFT_SIZE,        
                                    BUILD_PAPR                       => BUILD_PAPR,                
                                    BUILD_FFT_WINDOW                 => BUILD_FFT_WINDOW,          
                                    BUILD_CRITICAL_FILTER            => BUILD_CRITICAL_FILTER,     
                                    BUILD_IF_ONLY                    => BUILD_IF_ONLY,                 
                                    BUILD_PCR_SUPPORT                => BUILD_PCR_SUPPORT,             
                                    BUILD_CALCULATE_TS_RATE          => BUILD_CALCULATE_TS_RATE,       
                                    BUILD_PRBS_PACKETS               => BUILD_PRBS_PACKETS,
                                    BUILD_CITL_CACHE                 => BUILD_CITL_CACHE,              
                                    BUILD_OSG_USE_EXTERNAL_RAM       => BUILD_OSG_USE_EXTERNAL_RAM,    
                                    BUILD_T2ADAPT_USE_EXTERNAL_RAM   => BUILD_T2ADAPT_USE_EXTERNAL_RAM,
                                    BUILD_SUPPORTED_PLP_NUM          => BUILD_SUPPORTED_PLP_NUM,
                                    BUILD_SFN_SUPPORT                => BUILD_SFN_SUPPORT,
                                    BUILD_AD9857_SUPPORT             => BUILD_AD9857_SUPPORT,  
                                    BUILD_AD9957_SUPPORT             => BUILD_AD9957_SUPPORT,  
                                    BUILD_AD9789_SUPPORT             => BUILD_AD9789_SUPPORT,
                                    BUILD_REGBANK_INITIALISATION     => BUILD_REGBANK_INITIALISATION,
                                    BUILD_RAM_TEST_SUPPORT           => BUILD_RAM_TEST_SUPPORT,
                                    BUILD_IDV_ADDR_PROCESSOR         => BUILD_IDV_ADDR_PROCESSOR,
                                    BUILD_PLL_PROGRAM                => BUILD_PLL_PROGRAM,           
                                    PLL_PROG_CLOCK_FREQUENCY_KHZ     => PLL_PROG_CLOCK_FREQUENCY_KHZ,
                                    BUILD_DAC_PROGRAM                => BUILD_DAC_PROGRAM,
                                    DAC_PROG_CLOCK_FREQUENCY_KHZ     => DAC_PROG_CLOCK_FREQUENCY_KHZ )
                                   

                         PORT MAP ( clock                            => clock,                 
                                    clock_x2                         => clock_x2,  
                                    clock_rif                        => clock_rif,            
                                    reset_n                          => reset_n,               
                                    reg_address                      => reg_address,           
                                    reg_wr_data                      => reg_wr_data,           
                                    reg_wr_en                        => reg_wr_en,             
                                    reg_chip_en                      => reg_chip_en,           
                                    reg_rd_data                      => reg_rd_data,           
                                    reg_irq                          => reg_irq,               
                                    reg_cmd_ack                      => reg_cmd_ack,           
                                    ts_data_sync                     => ts_data_sync,          
                                    ts_data_valid                    => ts_data_valid,         
                                    ts_data                          => ts_data,               
                                    ts_data_rdy                      => ts_data_rdy,           
                                    ts_data_busy                     => ts_data_busy,          
                                    ts_data_rvs                      => ts_data_rvs,           
                                    ts_data_scd                      => ts_data_scd,           
                                    ts_reframe_enable                => ts_reframe_enable,     
                                    ts_data_clk                      => ts_data_clk,           
                                    ts_data_refclk                   => ts_data_refclk,        
                                    clock_1s                         => clock_1s,           
                                    seconds_since_2000               => seconds_since_2000, 
                                    baseband_i                       => baseband_i,            
                                    baseband_q                       => baseband_q,           
                                    baseband_valid                   => baseband_valid,        
                                    dac_data_i                       => dac_data_i,            
                                    dac_data_q                       => dac_data_q,            
                                    ad9857_pdclk                     => ad9857_pdclk,             
                                    ad9857_data                      => ad9857_data,              
                                    ad9857_txenable                  => ad9857_txenable,          
                                    ad9957_pdclk                     => ad9957_pdclk,   
                                    ad9957_data                      => ad9957_data,    
                                    ad9957_txenable                  => ad9957_txenable,
                                    ad9789_dco                       => ad9789_dco,               
                                    ad9789_fs                        => ad9789_fs,                
                                    ad9789_data_i                    => ad9789_data_i,            
                                    ad9789_data_q                    => ad9789_data_q,            
                                    clock_dac_prog                   => clock_dac_prog,           
                                    dac_prog_complete                => dac_prog_complete,        
                                    dac_prog_reset_n                 => dac_prog_reset_n,         
                                    ad9857_reset                     => ad9857_reset,             
                                    ad9857_sclk                      => ad9857_sclk,              
                                    ad9857_sdio                      => ad9857_sdio,              
                                    ad9857_sdo                       => ad9857_sdo,               
                                    ad9857_pll_lock                  => ad9857_pll_lock,          
                                    ad9857_cs_n                      => ad9857_cs_n,              
                                    ad9857_sync_io                   => ad9857_sync_io,           
                                    ad9957_reset                     => ad9957_reset,             
                                    ad9957_sclk                      => ad9957_sclk,              
                                    ad9957_sdio                      => ad9957_sdio,              
                                    ad9957_sdo                       => ad9957_sdo,               
                                    ad9957_io_update                 => ad9957_io_update,         
                                    ad9957_pll_lock                  => ad9957_pll_lock,          
                                    ad9957_cs_n                      => ad9957_cs_n,              
                                    ad9957_sync_io                   => ad9957_sync_io,           
                                    ad9789_reset                     => ad9789_reset,             
                                    ad9789_sclk                      => ad9789_sclk,              
                                    ad9789_sdio                      => ad9789_sdio,              
                                    ad9789_sdo                       => ad9789_sdo,               
                                    ad9789_cs_n                      => ad9789_cs_n,              
                                    ad9789_dco_fpga_pll_reset        => ad9789_dco_fpga_pll_reset,
                                    ad9789_dco_pll_locked            => ad9789_dco_pll_locked,    
                                    clock_pll_prog                   => clock_pll_prog,           
                                    pll_prog_complete                => pll_prog_complete,        
                                    pll_prog_reset_n                 => pll_prog_reset_n,         
                                    ad9516_reset_n                   => ad9516_reset_n,           
                                    ad9516_sclk                      => ad9516_sclk,              
                                    ad9516_sdio                      => ad9516_sdio,              
                                    ad9516_sdo                       => ad9516_sdo,               
                                    ad9516_ld                        => ad9516_ld,                
                                    ad9516_cs_n                      => ad9516_cs_n,              
                                    adf4350_clk                      => adf4350_clk,              
                                    adf4350_data                     => adf4350_data,             
                                    adf4350_le                       => adf4350_le,               
                                    adf4350_ld                       => adf4350_ld,               
                                    ram_cs                           => ram_cs,                
                                    ram_burst_access                 => ram_burst_access,      
                                    ram_burst_size                   => ram_burst_size,        
                                    ram_address                      => ram_address,           
                                    ram_wr_en                        => ram_wr_en,             
                                    ram_wrdata                       => ram_wrdata,            
                                    ram_rd_en                        => ram_rd_en,             
                                    ram_rddata                       => ram_rddata,            
                                    ram_rddata_valid                 => ram_rddata_valid,      
                                    ram_busy                         => ram_busy,              
                                    ram_available                    => ram_available,         
                                    ram_empty                        => ram_empty,
                                    ram_test_running                 => ram_test_running,   
                                    ram_test_complete                => ram_test_complete,  
                                    ram_test_pass                    => ram_test_pass,      
                                    ram_test_error                   => ram_test_error,     
                                    fft_wr_addr                      => fft_wr_addr,           
                                    fft_wr_data                      => fft_wr_data,           
                                    fft_wr_ena                       => fft_wr_ena,            
                                    fft_rd_addr                      => fft_rd_addr,           
                                    fft_rd_data                      => fft_rd_data,           
                                    osg_wr_addr                      => osg_wr_addr,           
                                    osg_wr_data                      => osg_wr_data,           
                                    osg_wr_ena                       => osg_wr_ena,            
                                    osg_rd_addr                      => osg_rd_addr,           
                                    osg_rd_data                      => osg_rd_data );          

END rtl;
