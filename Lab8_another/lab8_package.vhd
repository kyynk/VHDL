library ieee;
use ieee.std_logic_1164.all;
package lab8_package is
	component seg
		port(	sw1 : in std_logic_vector(3 downto 0);
				sw0 : in std_logic_vector(3 downto 0);
				hex1: out std_logic_vector(0 to 6);
				hex0: out std_logic_vector(0 to 6)
		);
	end component seg;
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
	
	
	component onebitALU
		port(	A,B,less,carryin : in std_logic;
				opcode : in std_logic_vector(3 downto 0);
				result,set,carryout : out std_logic
		);
	end component onebitALU;
	component dff is
	port(	clear,clock : in std_logic;
			D : in std_logic;
			Q : out std_logic
	);
	end component dff;
	component upcount is
	port(	clear,clock : in std_logic;
			Q : buffer std_logic_vector(1 downto 0)
	);
	end component upcount;
	component sel_reg is
	port(	sel : in std_logic_vector(1 downto 0);
			r0,r1,r2,r3 : in std_logic_vector(7 downto 0);
			reg : out std_logic(7 downto 0)
	);
	end component sel_reg;
end lab8_package;