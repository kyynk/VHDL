library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.lab8_package.all;

entity dff is
	port(	clear,clock : in std_logic;
			D : in std_logic;
			Q : out std_logic
	);
end dff;

architecture LogicFunc of dff is
begin
	process(clock)
	begin
	if(clear='0') then
		Q<='0';
	elsif(rising_edge(clock)) then
		Q<=D;
	end if;
	end process;
	
end LogicFunc;