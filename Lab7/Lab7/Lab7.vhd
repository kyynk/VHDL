library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Lab7 is
	port(	clk,reset : in std_logic; --clear reset
			Divisor,Dividend : in std_logic_vector(7 downto 0);
			Quotient : buffer std_logic_vector(7 downto 0);
			Remainder : buffer std_logic_vector(15 downto 0);
			HEX0,HEX1,HEX2,HEX3 : out std_logic_vector(0 to 6)
		);
end Lab7;

architecture behavior of Lab7 is
	signal D_sor : std_logic_vector(15 downto 0);
	
	type state_type is (S0,S1,S2a,S2b,S3,S4);
	signal S_now : state_type;
	
	shared variable S_next : state_type;
	shared variable w : std_logic;
	shared variable count : integer;
	shared variable temp : std_logic_vector(15 downto 0);
	
begin
	process(clk,reset)
	begin
		if (reset = '1') then
			S_now <= S0;
			Remainder <= (others => '0');
			Quotient <= (others => '0');
			HEX3 <= (others => '1');	--quotient msb
			HEX2 <= (others => '1');	--quotient lsb
			HEX1 <= (others => '1');	--remainder msb
			HEX0 <= (others => '1');	--remainder lsb
		elsif (clk'event and clk = '1') then
			case S_now is
			
				when S0 =>
					count := 0;
					D_sor <= Divisor & "00000000";
					Remainder <= "00000000" & Dividend;
					w := '1';
					
					if w = '0' then
						S_next := S0;
					else
						S_next := s1;
					end if;
					
				when S1 =>
					Remainder <= Remainder - D_sor;
					temp := Remainder - D_sor;
					
					if temp(15) = '1' then 
						w := '1';
					else 
						w := '0';
					end if;
					
					if w = '0' then 	
						S_next := S2a;
					else 
						S_next := S2b;
					end if;
				
				when S2a =>
					for i in 7 downto 1 loop
						Quotient(i) <= Quotient(i-1);
					end loop;
					Quotient(0) <= '1';
					
					S_next := S3;
				
				when S2b => 
					Remainder <= Remainder + D_sor;
					for i in 7 downto 1 loop
						Quotient(i) <= Quotient(i-1);
					end loop;
					Quotient(0) <= '0';
					
					S_next := S3;
					
				when S3 =>
					for i in 0 to 14 loop
						D_sor(i) <= D_sor(i+1);
					end loop;
					D_sor(15) <= '0';
					
					count := count + 1;
					if count = 9 then 
						w := '1';
					else 
						w := '0';
					end if;
					
					if w = '1' then 
						S_next := S4;
					else
						S_next := S1;
					end if;
					
				when S4 => 
					S_next := S4;
				when others =>
					-------------
			end case;
			S_now <= S_next;
			
			-- a is MSB and hex is abcdefg
			case Quotient (7 downto 4) is
				when "0000" => HEX3 <= "0000001";
				when "0001" => HEX3 <= "1001111";
				when "0010" => HEX3 <= "0010010";
				when "0011" => HEX3 <= "0000110";
				when "0100" => HEX3 <= "1001100";
				when "0101" => HEX3 <= "0100100";
				when "0110" => HEX3 <= "0100000";
				when "0111" => HEX3 <= "0001111";
				when "1000" => HEX3 <= "0000000";
				when "1001" => HEX3 <= "0001100";
				when "1010" => HEX3 <= "0001000";
				when "1011" => HEX3 <= "1100000";
				when "1100" => HEX3 <= "1110010";
				when "1101" => HEX3 <= "1000010";
				when "1110" => HEX3 <= "0110000";
				when "1111" => HEX3 <= "0111000";
				when others => HEX3 <= "1111111";
			end case;
			case Quotient (3 downto 0) is
				when "0000" => HEX2 <= "0000001";
				when "0001" => HEX2 <= "1001111";
				when "0010" => HEX2 <= "0010010";
				when "0011" => HEX2 <= "0000110";
				when "0100" => HEX2 <= "1001100";
				when "0101" => HEX2 <= "0100100";
				when "0110" => HEX2 <= "0100000";
				when "0111" => HEX2 <= "0001111";
				when "1000" => HEX2 <= "0000000";
				when "1001" => HEX2 <= "0001100";
				when "1010" => HEX2 <= "0001000";
				when "1011" => HEX2 <= "1100000";
				when "1100" => HEX2 <= "1110010";
				when "1101" => HEX2 <= "1000010";
				when "1110" => HEX2 <= "0110000";
				when "1111" => HEX2 <= "0111000";
				when others => HEX2 <= "1111111";
			end case;
			case Remainder (7 downto 4) is
				when "0000" => HEX1 <= "0000001";
				when "0001" => HEX1 <= "1001111";
				when "0010" => HEX1 <= "0010010";
				when "0011" => HEX1 <= "0000110";
				when "0100" => HEX1 <= "1001100";
				when "0101" => HEX1 <= "0100100";
				when "0110" => HEX1 <= "0100000";
				when "0111" => HEX1 <= "0001111";
				when "1000" => HEX1 <= "0000000";
				when "1001" => HEX1 <= "0001100";
				when "1010" => HEX1 <= "0001000";
				when "1011" => HEX1 <= "1100000";
				when "1100" => HEX1 <= "1110010";
				when "1101" => HEX1 <= "1000010";
				when "1110" => HEX1 <= "0110000";
				when "1111" => HEX1 <= "0111000";
				when others => HEX1 <= "1111111";
			end case;
			case Remainder (3 downto 0) is
				when "0000" => HEX0 <= "0000001";
				when "0001" => HEX0 <= "1001111";
				when "0010" => HEX0 <= "0010010";
				when "0011" => HEX0 <= "0000110";
				when "0100" => HEX0 <= "1001100";
				when "0101" => HEX0 <= "0100100";
				when "0110" => HEX0 <= "0100000";
				when "0111" => HEX0 <= "0001111";
				when "1000" => HEX0 <= "0000000";
				when "1001" => HEX0 <= "0001100";
				when "1010" => HEX0 <= "0001000";
				when "1011" => HEX0 <= "1100000";
				when "1100" => HEX0 <= "1110010";
				when "1101" => HEX0 <= "1000010";
				when "1110" => HEX0 <= "0110000";
				when "1111" => HEX0 <= "0111000";
				when others => HEX0 <= "1111111";
			end case;
		end if;
	end process;
end behavior;