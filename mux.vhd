library ieee;
use ieee.std_logic_1164.all;
package mux is	

	component sixteen_bit_4 is
		port ( A,B,C,D: in STD_LOGIC_VECTOR(15 downto 0):= (others=>'0');s1,s2: in std_logic; Y : out STD_LOGIC_VECTOR(15 downto 0):= (others=>'0'));
	end component sixteen_bit_4;
	
	component three_bit_4 is
		port ( A,B,C,D : in STD_LOGIC_VECTOR(2 downto 0):= (others=>'0'); s1,s2: in std_logic; Y : out STD_LOGIC_VECTOR(2 downto 0):= (others=>'0'));
	end component three_bit_4;
	
	component sixteen_bit_2 is
		port ( A,B : in STD_LOGIC_VECTOR(15 downto 0):= (others=>'0');s: in std_logic; Y : out STD_LOGIC_VECTOR(15 downto 0):= (others=>'0'));
	end component sixteen_bit_2;
	
	component three_bit_2 is
		port ( A,B : in STD_LOGIC_VECTOR(2 downto 0):= (others=>'0');s: in std_logic; Y : out STD_LOGIC_VECTOR(2 downto 0):= (others=>'0'));
	end component three_bit_2;
	
end package mux;

-------------------------------------16 bit 4 to 1 ---------------------------------

library ieee;
use ieee.std_logic_1164.all;

	entity sixteen_bit_4 is
		port ( A,B,C,D: in STD_LOGIC_VECTOR(15 downto 0):= (others=>'0'); s1,s2: in std_logic; Y : out STD_LOGIC_VECTOR(15 downto 0):= (others=>'0'));
	end entity sixteen_bit_4;
	
	architecture Equations of sixteen_bit_4 is
	signal sig1,sig2:STD_LOGIC_VECTOR(15 downto 0);
	begin
	sig1 <= (others => s1);
	sig2 <= (others => s2);
	
	Y <= ((not sig1) and (not sig2 ) and A) or (not sig2 and sig1 and B) or (sig2 and not sig1 and C) or (sig1 and sig2 and D);
	end Equations;
	
--------------------------------------3 bit 4 to 1------------------------------------------	

library ieee;
use ieee.std_logic_1164.all;
	entity three_bit_4 is
		port ( A,B,C,D : in STD_LOGIC_VECTOR(2 downto 0):= (others=>'0'); s1,s2: in std_logic; Y : out STD_LOGIC_VECTOR(2 downto 0):= (others=>'0'));
	end entity three_bit_4;
	
	architecture Equations of three_bit_4 is
	signal sig1,sig2:STD_LOGIC_VECTOR(2 downto 0);
	begin 
	sig1 <= (others => s1);
	sig2 <= (others => s2);
	
	Y <= ((not sig1) and (not sig2 ) and A) or ((not sig2) and sig1 and B) or (sig2 and (not sig1) and C) or (sig1 and sig2 and D);
	end Equations;

---------------------------------------16 bit 2 to 1---------------------------------	

library ieee;
use ieee.std_logic_1164.all;

	
	entity sixteen_bit_2 is
		port ( A,B : in STD_LOGIC_VECTOR(15 downto 0):= (others=>'0');s: in std_logic; Y : out STD_LOGIC_VECTOR(15 downto 0):= (others=>'0'));
	end entity sixteen_bit_2;
	
	architecture Equations of sixteen_bit_2 is
	signal sig:STD_LOGIC_VECTOR(15 downto 0);
	begin
	sig <= (others => s);
	Y <= ((not sig) and  A) or (sig and B) ;
	end Equations;
	
--------------------------------------3 bit 2 to 1----------------------------------------------	
	
library ieee;
use ieee.std_logic_1164.all;

	
	entity three_bit_2 is
		port ( A,B : in STD_LOGIC_VECTOR(2 downto 0):= (others=>'0');s: in std_logic; Y : out STD_LOGIC_VECTOR(2 downto 0):= (others=>'0'));
	end entity three_bit_2;
	
	architecture Equations of three_bit_2 is
	signal sig:STD_LOGIC_VECTOR(2 downto 0);
	begin
	sig <= (others => s);
	Y <= ((not sig) and  A) or (sig and B) ;
	end Equations;
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	