library ieee;
use ieee.std_logic_1164.all;
package lab2_package is
	component fulladd
		port(	Cin,x,y : IN STD_LOGIC;
				s,Cout : OUT STD_LOGIC
		);
	end component fulladd;
	
	component hex
		port(	SW2:in std_logic_vector(3 downto 0);
				HEX2:out std_logic_vector(6 downto 0);
				SW1:in std_logic_vector(3 downto 0);
				HEX1:out std_logic_vector(6 downto 0)
		);
	end component hex;
end lab2_package;