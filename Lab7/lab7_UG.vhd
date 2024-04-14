library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
entity lab7 is 
	port (clk, reset: in std_logic;
	Divisor, Dividend : in std_logic_vector(7 downto 0);
	Remainder : buffer std_logic_vector(15 downto 0);
	Quotient  : buffer std_logic_vector(7 downto 0);
	seg_QH, seg_QL, seg_RH, seg_RL :out std_logic_vector(6 downto 0));
end;
architecture logicFunc of lab7 is 
	type state_type is (start,s1,s2a,s2b,s3,s4);
	signal state : state_type;
	type rom10x7 is array (0 to 15) of std_logic_vector(6 downto 0);
   constant ROM10_7 : rom10x7 :=(
    "1000000","1111001","0100100","0110000","0011001","0010010","0000010","1111000","0000000","0010000","0001000","0000011","1000110","0100001","0000110","0001110"
    );
	shared variable w : std_logic;
	shared variable count : integer;
	signal dvs: std_logic_vector(15 downto 0);
	shared variable tmp : std_logic_vector(15 downto 0);
begin
	process(clk,reset)
	begin
		if (reset = '1') then 
			state <= start;
			Remainder <= (others => '0');
			Quotient <= (others => '0');
			seg_QH <= (others => '1');
			seg_QL <= (others => '1');
			seg_RH <= (others => '1');
			seg_RL <= (others => '1');
		elsif (clk'event and clk = '1') then
			case state is
			
				when start =>
					count := 0;
					dvs <= Divisor & "00000000";
					Remainder <= "00000000" & Dividend;
					w := '1'; 
					state <= s1;
				
				when s1 =>
					Remainder <= Remainder - dvs;
					tmp := Remainder - dvs;
					if tmp(15) = '1' then 
						w := '1';
					else 
						w := '0';
					end if;
					if w = '1' then 	
						state <= s2b;
					else 
						state <= s2a;
					end if;
				
				when s2a =>
					Quotient <= Quotient(6 downto 0) & '1';
					state <= s3;
				
				when s2b => 
					Remainder <= Remainder + dvs;
					Quotient <= Quotient(6 downto 0) & '0';
					state <= s3;
					
				when s3 =>
					dvs <= '0' & dvs(15 downto 1) ;
					count := count + 1;
					if count = 9 then 
						w := '1';
					else 
						w := '0';
					end if;
					if w = '1' then 
						state <= s4;
					else
						state <= s1;
					end if;
					
				when s4 => 
					seg_QH <= ROM10_7(to_integer(unsigned(Quotient(7 downto 4))));
					seg_QL <= ROM10_7(to_integer(unsigned(Quotient(3 downto 0))));
					seg_RH <= ROM10_7(to_integer(unsigned(Remainder(7 downto 4))));
					seg_RL <= ROM10_7(to_integer(unsigned(Remainder(3 downto 0))));
					
				when others =>
				
			end case;
		end if;
	end process;
end;