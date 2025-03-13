/*
*   File:   blaockRAM.vhd
*   Author: Bastien Pillonel 
*   EMAIL:  bastien.pillonel@heig-vd.ch
*
*   Description:    This file describe an internal blockRAM component that will match the DVB-T2 commsonic external RAM interface.
*                   It will work as the TITL DDR RAM described in the commsonic IP core s00080 documentation.
*
*/

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL ;
USE IEEE.std_logic_arith.ALL ;

entity blockRAM is
    port(
        cms0041_clock         : IN    STD_LOGIC;                      -- RAM interface synchronous clock - should be the same as the CMS0041 core clock
        ram_cs                : IN    STD_LOGIC;                      -- Active-high external RAM chip-select
        ram_burst_access      : IN    STD_LOGIC;                      -- Active-high external RAM burst-access enable (indicates that this is the start of
                                                                      --   a multiple write or read from consecutive addresses).
        ram_burst_size        : IN    STD_LOGIC_VECTOR(3 DOWNTO 0);   -- Number of words within the RAM burst                                                                
        ram_address           : IN    STD_LOGIC_VECTOR;
        ram_wr_en             : IN    STD_LOGIC;                      -- Active-high external RAM write-enable
        ram_wrdata            : IN    STD_LOGIC_VECTOR(31 DOWNTO 0);
        ram_rd_en             : IN    STD_LOGIC;                      -- Active-high external RAM read-enable
        ram_rddata            : OUT   STD_LOGIC_VECTOR(31 DOWNTO 0);
        ram_rddata_valid      : OUT   STD_LOGIC;                      -- Active-high external RAM read-data valid .. indicates that ram_rddata should be latched
        ram_busy              : OUT   STD_LOGIC;                      -- Active-high external RAM is busy - stop sending commands as soon as possible
        ram_available         : OUT   STD_LOGIC;                      -- Active-high external RAM is available for more commands
        ram_empty             : OUT   STD_LOGIC                      -- Active-high flag indicating all external RAMs are empty - used for initialisation following
                                                                      --   reset
    );
end blockRAM;
 

ARCHITECTURE internal OF blockRAM IS
    CONSTANT  ram_size                   : INTEGER := 2**16;
    TYPE    memory_type IS ARRAY (0 TO ram_size-1) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL  ram_data_out                 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL  memory                       : memory_type;
    SIGNAL  ram_rd_en_pipe               : STD_LOGIC;

BEGIN
    memory_store : PROCESS (cms0041_clock) BEGIN
        IF cms0041_clock'EVENT AND cms0041_clock='1' THEN
            IF ram_cs = '1' THEN
                IF ram_wr_en = '1' THEN
                    IF conv_integer(unsigned(ram_address)) < ram_size THEN
                        ram_data_out <= ram_wrdata;
                        memory(conv_integer(unsigned(ram_address))) <= ram_wrdata;
                    ELSE
                        ram_data_out <= (OTHERS => '0');
                    END IF;
                ELSE
                    IF conv_integer(unsigned(ram_address)) < ram_size THEN
                        ram_data_out <= memory(conv_integer(unsigned(ram_address)));
                    ELSE
                        ram_data_out <= (OTHERS => '0');
                    END IF;
                END IF;
            END IF;
            ram_rddata <= ram_data_out;         

        END IF;

    END PROCESS memory_store;

    ram_busy <= '0';
    ram_available <= '1';                        
    ram_empty <= '1';

    -- Generate fixed read-data valid latency...
    ram_read_processing : PROCESS (cms0041_clock) BEGIN
        IF cms0041_clock'EVENT AND cms0041_clock='1' THEN
            ram_rd_en_pipe   <= ram_rd_en AND ram_cs;
            ram_rddata_valid <= ram_rd_en_pipe;
        END IF;   
    END PROCESS ram_read_processing;
END internal ;