library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity test_2 is
generic(N : integer := 4);
	port(	op : in std_logic_vector(3 downto 0); 
			A, B : in std_logic_vector(N-1 downto 0); 
			over : out std_logic := '0'; 
			R : out std_logic_vector(N-1 downto 0)
		);
end;

architecture a of test_2 is
	signal C : std_logic_vector(N downto 0);
begin
	process(op)
	begin
	case op is 
		when "0000" => --and 
			for i in 0 to N-1 loop 
				R(i) <= A(i) and B(i); 
			end loop; 
		when "0001" => --or 
			for i in 0 to N-1 loop 
				R(i) <= A(i) or B(i); 
			end loop; 
		when "0010" => --add 
			C(0) <= '0'; 
			for i in 0 to N-1 loop 
				R(i) <= A(i) xor B(i) xor C(i); 
				C(i+1) <= (A(i) and B(i)) or (A(i) and C(i)) or (B(i) and C(i)); 
			end loop; 
			over <= C(N) xor C(N-1); 
		when "0110" => --sub 
			C(0) <= '1'; 
			for i in 0 to N-1 loop 
				R(i) <= A(i) xor (not B(i)) xor C(i); 
				C(i+1) <= (A(i) and (not B(i))) or (A(i) and C(i)) or ((not B(i)) and C(i)); 
			end loop; 
			over <= C(N) xor C(N-1); 
		when "0111" => --set on less than 
			R <= (others => '0'); 
			for i in N-1 downto 0 loop 
				if ((not A(i)) and B(i))='1' then 
					R(0) <= '1'; 
				end if; 
			end loop;
		when "1100" => --nor 
			 for i in 0 to N-1 loop 
				R(i) <= A(i) nor B(i); 
			 end loop;
		when others => 
			R <= (others => '0'); 
	end case;
	end process;
end a;