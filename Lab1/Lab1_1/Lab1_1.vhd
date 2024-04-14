library ieee;
use ieee.std_logic_1164.all;

entity Lab1_1 is
port(
	SW:in std_logic_vector(3 downto 0);--SW(3)=W,SW(2)=X,SW(1)=Y,SW(0)=Z
	HEX0:out std_logic_vector(6 downto 0)
);
end Lab1_1;

architecture behavioral of Lab1_1 is
--boolean
begin
--a
	HEX0(0) <= (SW(2) and not(SW(1)) and not(SW(0))) or (SW(3) and SW(2) and not(SW(1))) or
				 (not(SW(3)) and not(SW(2)) and not(SW(1)) and SW(0)) or (SW(3) and not(SW(2)) and SW(1) and SW(0));
--b
	HEX0(1) <= (SW(3) and SW(1) and SW(0)) or (SW(2) and SW(1) and not(SW(0))) or
				 (SW(3) and SW(2) and not(SW(0))) or (not(SW(3)) and SW(2) and not(SW(1)) and SW(0));
--c
	HEX0(2) <= (SW(3) and SW(2) and not(SW(0))) or (SW(3) and SW(2) and SW(1)) or
				 (not(SW(3)) and not(SW(2)) and SW(1) and not(SW(0)));
--d
	HEX0(3) <= (not(SW(2)) and not(SW(1)) and SW(0)) or (SW(2) and SW(1) and SW(0)) or
				 (not(SW(3)) and SW(2) and not(SW(1)) and not(SW(0))) or (SW(3) and not(SW(2)) and SW(1) and not(SW(0)));
--e
	HEX0(4) <= (not(SW(3)) and SW(0)) or (not(SW(3)) and SW(2) and not(SW(1))) or (not(SW(2)) and not(SW(1)) and SW(0));
--f
	HEX0(5) <= (SW(3) and SW(2) and not(SW(1))) or (not(SW(3)) and not(SW(2)) and SW(0)) or
				 (not(SW(3)) and not(SW(2)) and SW(1)) or (not(SW(3)) and SW(1) and SW(0));
--g
	HEX0(6) <= (not(SW(3)) and not(SW(2)) and not(SW(1))) or (not(SW(3)) and SW(2) and SW(1) and SW(0));

end behavioral;