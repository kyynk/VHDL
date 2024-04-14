library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.lab3_package.all;

entity add_4bits is
	port(	X,Y : in std_logic_vector(3 downto 0);
			Ci  : in std_logic;
			Cout: out std_logic;
			S   : out std_logic_vector(3 downto 0)
	);
end add_4bits;

architecture func of add_4bits is
	signal C   : std_logic_vector(3 downto 0);
begin

	C(0) <= Ci;
	stage0: fulladd port map (C(0),X(0),Y(0),S(0),C(1));
	stage1: fulladd port map (C(1),X(1),Y(1),S(1),C(2));
	stage2: fulladd port map (C(2),X(2),Y(2),S(2),C(3));
	stage3: fulladd port map (C(3),X(3),Y(3),S(3),Cout);
end func;