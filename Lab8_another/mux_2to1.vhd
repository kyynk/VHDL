library ieee;
use ieee.std_logic_1164.all;

entity mux_2to1 is
	port(	w0,w1 : in std_logic;
			s : in std_logic;
			f : out std_logic
	);
end mux_2to1;

architecture behavioral of mux_2to1 is
	signal temp : std_logic;
begin
	with s select
		f <= w0 when '0',
			 w1 when others;
end behavioral;

