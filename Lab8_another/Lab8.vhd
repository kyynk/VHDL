library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use work.lab8_package.all;

entity Lab8 is
	port(	clk		: in std_logic;
			rs, rt	: in std_logic_vector(1 downto 0);
			op		: in std_logic_vector(3 downto 0);
			data 	: in std_logic_vector(7 downto 0);
			bus0, bus1, rs2, rs3, rt4, rt5 :out std_logic_vector(6 downto 0)
	);
end Lab8;

architecture behavior of Lab8 is
	signal x,y,rin,rout : std_logic(0 to 3);
	signal clear,high,addsub:std_logic;
	signal extern, ain, gin, gout frin:std_logic;
	signal count,zero,T,I : std_logic_vector(1 downto 0);
	signal R0,R1,R2,R3,rsreg,rtreg : std_logic_vector(7 downto 0);
	signal A, sum,G : std_logic_ 
begin
	signal rs,rt:std_logic_vector(7 downto 0);

--if RS = "00"
--	rs <= r0
--elsif RS = "01"
--	rs <= r1
--elsif RS = "10"
--	rs <= r2
--elsif RS = "11"
--	rs <= r3
--
--if RT = "00"
--    rt <= r0
--elsif RT = "01"
--    rt <= r1
--elsif RT = "10"
--    rt <= r2
--elsif RT = "11"
--    rt <= r3
--
if op = "0000"
    rs <= data
if op = "0001"
    rs <= rt
if op = "0010"
    rs <= rs + rt
if op = "0011"
    rs <= rs & rt
if op = "0101"
    rs <= rs - rt
if op = "1001"
    rs <= rt - rs
if op = "0100"
    if rs-rt < 0
        rs <= 00...01
    else
        rs <= 00...00

--if RS = "00"
--    r0 <= rs
--elsif RS = "01"
--    r1 <= rs
--elsif RS = "10"
--    r2 <= rs
--elsif RS = "11"
--    r3 <= rs
--
--if RT = "00"
--    r0 <= rt
--elsif RT = "01"
--    r1 <= rt
--elsif RT = "10"
--    r2 <= rt
--elsif RT = "11"
    r3 <= rt
end behavior;