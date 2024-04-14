library ieee;
use ieee.std_logic_1164.all;
package lab9_pkg is
    component RO
        port(
            n : in integer;
            enable : in std_logic;
            clk_out : out std_logic;
				clk : in std_logic
        );
    end component RO;

    component div_clk is 
        port(
            enable : in std_logic;
            clk_in: in std_logic;
            clk_out: out std_logic
        );
    end component div_clk; 
    component cal_freq is
        port(
            res : in std_logic;
            clk_1hz : in std_logic;
            clk_nhz : in std_logic;
            nhz: out std_logic_vector(127 downto 0)
        );
    end component cal_freq;
end lab9_pkg;