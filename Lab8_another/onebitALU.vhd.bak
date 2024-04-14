library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.lab4_package.all;

entity onebitALU is
	port(	A,B,less,carryin : in std_logic;
			opcode : in std_logic_vector(3 downto 0);--0000
			result,set,carryout : out std_logic
	);
end onebitALU;

architecture LogicFunc of onebitALU is
	signal Ain : std_logic;
	signal Bin : std_logic;
	signal w0_and: std_logic;
	signal w1_or : std_logic;
	signal w2_add: std_logic; -- set
begin
	
	stage0:mux_2to1 port map(A,not A,opcode(3),Ain);
    stage1:mux_2to1 port map(B,not B,opcode(2),Bin);
	
    w0_and <= Ain and Bin;
    w1_or <= Ain or Bin;
	
    stage2:fulladd port map(Cin=>carryin,x=>Ain,y=>Bin,s=>w2_add,Cout=>carryout);
	
	set <= w2_add;
	
    stage3:mux_4to1 port map(w0=>w0_and,w1=>w1_or,w2=>w2_add,w3=>less,s(1 downto 0)=>opcode(1 downto 0),f=>result);
	
end LogicFunc;