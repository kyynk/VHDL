library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity compare is
port(	val_a : in std_logic_vector(127 downto 0);
		val_b : in std_logic_vector(127 downto 0);
		result : out std_logic
	);
end compare;

architecture  behavior of compare is
begin
	result <= '1' when (unsigned(val_a) > unsigned(val_b)) else '0';
end behavior;