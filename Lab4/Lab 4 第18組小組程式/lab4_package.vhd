library ieee;
use ieee.std_logic_1164.all;
package lab4_package is
	component fulladd
		port(	Cin,x,y : IN STD_LOGIC;
				s,Cout : OUT STD_LOGIC
		);
	end component fulladd;
	
	component mux_4to1
		port(	w0,w1,w2,w3 : in std_logic;
				s : in std_logic_vector(1 downto 0);
				f : out std_logic
		);
	end component mux_4to1;
	
	component mux_2to1
		port(	w0,w1 : in std_logic;
				s : in std_logic;
				f : out std_logic
		);
	end component mux_2to1;
	
	component hex
		port(	SW2:in std_logic_vector(3 downto 0);
				HEX2:out std_logic_vector(6 downto 0);
				SW1:in std_logic_vector(3 downto 0);
				HEX1:out std_logic_vector(6 downto 0)
		);
	end component hex;
	
	component onebitALU
		port(	A,B,less,carryin : in std_logic;
				opcode : in std_logic_vector(3 downto 0);
				result,set,carryout : out std_logic
		);
	end component onebitALU;
end lab4_package;