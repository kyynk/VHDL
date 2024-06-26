library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.lab3_package.all;

entity Lab3_2 is
	port(	A,B : in std_logic_vector(7 downto 0);
			HEX2:out std_logic_vector(6 downto 0);
			HEX1:out std_logic_vector(6 downto 0)
	);
end Lab3_2;

architecture behavioral of Lab3_2 is
	signal Ci  : std_logic;
	signal Co  : std_logic;
	signal temp: std_logic;
	signal S   : std_logic_vector(7 downto 0);
begin
	Ci <= '0';
	stage0: BCDadd port map (A(3 downto 0)=>A(3 downto 0),B(3 downto 0)=>B(3 downto 0),
								Ci=>Ci,Co=>Co,S(3 downto 0)=>S(3 downto 0));
	
	stage1: BCDadd port map (A(3 downto 0)=>A(7 downto 4),B(3 downto 0)=>B(7 downto 4),
								Ci=>Co,Co=>temp,S(3 downto 0)=>S(7 downto 4));
	
	stage2: hex port map (SW2(3 downto 0)=>S(7 downto 4),SW1(3 downto 0)=>S(3 downto 0),
								HEX2(6 downto 0)=>HEX2(6 downto 0),
								HEX1(6 downto 0)=>HEX1(6 downto 0));
	
end behavioral;