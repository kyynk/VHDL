library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.lab8_package.all;

entity Lab8 is
	port(	clk		: in std_logic;
			rs, rt	: in std_logic_vector(1 downto 0);
			op		: in std_logic_vector(3 downto 0);
			data 	: in std_logic_vector(7 downto 0);
			-- hex0 ~ hex5
			bus0, bus1, rs2, rs3, rt4, rt5 :out std_logic_vector(0 to 6)
	);
end Lab8;

architecture behavior of Lab8 is

	signal r0, r1, r2, r3 : std_logic_vector(7 downto 0);
	shared variable t1, t2 : std_logic_vector(7 downto 0);
-- t1 -> rs, t2 -> rt
begin
	process
	begin
		wait until clk'event and clk = '1';
		if rs = "00" then
			t1 := r0;
		elsif rs = "01" then
			t1 := r1;
		elsif rs = "10" then
			t1 := r2;
		elsif rs = "11" then
			t1 := r3;
		end if;
		
		if rt = "00" then
			t2 := r0;
		elsif rt = "01" then
			t2 := r1;
		elsif rt = "10" then
			t2 := r2;
		elsif rt = "11" then
			t2 := r3;
		end if;
		
		if op = "0000" then
			t1 := data;
			
		elsif op = "0001" then
			t1 := t2;
			
		elsif op = "0010" then
			t1 := t1 + t2;
			
		elsif op = "0011" then
			t1 := t1 and t2;
			
		elsif op = "0101" then
			t1 := t1 - t2;
			
		elsif op = "1001" then
			t1 := t2 - t1;
			
		elsif op = "0100" then
			t1 := t1 - t2;
			if t1(7) = '1' then
				t1 := "00000001";
			else
				t1 := "00000000";
			end if;
			
		end if;
		
		if rs = "00" then
			r0 <= t1;
		elsif rs = "01" then
			r1 <= t1;
		elsif rs = "10" then
			r2 <= t1;
		elsif rs = "11" then
			r3 <= t1;
		end if;
		
	end process;
	stage0 : hex port map(data(7 downto 4), data(3 downto 0), 
							bus1(0 to 6), bus0(0 to 6));
	stage1 : hex port map(t1(7 downto 4), t1(3 downto 0), 
							rs3(0 to 6), rs2(0 to 6));
	stage2 : hex port map(t2(7 downto 4), t2(3 downto 0), 
							rt5(0 to 6), rt4(0 to 6));
end behavior;