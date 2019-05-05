library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;	 
use ieee.std_logic_unsigned.all;

package reg_file1 is
component reg_file is 
	port (wr_ad,RA_ad,RB_ad:in std_logic_vector(2 downto 0);Mem_wr: in std_logic;data_in: in std_logic_vector(15 downto 0);
			RAv,RBv: out std_logic_vector(15 downto 0));
end component reg_file;
end package reg_file1;

------------------------------------register file----------------------------------

library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;	 
use ieee.std_logic_unsigned.all;

entity reg_file2 is
	port (wr_ad,RA_ad,RB_ad:in std_logic_vector(2 downto 0);Mem_wr: in std_logic;data_in: in std_logic_vector(15 downto 0);
			RAv,RBv: out std_logic_vector(15 downto 0));
end entity reg_file2;

architecture Form of reg_file2 is 
type reg_array is array(7 downto 0) of std_logic_vector(15 downto 0);   -- defining a new type
signal Memory: reg_array:=(0=>x"3000",1 => x"3000",2 => x"1057",3 => x"4442",4 => x"0458",5 => x"2460",6 => x"2921",7 => x"0000");

begin
RAv<= Memory(conv_integer(RA_ad));
RBv<= Memory(conv_integer(RB_ad));

Mem_write:

process (Mem_wr,data_in,wr_ad)
	begin
	if(rising_edge( Mem_wr) )then
		Memory(conv_integer(wr_ad)) <= data_in;
	end if;
	end process;
end Form;























