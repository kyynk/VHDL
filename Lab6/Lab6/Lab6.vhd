library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity Lab6 is
	port(	clk,reset,w : in std_logic;
			output : out std_logic_vector(2 downto 0)
		);
end Lab6;

architecture behavior of Lab6 is
	type state_type is (S0,S1,S2a,S2b,S3,S4);
	signal S_now,S_next : state_type;
begin
	process(w,S_now)
	begin
		case S_now is
			when S0 =>
				if w = '0' then S_next <= S0;
				else S_next <= S1;
				end if;
			when S1 =>
				if w = '0' then S_next <= S2a;
				else S_next <= S2b;
				end if;
			when S2a =>
				S_next <= S3;
			when S2b =>
				S_next <= S3;
			when S3 =>
				if w = '0' then S_next <= S1;
				else S_next <= S4;
				end if;
			when S4 =>
				S_next <= S4;
			when others =>
				S_next <= S0;
		end case;
	end process;
	process(clk,reset)
	begin
		if (reset = '1') then
			S_now <= S0;	--S0
		elsif (clk'event and clk = '1') then
			S_now <= S_next;
		end if;
	end process;
	
	output <=	"000" when S_now = S0 else
				"001" when S_now = S1 else
				"010" when S_now = S2a else
				"011" when S_now = S2b else
				"100" when S_now = S3 else
				"101" when S_now = S4 else
				"000";
end behavior;