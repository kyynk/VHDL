library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ro is
generic (n : integer := 7); --N階環形震盪
port(	enable	: in std_logic;
		ck_out	: out std_logic
	);
end ro;

architecture behavior of ro is
	signal chain : std_logic_vector(n-1 downto 0);
	attribute syn_keep : boolean;
	attribute syn_keep of chain : signal is true;
	
begin
	chain(0) <= enable and (not chain(n-1));
	
	genchain : for i in 1 to n-1 generate
		chain(i) <= not chain(i-1);
	end generate;
	
	ck_out <= chain(n-1);
end behavior;