library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
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
entity lab9_test is
	port(	clk_50M	: in std_logic;
			reset	: in std_logic;
			sw		: in std_logic_vector(2 downto 0);
			LED		: buffer std_logic_vector(8 downto 0)
	);
end lab9_test;

architecture behavior of lab9_test is
	type t_N is array (0 to 7) of std_logic;
	signal N_arr : t_N;
begin
--	gfor: for i in 0 to 7 generate
--		
--	end generate gfor;

	gRO : ro port map(enable => '1', ck_out => LED(8));
--	gLED: for i in 0 to 7 generate
--		LED(i) <= N_arr(i);
--	end generate gLED;
	
	LED(0) <= reset;
end behavior;