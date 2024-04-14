library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.lab8_package.all;

entity upcount is
	port(	clear,clock : in std_logic;
			Q : buffer std_logic_vector(1 downto 0)
	);
end upcount;

architecture LogicFunc of upcount is
BEGIN
	upcount: process ( Clock )
	BEGIN
		IF (Clock'EVENT AND Clock = '1') THEN
			IF Clear = '1' THEN
				Q <= "00" ;
			ELSE
				Q <= Q + '1' ;
			END IF ;
		END IF;
	END process;
end LogicFunc;