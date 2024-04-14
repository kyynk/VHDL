library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.lab9_pkg.all;

entity lab9 is
    port(
        clk_50M: in std_logic;
        reset: in std_logic;
        sw: in std_logic_vector(2 downto 0);
        led : out std_logic_vector(8 downto 0);
		  led1: out std_logic;
		  led2: out std_logic
    );
end;


architecture ar of lab9 is
type number2d is array(0 to 1, 0 to 7) of integer;
constant dict : number2d := (
    (8,8,6,16,20,6,6,6),
    (18,6,8,20,16,8,8,8)
);

    shared variable cnt1: integer := 0;
    shared variable cnt2: integer := 0;
    signal clk_1hz : std_logic := '0';
    signal clk_ro1 : std_logic := '0';
    signal clk_ro2 : std_logic := '0';
    signal enable : std_logic := '0';
    signal result1 : std_logic_vector(127 downto 0) := (others => '0');
    signal result2 : std_logic_vector(127 downto 0) := (others => '0');
begin
		
    enable <= reset;
    led(8) <= clk_1hz;
    
    led(to_integer(unsigned(sw))) <= '1' when enable = '1' and result1 > result2 else
                                    '0' when enable = '1' and result1 <= result2;
    
    clk_1: div_clk port map(enable, clk_50M,clk_1hz);
    ro_1: RO port map(dict(0,to_integer(unsigned(sw))), enable, clk_ro1, clk_50M);
    ro_2: RO port map(dict(1,to_integer(unsigned(sw))), enable, clk_ro2, clk_50M);

    cal_freq1: cal_freq port map(enable, clk_1hz, clk_ro1, result1); 
    cal_freq2: cal_freq port map(enable, clk_1hz, clk_ro2, result2);
		led1 <= '1' when to_integer(unsigned(result1)) mod 5000000 > 2500000 else 
					'0';
						
		led2 <= '1' when to_integer(unsigned(result2)) mod 5000000 > 2500000 else 
					'0';
	
end;