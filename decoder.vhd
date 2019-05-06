library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

package dfgh is
component decoder is
    port(CF,ZF,reset_in: in std_logic:= '0';
         IR1: in std_logic_vector(3 downto 0):= (others=>'0');
         IR2: in std_logic_vector(1 downto 0):= (others=>'0');
         PreS: in std_logic_vector(4 downto 0):= (others=>'0');
         NextS: out std_logic_vector(4 downto 0) := (others=>'Z');
         enablepins: out std_logic_vector(26 downto 0):= "100110001101111011100110011";
			reset:out std_logic;
			FSM_counter:in std_logic_vector(2 downto 0):= (others=>'0'));
end component decoder;
end package dfgh;

----------------------decoder---------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity decoder is
    port(CF,ZF,reset_in: in std_logic:= '0';
         IR1: in std_logic_vector(3 downto 0):= (others=>'0');
         IR2: in std_logic_vector(1 downto 0):= (others=>'0');
         PreS: in std_logic_vector(4 downto 0):= (others=>'0');
         NextS: out std_logic_vector(4 downto 0):= (others=>'Z');
         enablepins: out std_logic_vector(26 downto 0) := "100110001101111011100110011";
			reset:out std_logic;
			FSM_counter:in std_logic_vector(2 downto 0):= (others=>'0'));
end entity decoder;

architecture behavioral of decoder is

    begin

        decode : process(PreS,reset_in)
        begin
				if(reset_in='1') then
					enablepins <="100110001101111011100110011";
					
			
----------------------------------------Stage 1------------------------------------
            elsif(PreS = "00000") then --S1
                enablepins <="011001110010000100011001100";
                if((IR1 = "0000") or (IR1 = "0010") or (IR1 = "1100")) then
                    NextS <= "00001";
                elsif((IR1 = "0111") or (IR1 = "0001") or (IR1 = "0110")) then
                    NextS <= "10010";
                elsif(IR1 = "0101") then
                    NextS <= "10000";
                elsif(IR1 = "0100") then
                    NextS <= "10001";
                elsif(IR1 = "1001") then
                    NextS <= "10010";
                elsif(IR1 = "1000") then
                    NextS <= "00100";
                elsif(IR1 = "0011") then
                    NextS <= "01000";
					 else
						  NextS <="00000";
                end if;
--------------------------------Stage 2---------------------------------------------            
            elsif(PreS = "00001") then -- S2
                enablepins <="010010101000000111100110000";
                if((IR1 ="0000") or (IR1 ="0010")) then -- NAND and ADD
                    if((IR2 ="10") and (CF ='0')) then
                        NextS <= "10110"; -- S14
                    elsif((IR2 ="01") and (ZF ='0')) then
                        NextS <= "10110"; -- S14
                    else
                        NextS <= "10100"; -- S9
                    end if;
                elsif(IR1 ="1100") then -- BEQ
                    NextS <= "10100"; 
					 else
						  NextS <= "00000";
					 -- S9
                end if;
          
                    
            elsif(PreS = "00010") then -- S3
                enablepins <="000010100000000110001111000";
                if(IR1 ="0111") then -- STORE_ALL
                    NextS <= "11000"; --S10
                elsif(IR1 ="0110") then -- LOAD_ALL
                    NextS <= "11001"; --S11
                elsif(IR1 ="0001") then -- ADI
                    NextS <= "11010"; -- S12
					 else 
						  NextS <= "00000";
						  
                end if;
            
            elsif(PreS ="00100") then --S4 
                enablepins <= "000010010001100000111110000";
                if(IR1 ="1000") then
                    NextS <= "11100";
					 else
						  NextS <= "00000";
                end if; --S13
            
            elsif(PreS ="01000") then --S5
                enablepins <= "100000000001011100000111000";
                if(IR1 ="0011") then
                    NextS <= "00000"; --S1
					 else
						  NextS <= "00000";
                end if;
            
            
            elsif(Pres ="10000") then --S6
                enablepins <= "010000010110000111000111000";
                if(IR1 ="0101") then
                    NextS <= "11010"; --S12
                end if;
            
            elsif(Pres ="10001") then --S7
                enablepins <= "000000010010000110111110000";
                if(IR1="0100") then
                    NextS <= "11010"; --S12
					 else
						  Nexts <= "00000";
                end if;
            
            elsif(Pres ="10010") then --S7
                enablepins <= "000000011110000110001111000";
                if(IR1="1001") then
                    NextS <= "10110"; --S12
					 else
						  NextS <= "00000";
                end if;
            

