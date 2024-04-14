library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity divider_n is
generic(N : integer :=50000000);
port(	clk_50M : in std_logic;
		clk_out : out std_logic);
end divider_n;

architecture behavior of divider_n is
	signal count2 			: std_logic;
	shared variable count1 	: integer range 0 to N := 1;
	shared variable temp 	: integer range 0 to N;
	
begin
	process(clk_50M)
	begin
		temp := N/2;
		if clk_50M 'event and clk_50M='1' then
			if count1 = N then
				count1 := 1;
			else
				count1 := count1 + 1;
			end if;
		end if;
		
		if clk_50M 'event and clk_50M='1' then
			if ((count1 = temp)or(count1 = N)) then
				count2 <= not count2;
			end if;
		end if;
		clk_out <= count2;
	end process;

end behavior;