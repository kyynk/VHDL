library ieee;
use ieee.std_logic_1164.all;
package lab9_package is
	component ro
		generic (n : integer := 7);
		port(	enable	: in std_logic;
				ck_out	: out std_logic
		);
	end component ro;
end lab9_package;