library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity cal_freq is
port(	res 	: in std_logic;
		clk_1Hz	: in std_logic;
		clk_nHz : in std_logic;
		nHz		: buffer std_logic_vector(127 downto 0)
	);
end cal_freq;

architecture behavior of cal_freq is
begin    
    process (clk_nhz, res)
    begin
        if (res = '0') then
            nHz <= (others => '0');
        elsif (clk_nhz'event and clk_nhz='1') then
--            if (clk_1hz = '0') then 
			nHz <= nHz+1;
--            end if;
        end if;
    end process;
end behavior;