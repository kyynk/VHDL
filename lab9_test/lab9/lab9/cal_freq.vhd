library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity cal_freq is
    port(
        res : in std_logic;
        clk_1hz : in std_logic;
        clk_nhz : in std_logic;
        nhz: buffer std_logic_vector(127 downto 0)
    );
end;

architecture behavior of cal_freq is
begin    
    process (clk_nhz, res)
    begin
        if (res = '0') then
            nhz <= (others => '0');
        elsif (rising_edge(clk_nhz)) then
            if (clk_1hz = '0') then 
                nhz <= nhz+1;
            end if;
        end if;
    end process;
end;