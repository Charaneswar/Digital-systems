
Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity decoder is
    port(CF,ZF: in std_logic;
         IR1: in std_logic_vector(3 downto 0);
         IR2: in std_logic_vector(1 downto 0);
         PreS: in std_logic_vector(4 downto 0);
         --FSM: in std_logic_vector(2 downto 0); 
         NextS: out std_logic_vector(4 downto 0);
         enablepins: out std_logic_vector(26 downto 0));
end decoder;
-- here FSM is 3-bit counter used for StoreAll and LoadAll
-- enablepins(0) = en_IP              enablepins(14) = en_MUX_T2_1
-- enablepins(1) = en_MUX_Read        enablepins(15) = en_MUX_T2_2
-- enablepins(2) = en_Read            enablepins(16) = en_T2
-- enablepins(3) = en_Write           enablepins(17) = en_T3
-- enablepins(4) = en_MUX_Write       enablepins(18) = en_ALU1
-- enablepins(5) = en_IR              enablepins(19) = en_ALU2_1
-- enablepins(6) = en_A1_1            enablepins(20) = en_ALU2_2
-- enablepins(7) = en_A1_2            enablepins(21) = en_ALU_1
-- enablepins(8) = en_A2              enablepins(22) = en_ALU_2
-- enablepins(9) = en_A3_1            enablepins(23) = en_MUX_T1
-- enablepins(10) = en_A3_2           enablepins(24) = en_T1
-- enablepins(11) = en_Write_RF       enablepins(25) = en_ZF
-- enablepins(12) = en_D3_1           enablepins(26) = en_CF
-- enablepins(13) = en_D3_2            

architecture behavioral of decoder is

    begin

        decode : process(PreS)
        begin
----------------------------------------Stage 1------------------------------------
            if(PreS = "00000") then --S1
                enablepins <="0110-1-----0----00011001100";
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
                end if;
--------------------------------Stage 2---------------------------------------------            
            elsif(PreS = "00001") then -- S2
                enablepins <="0-00-0101--0--0111---11-000";
                if((IR1 ="0000") or (IR1 ="0010")) then -- NAND and ADD
                    if((IR2 ="10") and (CF ='0')) then
                        NextS <= "10110"; -- S14
                    elsif((IR2 ="01") and (ZF ='0')) then
                        NextS <= "10110"; -- S14
                    else
                        NextS <= "10100"; -- S9
                    end if;
                elsif(IR1 ="1100") then -- BEQ
                    NextS <= "10100";  -- S9
                end if;
          
                    
            elsif(PreS = "00010") then -- S3
                enablepins <="0-00-010---0--0110---11-000";
                if(IR1 ="0111") then -- STORE_ALL
                    NextS <= "11000"; --S10
                elsif(IR1 ="0110") then -- LOAD_ALL
                    NextS <= "11001"; --S11
                elsif(IR1 ="0001") then -- ADI
                    NextS <= "11010"; -- S12
                end if;
            
            elsif(PreS ="00100") then --S4 
                enablepins <= "0-00-0---00110--00---11-000";
                if(IR1 ="1000") then
                    NextS <= "11100";
                end if; --S13
            
            elsif(PreS ="01000") then --S5
                enablepins <= "1-00-0---00101--00---11-000";
                if(IR1 ="0011") then
                    NextS <= "00000"; --S1
                end if;
            
            
            elsif(Pres ="10000") then --S6
                enablepins <= "0-00-0010--0--0111---11-000";
                if(IR1 ="0101") then
                    NextS <= "11010"; --S12
                end if;
            
            elsif(Pres ="10001") then --S7
                enablepins <= "0-00-001---0--0110---11-000";
                if(IR1="0100") then
                    NextS <= "11010"; --S12
                end if;
            
            elsif(Pres ="10010") then --S8
                enablepins <= "0-00-001-00110--00---110100";
                if(IR1 ="1001") then
                    NextS <= "10110"; --S14 */
                end if;

-------------------------------------Stage 3----------------------------------            
            
            elsif(PreS = "10100") then
		enablepins <= "0-00-0-----0--001010000-011";
		if(IR1 ="0000") then
			NextS <= "01001";
		end if;
                            
            
            


            
        end if;
            
            end process;

end behavioral;


