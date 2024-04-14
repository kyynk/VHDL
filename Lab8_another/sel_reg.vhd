library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.lab8_package.all;

entity sel_reg is
	port(	sel : in std_logic_vector(1 downto 0);
			r0,r1,r2,r3 : in std_logic_vector(7 downto 0);
			reg : out std_logic(7 downto 0)
	);
end sel_reg;

architecture LogicFunc of sel_reg is
BEGIN
	if sel = "00" then 
		reg <= r0;
	elsif sel = "01" then
		reg <= r1;
	elsif sel = "10" then 
		reg <= r2;
	elsif sel = "11" then
		reg <= r3	
end LogicFunc;