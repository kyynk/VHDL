library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity R_O_n is
generic (n : integer := 7); --N階環形震盪
port(	enable	: in std_logic;
		clk_50M : in std_logic;
		ck_out	: out std_logic
	);
end R_O_n;

architecture behavior of R_O_n is
	signal chain : std_logic_vector(n-1 downto 0);
	attribute syn_keep:boolean;
	attribute syn_keep of chain:signal is true;
	
begin
	process(clk_50M)
	begin
		if(clk_50M'event and clk_50M = '1') then
		
			for i in 1 to n-1 loop
				chain(i) <= not chain(i-1);
			end loop;
		end if;
	end process;
	chain(0) <= enable and (not chain(n-1));
	ck_out <= chain(n-1);
end behavior;