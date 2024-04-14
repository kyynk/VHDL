library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.lab3_package.all;

entity BCDadd is
	port(	A,B : in std_logic_vector(3 downto 0);
			Ci  : in std_logic;
			Co  : inout std_logic;
			S   : out std_logic_vector(3 downto 0)
	);
end BCDadd;

architecture func of BCDadd is
	signal Sum : std_logic_vector(3 downto 0);
	signal Cout: std_logic;
	signal temp: std_logic_vector(3 downto 0);
begin
	stage0: add_4bits port map (X(3 downto 0)=>A(3 downto 0),Y(3 downto 0)=>B(3 downto 0),
								Ci=>Ci,Cout=>Cout,S(3 downto 0)=>Sum(3 downto 0));
	
	Co <= Cout or (Sum(3) and Sum(2)) or (Sum(3) and Sum(1));
	temp(3) <= Co;
	stage1: add_4bits port map (X(3 downto 0)=>Sum(3 downto 0),
								Y(0)=>'0',Y(1)=>temp(3),Y(2)=>Co,Y(3)=>'0',
								Ci=>'0',Cout=>temp(2),S(3 downto 0)=>S(3 downto 0));
end func;