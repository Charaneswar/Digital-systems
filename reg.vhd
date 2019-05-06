library ieee;
use ieee.std_logic_1164.all;
package flipflop1 is

component flipflop is 
   port(Q : out std_logic:= '0';Clk,D,reset :in  std_logic:= '0');
end component flipflop;

end package flipflop1;

-----------------------------postive edge D-flip flop------------------------

library ieee;
use ieee.std_logic_1164.all;

entity flipflop is 
   port(Q : out std_logic:= '0';Clk,D,reset :in  std_logic:= '0');
end entity flipflop;

architecture Behavioral of flipflop is  
begin  
 process(Clk,reset)
 begin 
    if(rising_edge(Clk)) then
		if(reset='1') then 
		 Q <='0';
		else 
		 Q <= D; 
		end if;
    end if;  
 end process;  
end Behavioral; 

-------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
library work;
use work.flipflop1.all;

package reg1 is
component reg is 
   port(Q:out std_logic_vector(15 downto 0):= (others=>'0'); Clk,reset :in std_logic:= '0'; D :in  std_logic_vector(15 downto 0):= (others=>'0'));
end component reg;

component reg_5bit is 
   port(Q:out std_logic_vector(4 downto 0); Clk,reset :in std_logic:= '0'; D :in  std_logic_vector(4 downto 0):= (others=>'0'));
end component reg_5bit;

end package reg1;

-----------------------------16 bit register--------------------------

library ieee;
use ieee.std_logic_1164.all;
library work;
use work.flipflop1.all;

entity reg is 
   port(Q:out std_logic_vector(15 downto 0):= (others=>'0'); Clk,reset :in std_logic:= '0'; D :in  std_logic_vector(15 downto 0):= (others=>'0'));
end entity reg;

architecture Behavioral of reg is  
begin  
 process(Clk)
 begin 
    if(rising_edge(Clk)) then
		if(reset='1') then 
		 Q <= (others=>'0');
		else 
		 Q <= D; 
		end if;
    end if;   
 end process;  
end Behavioral; 

-------------------------------5 bit register--------------------------------------

library ieee;
use ieee.std_logic_1164.all;
library work;
use work.flipflop1.all;

entity reg_5bit is 
   port(Q:out std_logic_vector(4 downto 0):= (others=>'0'); Clk,reset :in std_logic:= '0'; D :in  std_logic_vector(4 downto 0):= (others=>'0'));
end entity reg_5bit;

architecture Behavioral of reg_5bit is  
begin  
 process(Clk)
 begin 

    if(rising_edge(Clk)) then
		if(reset='1') then 
		 Q <= (others=>'0');
		else 
		 Q <= D; 
		end if;
    end if; 
 end process;  
end Behavioral; 

---------------------------------------------

