library ieee;
use ieee.std_logic_1164.all;
package flipflop1 is

component flipflop is 
   port(Q : out std_logic;Clk,D :in  std_logic);
end component flipflop;

end package flipflop1;

-----------------------------postive edge D-flip flop------------------------

library ieee;
use ieee.std_logic_1164.all;

entity flipflop is 
   port(Q : out std_logic;Clk,D :in  std_logic);
end entity flipflop;

architecture Behavioral of flipflop is  
begin  
 process(Clk)
 begin 
    if(rising_edge(Clk)) then
   Q <= D; 
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
   port(Q:out std_logic_vector(15 downto 0); Clk :in std_logic; D :in  std_logic_vector(15 downto 0));
end component reg;
end package reg1;

-----------------------------16 bit register--------------------------

library ieee;
use ieee.std_logic_1164.all;
library work;
use work.flipflop1.all;

entity reg is 
   port(Q:out std_logic_vector(15 downto 0); Clk :in std_logic; D :in  std_logic_vector(15 downto 0));
end entity reg;

architecture Behavioral of reg is  
begin  
 process(Clk)
 begin 
    if(rising_edge(Clk)) then
   Q <= D; 
    end if;       
 end process;  
end Behavioral; 

---------------------------------------------------------------------



