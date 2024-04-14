library ieee;
use ieee.std_logic_1164.all;

entity Lab1_2 is
port(
	SW2:in std_logic_vector(3 downto 0);--SW(3)=W,SW(2)=X,SW(1)=Y,SW(0)=Z
	HEX2:out std_logic_vector(6 downto 0);
	SW1:in std_logic_vector(3 downto 0);--SW(3)=W,SW(2)=X,SW(1)=Y,SW(0)=Z
	HEX1:out std_logic_vector(6 downto 0);
	SW0:in std_logic_vector(3 downto 0);--SW(3)=W,SW(2)=X,SW(1)=Y,SW(0)=Z
	HEX0:out std_logic_vector(6 downto 0)
);
end Lab1_2;

architecture behavioral of Lab1_2 is
--boolean
begin
--a
	HEX2(0) <= (SW2(2) and not(SW2(1)) and not(SW2(0))) or (SW2(3) and SW2(2) and not(SW2(1))) or
				 (not(SW2(3)) and not(SW2(2)) and not(SW2(1)) and SW2(0)) or
				 (SW2(3) and not(SW2(2)) and SW2(1) and SW2(0));
--b
	HEX2(1) <= (SW2(3) and SW2(1) and SW2(0)) or (SW2(2) and SW2(1) and not(SW2(0))) or
				 (SW2(3) and SW2(2) and not(SW2(0))) or
				 (not(SW2(3)) and SW2(2) and not(SW2(1)) and SW2(0));
--c
	HEX2(2) <= (SW2(3) and SW2(2) and not(SW2(0))) or (SW2(3) and SW2(2) and SW2(1)) or
				 (not(SW2(3)) and not(SW2(2)) and SW2(1) and not(SW2(0)));
--d
	HEX2(3) <= (not(SW2(2)) and not(SW2(1)) and SW2(0)) or (SW2(2) and SW2(1) and SW2(0)) or
				 (not(SW2(3)) and SW2(2) and not(SW2(1)) and not(SW2(0))) or
				 (SW2(3) and not(SW2(2)) and SW2(1) and not(SW2(0)));
--e
	HEX2(4) <= (not(SW2(3)) and SW2(0)) or (not(SW2(3)) and SW2(2) and not(SW2(1))) or
				 (not(SW2(2)) and not(SW2(1)) and SW2(0));
--f
	HEX2(5) <= (SW2(3) and SW2(2) and not(SW2(1))) or (not(SW2(3)) and not(SW2(2)) and SW2(0)) or
				 (not(SW2(3)) and not(SW2(2)) and SW2(1)) or (not(SW2(3)) and SW2(1) and SW2(0));
--g
	HEX2(6) <= (not(SW2(3)) and not(SW2(2)) and not(SW2(1))) or (not(SW2(3)) and SW2(2) and SW2(1) and SW2(0));

----1
--a
	HEX1(0) <= (SW1(2) and not(SW1(1)) and not(SW1(0))) or (SW1(3) and SW1(2) and not(SW1(1))) or
				 (not(SW1(3)) and not(SW1(2)) and not(SW1(1)) and SW1(0)) or
				 (SW1(3) and not(SW1(2)) and SW1(1) and SW1(0));
--b
	HEX1(1) <= (SW1(3) and SW1(1) and SW1(0)) or (SW1(2) and SW1(1) and not(SW1(0))) or
				 (SW1(3) and SW1(2) and not(SW1(0))) or
				 (not(SW1(3)) and SW1(2) and not(SW1(1)) and SW1(0));
--c
	HEX1(2) <= (SW1(3) and SW1(2) and not(SW1(0))) or (SW1(3) and SW1(2) and SW1(1)) or
				 (not(SW1(3)) and not(SW1(2)) and SW1(1) and not(SW1(0)));
--d
	HEX1(3) <= (not(SW1(2)) and not(SW1(1)) and SW1(0)) or (SW1(2) and SW1(1) and SW1(0)) or
				 (not(SW1(3)) and SW1(2) and not(SW1(1)) and not(SW1(0))) or
				 (SW1(3) and not(SW1(2)) and SW1(1) and not(SW1(0)));
--e
	HEX1(4) <= (not(SW1(3)) and SW1(0)) or (not(SW1(3)) and SW1(2) and not(SW1(1))) or
				 (not(SW1(2)) and not(SW1(1)) and SW1(0));
--f
	HEX1(5) <= (SW1(3) and SW1(2) and not(SW1(1))) or (not(SW1(3)) and not(SW1(2)) and SW1(0)) or
				 (not(SW1(3)) and not(SW1(2)) and SW1(1)) or (not(SW1(3)) and SW1(1) and SW1(0));
--g
	HEX1(6) <= (not(SW1(3)) and not(SW1(2)) and not(SW1(1))) or (not(SW1(3)) and SW1(2) and SW1(1) and SW1(0));

----0	
--a
	HEX0(0) <= (SW0(2) and not(SW0(1)) and not(SW0(0))) or (SW0(3) and SW0(2) and not(SW0(1))) or
				 (not(SW0(3)) and not(SW0(2)) and not(SW0(1)) and SW0(0)) or
				 (SW0(3) and not(SW0(2)) and SW0(1) and SW0(0));
--b
	HEX0(1) <= (SW0(3) and SW0(1) and SW0(0)) or (SW0(2) and SW0(1) and not(SW0(0))) or
				 (SW0(3) and SW0(2) and not(SW0(0))) or
				 (not(SW0(3)) and SW0(2) and not(SW0(1)) and SW0(0));
--c
	HEX0(2) <= (SW0(3) and SW0(2) and not(SW0(0))) or (SW0(3) and SW0(2) and SW0(1)) or
				 (not(SW0(3)) and not(SW0(2)) and SW0(1) and not(SW0(0)));
--d
	HEX0(3) <= (not(SW0(2)) and not(SW0(1)) and SW0(0)) or (SW0(2) and SW0(1) and SW0(0)) or
				 (not(SW0(3)) and SW0(2) and not(SW0(1)) and not(SW0(0))) or
				 (SW0(3) and not(SW0(2)) and SW0(1) and not(SW0(0)));
--e
	HEX0(4) <= (not(SW0(3)) and SW0(0)) or (not(SW0(3)) and SW0(2) and not(SW0(1))) or
				 (not(SW0(2)) and not(SW0(1)) and SW0(0));
--f
	HEX0(5) <= (SW0(3) and SW0(2) and not(SW0(1))) or (not(SW0(3)) and not(SW0(2)) and SW0(0)) or
				 (not(SW0(3)) and not(SW0(2)) and SW0(1)) or (not(SW0(3)) and SW0(1) and SW0(0));
--g
	HEX0(6) <= (not(SW0(3)) and not(SW0(2)) and not(SW0(1))) or (not(SW0(3)) and SW0(2) and SW0(1) and SW0(0));

end behavioral;