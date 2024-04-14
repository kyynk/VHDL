library ieee;
use ieee.std_logic_1164.all;
package lab8_package is
	component hex
		port(	sw1 : in std_logic_vector(3 downto 0);
				sw0 : in std_logic_vector(3 downto 0);
				hex1: out std_logic_vector(0 to 6);
				hex0: out std_logic_vector(0 to 6)
		);
	end component hex;
end lab8_package;