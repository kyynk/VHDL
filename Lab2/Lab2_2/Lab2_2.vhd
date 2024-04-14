library ieee;
use ieee.std_logic_1164.all;
use work.lab2_package.all;

entity Lab2_2 is 
	port(	X,Y : in std_logic_vector(7 downto 0);
			hex2,hex1: out std_logic_vector(6 downto 0);
			overflow: out std_logic
	);
end Lab2_2;

architecture behavioral of Lab2_2 is
	signal C   : std_logic_vector(7 downto 0);
	signal Cout: std_logic;
	signal S   : std_logic_vector(7 downto 0);
begin
	C(0) <= '1';
	stage0: fulladd port map (C(0),X(0),Y(0) xor C(0),S(0),C(1));
	stage1: fulladd port map (C(1),X(1),Y(1) xor C(0),S(1),C(2));
	stage2: fulladd port map (C(2),X(2),Y(2) xor C(0),S(2),C(3));
	stage3: fulladd port map (C(3),X(3),Y(3) xor C(0),S(3),C(4));
	stage4: fulladd port map (C(4),X(4),Y(4) xor C(0),S(4),C(5));
	stage5: fulladd port map (C(5),X(5),Y(5) xor C(0),S(5),C(6));
	stage6: fulladd port map (C(6),X(6),Y(6) xor C(0),S(6),C(7));
	stage7: fulladd port map (C(7),X(7),Y(7) xor C(0),S(7),Cout);
	overflow <= C(7) xor Cout;
	stage8: hex port map(SW2(3 downto 0)=>S(7 downto 4), SW1(3 downto 0)=>S(3 downto 0), 
			HEX2(6 downto 0)=>hex2(6 downto 0),HEX1(6 downto 0)=>hex1(6 downto 0));
	
end behavioral;