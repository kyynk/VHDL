library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity test is
generic (N : integer := 8);
	port(	clk		: in std_logic;-- shift
			clear	: in std_logic;
			load	: in std_logic;
			lr_sel	: in std_logic;
			di		: in std_logic_vector(N-1 downto 0);
			sdi		: in std_logic;
			qo		: buffer std_logic_vector(N-1 downto 0);
			A		: in std_logic_vector(N-1 downto 0);-- add and sub
			B		: in std_logic_vector(N-1 downto 0);
			add_sub : in std_logic;
			S_D		: out std_logic_vector(N-1 downto 0);
			overflow: out std_logic;
			opcode	: in std_logic_vector(3 downto 0);-- alu
			alu_a	: in std_logic_vector(N-1 downto 0);
			alu_b	: in std_logic_vector(N-1 downto 0);
			result	: out std_logic_vector(N-1 downto 0);
			alu_over: out std_logic;
			sw		: in std_logic_vector(3 downto 0);-- hex
			hex		: out std_logic_vector(6 downto 0);
			sw1		: in integer range 15 downto 0;-- bcd
			sw2		: in integer range 15 downto 0;
			HEX0	: out std_logic_vector(6 downto 0);--LSB
			HEX1	: out std_logic_vector(6 downto 0) --MSB
	);
end;
architecture behavioral of test is
	signal carry 		: std_logic_vector(N downto 0);
	signal alu_carry	: std_logic_vector(N downto 0);
	signal less 		: std_logic;
	signal set 			: std_logic_vector(N-1 downto 0);
	signal msbAns		: integer range 15 downto 0;
	signal lsbAns		: integer range 15 downto 0;
begin
	process-- shift
	begin
		wait until clk'event and clk = '1';
		if clear = '0' then
			qo <= "00000000";
		else
			if load = '1' then
				qo <= di;
			else
				if lr_sel = '1' then	--right
					for i in 0 to N-2 loop
						qo(i) <= qo(i+1);
					end loop;
					qo(N-1) <= sdi;
				else					--left
					for i in N-1 downto 1 loop
						qo(i) <= qo(i-1);
					end loop;
					qo(0) <= sdi;
				end if;
			end if;
		end if;
	end process;
	carry(0) <= add_sub;-- add sub
	process(A,B,carry)	-- add = 0 and sub = 1
	begin
		for i in 0 to N-1 loop
			carry(i+1) <= (carry(i) and A(i)) 
							or (carry(i) and (B(i) xor carry(0))) 
							or (A(i) and (B(i) xor carry(0)));
			S_D(i) <= carry(i) xor A(i) xor (B(i) xor carry(0));
		end loop;
		overflow <= carry(N) xor carry(N-1);
	end process;
	process(opcode,alu_a,alu_b)-- alu
	begin
		if opcode = "0000" then
			for i in 0 to N-1 loop
				result(i) <= a(i) and b(i);
			end loop;
		elsif opcode = "0001" then
			for i in 0 to N-1 loop
				result(i) <= a(i) or b(i);
			end loop;
		elsif opcode = "0010" then
			alu_carry(0) <= '0';
			for i in 0 to N-1 loop
				alu_carry(i+1) <= (alu_carry(i) and alu_a(i)) or (alu_carry(i) and alu_b(i)) or (alu_a(i) and alu_b(i));
				result(i) <= alu_carry(i) xor alu_a(i) xor alu_b(i);
			end loop;
			alu_over <= alu_carry(N) xor alu_carry(N-1);
		elsif opcode = "0110" then
			alu_carry(0) <= '1';
			for i in 0 to N-1 loop
				alu_carry(i+1) <= (alu_carry(i) and alu_a(i)) or (alu_carry(i) and (alu_b(i) xor alu_carry(0))) or (alu_a(i) and (alu_b(i) xor alu_carry(0)));
				result(i) <= alu_carry(i) xor alu_a(i) xor (alu_b(i) xor alu_carry(0));
			end loop;
			alu_over <= alu_carry(N) xor alu_carry(N-1);
		elsif opcode = "0111" then
			alu_carry(0) <= '1';
			less <= '0';
			for i in 0 to N-1 loop
				alu_carry(i+1) <= (alu_carry(i) and alu_a(i)) or (alu_carry(i) and (alu_b(i) xor alu_carry(0))) or (alu_a(i) and (alu_b(i) xor alu_carry(0)));
				set(i) <= alu_carry(i) xor alu_a(i) xor (alu_b(i) xor alu_carry(0));
				result(i) <= less;
			end loop;
			alu_over <= alu_carry(N) xor alu_carry(N-1);
			result(0) <= set(N-1);
		elsif opcode = "1100" then
			for i in 0 to N-1 loop
				result(i) <= alu_a(i) nor alu_b(i);
			end loop;
		end if;
	end process;
	with sw select-- hex
	hex <=  "0000001" when "0000",-- a is MSB and hex is abcdefg
			"1001111" when "0001",
			"0010010" when "0010",
			"0000110" when "0011",
			"1001100" when "0100",
			"0100100" when "0101",
			"0100000" when "0110",
			"0001111" when "0111",
			"0000000" when "1000",
			"0001100" when "1001",
			"0001000" when "1010",
			"1100000" when "1011",
			"1110010" when "1100",
			"1000010" when "1101",
			"0110000" when "1110",
			"0111000" when "1111",
			"1111111" when others;
	--binary to decimal
	msbAns <= (sw1 + sw2) / 10;		-- bcd
	lsbAns <= (sw1 + sw2) Mod 10;
	process(msbAns)
	begin
		if (msbAns = 9) then HEX1 <= "0001100";
		elsif (msbAns = 8) then HEX1 <= "0000000";
		elsif (msbAns = 7) then HEX1 <= "0001111";
		elsif (msbAns = 6) then HEX1 <= "1100000";
		elsif (msbAns = 5) then HEX1 <= "0100100";
		elsif (msbAns = 4) then HEX1 <= "1001100";
		elsif (msbAns = 3) then HEX1 <= "0000110";
		elsif (msbAns = 2) then HEX1 <= "0010010";
		elsif (msbAns = 1) then HEX1 <= "1001111";
		elsif (msbAns = 0) then HEX1 <= "0000001";
		else HEX1 <= "1111111";
		end if;
	end process;
   process(lsbAns)
	begin
		if (lsbAns = 9) then HEX0 <= "0001100";
		elsif (lsbAns = 8) then HEX0 <= "0000000";
		elsif (lsbAns = 7) then HEX0 <= "0001111";
		elsif (lsbAns = 6) then HEX0 <= "1100000";
		elsif (lsbAns = 5) then HEX0 <= "0100100";
		elsif (lsbAns = 4) then HEX0 <= "1001100";
		elsif (lsbAns = 3) then HEX0 <= "0000110";
		elsif (lsbAns = 2) then HEX0 <= "0010010";
		elsif (lsbAns = 1) then HEX0 <= "1001111";
		elsif (lsbAns = 0) then HEX0 <= "0000001";
		else HEX0 <= "1111111";
		end if;
     end process;	
end behavioral;