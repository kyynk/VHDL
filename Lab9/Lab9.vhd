library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use work.lab9_package.all;
--7 9 11 13 15 17 19 21 <- 階層
--N = 2*i + 7

--11059000  ->110590005
--30095011  ->110590034
--30195111	->repeat +1
-- n -> 0~7 (8,9 -> 7)
-- 0=7, 1=9, 2=11, 3=13, 4=15, 5=17, 6=19, 7=21
--11057000
--30175111

entity Lab9 is
	port(	clk_50M	: in std_logic;
			reset	: in std_logic;
			sw		: in std_logic_vector(2 downto 0);
			led1	: out std_logic;
			led2	: out std_logic;
			LED		: buffer std_logic_vector(8 downto 0)
	);
end Lab9;

architecture behavior of Lab9 is
	signal clk_1hz 	: std_logic;
	signal count1	: std_logic_vector(127 downto 0);
	signal count2	: std_logic_vector(127 downto 0);
	signal comp		: std_logic;
	signal n1		: std_logic;
	signal n2		: std_logic;
	type t_N is array (0 to 7, 0 to 1) of std_logic;
	signal N_arr : t_N;
begin
	
	stage0 : divider_n port map(clk_50M, clk_1hz);
	
	ro00 	: R_O_n generic map(7) port map(reset, clk_50M, N_arr(0,0));
	ro01 	: R_O_n generic map(7) port map(reset, clk_50M, N_arr(1,0));
	ro02	: R_O_n generic map(7) port map(reset, clk_50M, N_arr(2,0));
	ro03	: R_O_n generic map(21) port map(reset, clk_50M, N_arr(3,0));
	ro04	: R_O_n generic map(17) port map(reset, clk_50M, N_arr(4,0));
	ro05	: R_O_n generic map(7) port map(reset, clk_50M, N_arr(5,0));
	ro06	: R_O_n generic map(9) port map(reset, clk_50M, N_arr(6,0));
	ro07	: R_O_n generic map(9) port map(reset, clk_50M, N_arr(7,0));
	
	ro10 	: R_O_n generic map(9) port map(reset, clk_50M, N_arr(0,1));
	ro11 	: R_O_n generic map(9) port map(reset, clk_50M, N_arr(1,1));
	ro12 	: R_O_n generic map(9) port map(reset, clk_50M, N_arr(2,1));
	ro13 	: R_O_n generic map(17) port map(reset, clk_50M, N_arr(3,1));
	ro14 	: R_O_n generic map(21) port map(reset, clk_50M, N_arr(4,1));
	ro15 	: R_O_n generic map(9) port map(reset, clk_50M, N_arr(5,1));
	ro16 	: R_O_n generic map(7) port map(reset, clk_50M, N_arr(6,1));
	ro17	: R_O_n generic map(13) port map(reset, clk_50M, N_arr(7,1));
	
	select0 : mux8to1 port map( N_arr(0,0),
								N_arr(1,0),
								N_arr(2,0),
								N_arr(3,0),
								N_arr(4,0),
								N_arr(5,0),
								N_arr(6,0),
								N_arr(7,0),
								sw(2 downto 0),
								n1);
	select1 : mux8to1 port map( N_arr(0,1),
								N_arr(1,1),
								N_arr(2,1),
								N_arr(3,1),
								N_arr(4,1),
								N_arr(5,1),
								N_arr(6,1),
								N_arr(7,1),
								sw(2 downto 0),
								n2);
								
	cal0 	: cal_freq port map(reset, clk_1hz, n1, count1);
	cal1 	: cal_freq port map(reset, clk_1hz, n2, count2);
	
	cp		: compare port map(count1, count2, comp);
	
	process(clk_50M)
	begin
		if(reset = '0') then
			LED(7 downto 0) <= (others => '1');
			LED(8) <= reset;
		elsif (reset = '1') then
			LED(8) <= reset;
			if (count1 > count2) then
				LED(to_integer(unsigned(sw))) <= '1';
			elsif (count1 <= count2) then
				LED(to_integer(unsigned(sw))) <= '0';
			end if;
		end if;
	end process;
	led1 <= '1' when to_integer(unsigned(count1)) mod 5000000 > 2500000 else 
				'0';
					
	led2 <= '1' when to_integer(unsigned(count2)) mod 5000000 > 2500000 else 
				'0';
	
end behavior;