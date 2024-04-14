library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
entity div_clk is
generic(divisor:integer:=50000000); -- 因為要產生1Hz的Clock, 所以定義除數為5000000
port(
    enable : in std_logic;
    clk_in: in std_logic;
    clk_out: out std_logic
);
end div_clk;

architecture arch of div_clk is
signal cnt2 : std_logic := '0';
begin
    process(clk_in, enable)
        variable cnt1 : integer range 0 to divisor:=1;
    begin
            if (enable = '0') then
                cnt1 :=1 ;
					 cnt2 <='0';
            elsif(clk_in'event and clk_in='1') then -- cnt1為計數器，累加至4000000時歸0
                if cnt1 = divisor then 
                    cnt1 := 1;
                    cnt2 <= not cnt2;
                else
                    cnt1 := cnt1 + 1;
                end if;
				-- if((cnt1 = divisor)) then -- cn1 為2000000或4000000時，輸出做反向
                --     cnt2<= not cnt2;
                -- end if;
            end if;
            clk_out <= cnt2;
    end process;
end arch;
    