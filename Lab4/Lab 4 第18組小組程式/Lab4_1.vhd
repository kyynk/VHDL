library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.lab4_package.all;

entity Lab4_1 is
	port(	A,B : in std_logic_vector(6 downto 0);
			opcode : in std_logic_vector(3 downto 0);
			overflow : out std_logic;
			HEX2:out std_logic_vector(6 downto 0);
			HEX1:out std_logic_vector(6 downto 0)
	);
end Lab4_1;

architecture behavioral of Lab4_1 is
	signal   result : std_logic_vector(7 downto 0);
	signal      set : std_logic_vector(6 downto 0);
	signal carryout : std_logic_vector(6 downto 0);
	signal     temp : std_logic_vector(9 downto 0);
begin
	temp(9) <= opcode(2) and opcode(1);
	G1:for i in 0 to 6 generate
		G2:if i=0 generate
			stage0: onebitALU port map (A=>A(0),B=>B(0),less=>'0',carryin=>temp(9),
										opcode(3 downto 0)=>opcode(3 downto 0),
										result=>temp(0),set=>set(0),carryout=>carryout(0));
		end generate;
		G3:if (i<6) and (i>0)generate
			stage1: onebitALU port map (A=>A(i),B=>B(i),less=>'0',carryin=>carryout(i-1),
										opcode(3 downto 0)=>opcode(3 downto 0),
										result=>result(i),set=>set(i),carryout=>carryout(i));
		end generate;
		G4:if i=6 generate
			stage2: onebitALU port map (A=>A(i),B=>B(i),less=>'0',carryin=>carryout(i-1),
										opcode(3 downto 0)=>opcode(3 downto 0),
										result=>result(i),set=>set(i),carryout=>carryout(i));
			
			stage3: onebitALU port map (A=>A(0),B=>B(0),less=>set(6),carryin=>temp(9),
										opcode(3 downto 0)=>opcode(3 downto 0),
										result=>result(0),set=>temp(1),carryout=>temp(2));
		end generate;
	end generate;
	
	result(7) <= '0';
	overflow <= carryout(6) xor carryout(5);
	
	stage4: hex port map (SW2(3 downto 0)=>result(7 downto 4),SW1(3 downto 0)=>result(3 downto 0),
								HEX2(6 downto 0)=>HEX2(6 downto 0),
								HEX1(6 downto 0)=>HEX1(6 downto 0));
	
end behavioral;