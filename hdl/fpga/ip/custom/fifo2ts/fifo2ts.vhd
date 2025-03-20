/*
*   File:   fifo2ts.vhd
*   Author: Bastien Pillonel 
*   EMAIL:  bastien.pillonel@heig-vd.ch
*
*   Description:    This file describe an interface that read the sample fifo in the TX dataflow and feed
*                   the TS interface of the DVB-T2 core.
*
*/

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL ;
use ieee.numeric_std.all;

entity fifo2ts is
    port(
        clk         : in std_logic;                                     
        rst         : in std_logic;
        fifo_data   : in std_logic_vector(31 downto 0);   -- Data from the sample fifo
        fifo_empty  : in std_logic;                                     -- Indicate fifo's empty
        fifo_rd_en  : out std_logic;                                    -- Reading fifo signal
        ts_data     : out std_logic_vector(7 downto 0);                 -- TS data output
        ts_valid    : out std_logic;                                    -- Validate TS data
        ts_busy     : in std_logic                                      
    );
end fifo2ts;

architecture internal of fifo2ts is
    signal byte_sel     : std_logic_vector(2 downto 0);
    signal data_buffer  : std_logic_vector(31 downto 0);
begin

    process(clk, rst) begin
        if rst = '1' then 
            ts_valid <= '0';
            ts_data  <= (others => '0');
            byte_sel <= "000";
        elsif rising_edge(clk) then
            if ((byte_sel = "000") and (fifo_empty = '0')) then
                data_buffer <= fifo_data;
                ts_valid <= '1';
                byte_sel <= "001";
            elsif (ts_busy = '0') and (ts_valid = '1') then
                case byte_sel is
                    when "001" => ts_data <= data_buffer(7 downto 0);
                    when "010" => ts_data <= data_buffer(15 downto 8);
                    when "011" => ts_data <= data_buffer(23 downto 16);
                    when "100" => 
                    ts_data <= data_buffer(31 downto 24);
                    ts_valid <= '0';
                    byte_sel <= "000";
                    when others => ts_data <= (others => '0');
                end case;
                if byte_sel /= "000" then 
                    byte_sel <= std_logic_vector(unsigned(byte_sel) + to_unsigned(1, byte_sel'length));
                end if;
            end if;
        end if;
    end process;

fifo_rd_en <= '1' when (byte_sel = "000") and (fifo_empty = '0') else '0';

end internal;