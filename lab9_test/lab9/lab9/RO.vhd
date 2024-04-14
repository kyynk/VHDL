library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity RO is
    port(
        n : in integer;
        enable : in std_logic;
        clk_out : out std_logic;
		  clk : in std_logic
    );
end;
architecture behavior of RO is
    signal chain : std_logic_vector(50 downto 0);
    attribute keep: boolean; 
    attribute keep of chain: signal is true; 
 

    begin
        process(clk) is
        begin
            for i in 1 to 50 loop
                chain(i) <= not chain(i-1);
                exit when i=n;
            end loop;
        end process;
        chain(0) <= enable and (not chain(n));
        clk_out <= chain(n);
end;