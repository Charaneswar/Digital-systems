library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
package cytu is
component counter2 is
    Port ( clk: in std_logic; -- clock input
           reset: in std_logic; -- reset input 
           counter: out std_logic_vector(2 downto 0) -- output 4-bit counter
     );
end component counter2;
end package cytu;

------------------------counter----------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity counter2 is
    Port ( clk: in std_logic:= '0'; -- clock input
           reset: in std_logic:= '0'; -- reset input 
           counter: out std_logic_vector(2 downto 0):= (others=>'0') -- output 4-bit counter
     );
end entity counter2;

architecture Behavioral of counter2 is
signal counter_up: std_logic_vector(2 downto 0);
begin
-- up counter
process(clk,reset)
begin
if(rising_edge(clk)) then
    if(reset='1') then
         counter_up <= "000";
    else
        counter_up <= counter_up + "001";
    end if;
 end if;
end process;
 counter <= counter_up;

end Behavioral;