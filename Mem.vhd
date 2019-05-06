library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;	 
use ieee.std_logic_unsigned.all;
package zxcv is
component Mem_synced is 
	port (re_ad,wr_ad,Mem_datain: in std_logic_vector(15 downto 0); Mem_wr,Mem_re: in std_logic;
				Mem_dataout: out std_logic_vector(15 downto 0));
end component Mem_synced;
end package zxcv;

-------------------------------Memory-----------------------------------------------


-------------------------------Memory-----------------------------------------------

library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;	 
use ieee.std_logic_unsigned.all;


entity Mem_synced is 
	port (re_ad,wr_ad,Mem_datain: in std_logic_vector(15 downto 0); Mem_wr,Mem_re: in std_logic;
				Mem_dataout: out std_logic_vector(15 downto 0));
end entity Mem_synced;

architecture Form of Mem_synced is 
type regarray is array(65535 downto 0) of std_logic_vector(15 downto 0);   -- defining a new type
signal Memory: regarray:=(
0=> "0000000001010000" ,1 => "0000000001010010",2 => "1100011100010000",3 => x"4442",4 => x"0458",5 => x"2460",6 => x"2921",7 => x"0000",8 => x"2921",9 => x"58c0",10 => x"7292",11 => x"6e60",12 => x"c040",13 => x"127f",14 => x"c241",16 => x"9440",22 => x"83f5",25 => x"ffed",others => "0000000000000000");

begin

Mem_read:
process (Mem_re,re_ad)
	begin
	if(Mem_re = '1') then
		Mem_dataout <= Memory(conv_integer(re_ad));
	end if;
	end process;

Mem_write:
process (Mem_wr,Mem_datain,wr_ad)
	begin
	if(rising_edge( Mem_wr)) then
		Memory(conv_integer(wr_ad)) <= Mem_datain;
	end if;
	end process;
end Form;
