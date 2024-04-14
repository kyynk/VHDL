library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity Lab5_1 is
generic (N : integer := 8);
	port(	clk		: in std_logic;
			clear	: in std_logic;
			load	: in std_logic;
			lr_sel	: in std_logic;
			di		: in std_logic_vector(N-1 downto 0);
			sdi		: in std_logic;
			qo		: buffer std_logic_vector(N-1 downto 0)
	);
end;
architecture behavioral of Lab5_1 is

begin
	process
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
end behavioral;