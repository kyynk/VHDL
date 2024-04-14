library ieee;
use ieee.std_logic_1164.all;
package lab3_package is
	component fulladd
		port(	Cin,x,y : IN STD_LOGIC;
				s,Cout : OUT STD_LOGIC
		);
	end component fulladd;
	
	component add_4bits
		port(	X,Y : in std_logic_vector(3 downto 0);
				Ci  : in std_logic;
				Cout: out std_logic;
				S   : out std_logic_vector(3 downto 0)
		);
	end component add_4bits;
	
	component BCDadd
		port(	A,B : in std_logic_vector(3 downto 0);
				Ci  : in std_logic;
				Co  : out std_logic;
				S   : out std_logic_vector(3 downto 0)
		);
	end component BCDadd;
	
	component hex
		port(	SW2:in std_logic_vector(3 downto 0);
				HEX2:out std_logic_vector(6 downto 0);
				SW1:in std_logic_vector(3 downto 0);
				HEX1:out std_logic_vector(6 downto 0)
		);
	end component hex;
end lab3_package;