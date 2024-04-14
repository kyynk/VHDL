library ieee;
use ieee.std_logic_1164.all;
package lab9_package is
	component R_O_n
		generic (n : integer := 7);
		port(	enable	: in std_logic;
				clk_50M : in std_logic;
				ck_out	: out std_logic
		);
	end component R_O_n;
	
	component mux8to1
		port(	w0,w1,w2,w3,w4,w5,w6,w7 : in std_logic;
				s : std_logic_vector(2 downto 0);
				f : out std_logic
		);
	end component mux8to1;
	
	component divider_n
		port(	clk_50M : in std_logic;
				clk_out : out std_logic
		);
	end component divider_n;
	
	component cal_freq
		port(	res 	: in std_logic;
				clk_1Hz	: in std_logic;
				clk_nHz : in std_logic;
				nHz		: buffer std_logic_vector(127 downto 0)
		);
	end component cal_freq;
	
	component compare
		port(	val_a : in std_logic_vector(127 downto 0);
				val_b : in std_logic_vector(127 downto 0);
				result : out std_logic
		);
	end component compare;
	
end lab9_package;