-------------------------------------Stage 3----------------------------------            
        
            elsif(PreS = "10100") then --S9
                
                if(IR1 = "0000") then
						  enablepins <="010000001100000010100000011";
                    NextS <= "01001";
                elsif(IR1 = "0010") then
						  enablepins <="010000101010000010100010010";
                    NextS <= "01001";
					 elsif((IR1 = "1100") and (ZF='1')) then
						  enablepins <="010000101010000010100100010";
                    NextS <= "11110";
					 else
						  NextS <= "10110";
						  enablepins <="000010101010000010100101010";
               
                end if;
					 
				elsif(Pres ="11100") then --S13
                enablepins <= "010000101010001100010001100";
                if(IR1="1000") then
                    NextS <= "10110"; --S14
                end if;
					 
				
				elsif(PreS = "10110") then --S14
                enablepins <="110000000000111000000111000";
                if(IR1 = "0000") then
                    NextS <= "00000";
                else
                    NextS <= "00000"; --S1
                
                end if;
					 
				elsif(Pres ="01001") then --S17
                enablepins <= "010010101010000000010001100";
                if((IR1="0000")or(IR1="0010")) then
                    NextS <= "00000"; --S1
                end if;
				
			
					 
				 elsif(Pres ="10101") then --S16
                enablepins <= "100010100101110000000111100";
                if(IR1="0001") then
                    NextS <= "00000"; --S1
                end if;
				
				elsif(Pres ="01101") then --S20
                enablepins <= "110010000001110000000110000";
                if(IR1="0100") then
                    NextS <= "00000"; --S1
                end if;
				
				
				elsif(Pres ="01010") then --S19
                enablepins <= "100100001110000000001111000";
                if(IR1="0101") then
                    NextS <= "00000"; --S1
                end if;
				
				elsif(Pres ="00101") then --S18
                enablepins <= "001010010010101010000110000";
                if(IR1="0100") then
                    NextS <= "01101"; --S20
					 else
						  NextS <= "00000";
                end if;
				
				elsif(PreS = "11010") then --S1
                if(IR1 = "0001") then
                    NextS <= "10101";
						  enablepins <="010000110110000010101001011";
                elsif(IR1 = "0100") then
                    NextS <= "00101";
						  enablepins <="010000110110000010101001010";
                elsif(IR1 = "0101") then
                    NextS <= "01010";
						  enablepins <="010000110110000010101001000";
					 else
						  NextS <="00000";
						  enablepins <="010000110110000010101001000";
                end if;
					 
				elsif(PreS = "11000") then
					  enablepins <="010110001110000010111001000";
				     if(IR1="0111") then
							Reset <='1';
							NextS <="11111";
					  end if;
					  
			  elsif(PreS ="11111") then --temporary state for counter for store_all
					  enablepins <="010110001110000010111001000";
					  if(IR1="0111") then
							if(FSM_counter/="111") then
								Reset <='0';
								NextS<="11111";
							else
								NextS<="10110";
							end if;
						end if;
					
			
			   elsif(PreS = "11001") then
					  enablepins <="001010000111000010111000000";
				     if(IR1="0110") then
							Reset <='1';
							NextS <="01111"; --temporary state
					  end if;
				
					  
			  elsif(PreS ="01111") then --temporary state for counter for store_all
					  enablepins <="001000000111000010111000000";
					  if(IR1="0110") then
							if(FSM_counter/="111") then
								Reset <='0';
								NextS<="01111";
							else
								NextS<="10110";
							end if;
						end if;
				


       	  
           


            
        end if;
            
            end process;

end behavioral;











































