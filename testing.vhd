library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;	 
use ieee.std_logic_unsigned.all;

package reg_file1 is
component reg_file is 
	port (wr_ad,RA_ad,RB_ad:in std_logic_vector(2 downto 0):= (others=>'0');Mem_wr: in std_logic:= '0';data_in: in std_logic_vector(15 downto 0):= (others=>'0');
			RAv,RBv: out std_logic_vector(15 downto 0):= (others=>'0'));
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

entity reg_file is
	port (wr_ad,RA_ad,RB_ad:in std_logic_vector(2 downto 0):= (others=>'Z');Mem_wr: in std_logic:= '0';data_in: in std_logic_vector(15 downto 0):= (others=>'Z');
			RAv,RBv: out std_logic_vector(15 downto 0):= (others=>'0'));
end entity reg_file;

architecture Form of reg_file is 
type reg_array is array(7 downto 0) of std_logic_vector(15 downto 0);   -- defining a new type
signal Memory: reg_array:=(0=>x"ffff",1 => x"3000",2 => x"1057",3 => x"4442",4 => x"4442",5 => x"2460",6 => x"2921",7 => x"0000");

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

------------------------------------------------------------------------------------------------
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
   port(Q:out std_logic_vector(4 downto 0):="00001"; Clk,reset :in std_logic:= '0'; D :in  std_logic_vector(4 downto 0):="00010");
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
   port(Q:out std_logic_vector(4 downto 0):= "00001"; Clk,reset :in std_logic:= '0'; D :in  std_logic_vector(4 downto 0):= "00010");
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

library ieee;
use ieee.std_logic_1164.all;
package mux is	

	component sixteen_bit_4 is
		port ( A,B,C,D: in STD_LOGIC_VECTOR(15 downto 0):= (others=>'Z');s1,s2: in std_logic; Y : out STD_LOGIC_VECTOR(15 downto 0):= (others=>'Z'));
	end component sixteen_bit_4;
	
	component three_bit_4 is
		port ( A,B,C,D : in STD_LOGIC_VECTOR(2 downto 0):= (others=>'Z'); s1,s2: in std_logic; Y : out STD_LOGIC_VECTOR(2 downto 0):= (others=>'Z'));
	end component three_bit_4;
	
	component sixteen_bit_2 is
		port ( A,B : in STD_LOGIC_VECTOR(15 downto 0):= (others=>'Z');s: in std_logic; Y : out STD_LOGIC_VECTOR(15 downto 0):= (others=>'Z'));
	end component sixteen_bit_2;
	
	component three_bit_2 is
		port ( A,B : in STD_LOGIC_VECTOR(2 downto 0):= (others=>'Z');s: in std_logic; Y : out STD_LOGIC_VECTOR(2 downto 0):= (others=>'Z'));
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
		port ( A,B,C,D : in STD_LOGIC_VECTOR(2 downto 0):= (others=>'Z'); s1,s2: in std_logic; Y : out STD_LOGIC_VECTOR(2 downto 0):= (others=>'Z'));
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
	
	
	
	-----------------------------------------------------------
	library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;	 
use ieee.std_logic_unsigned.all;
package zxcv is
component Mem_synced is 
	port (re_ad,wr_ad,Mem_datain: in std_logic_vector(15 downto 0):=(others=>'Z'); Mem_wr,Mem_re: in std_logic:='0';
				Mem_dataout: out std_logic_vector(15 downto 0):=(others=>'Z'));
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
	port (re_ad,wr_ad,Mem_datain: in std_logic_vector(15 downto 0):=(others=>'Z'); Mem_wr,Mem_re: in std_logic:='0';
				Mem_dataout: out std_logic_vector(15 downto 0):=(others=>'Z'));
end entity Mem_synced;

architecture Form of Mem_synced is 
type regarray is array(255 downto 0) of std_logic_vector(15 downto 0);   -- defining a new type
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
------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
library work;
use work.reg1.all;

package inst_reg1 is
component inst_reg is 
   port(RA,RB,RC:out std_logic_vector(2 downto 0):= (others=>'Z'); 
			Clk :in std_logic:= '0'; 
			A:in std_logic_vector(15 downto 0):= (others=>'Z');
			op:out std_logic_vector(3 downto 0):= (others=>'Z');
			cz:out std_logic_vector(1 downto 0):= (others=>'Z');
			imm9_l:out std_logic_vector(15 downto 0):= (others=>'Z');
			imm9_s:out std_logic_vector(15 downto 0):= (others=>'Z');
			imm6:out std_logic_vector(15 downto 0):= (others=>'Z'));
end component inst_reg;
end package inst_reg1;

---------------------------------instruction register------------------------------

library ieee;
use ieee.std_logic_1164.all;
library work;
use work.reg1.all;
entity inst_reg is 
   port(RA,RB,RC:out std_logic_vector(2 downto 0):= (others=>'Z'); 
			Clk :in std_logic:= '0'; 
			A:in std_logic_vector(15 downto 0):= (others=>'Z');
			op:out std_logic_vector(3 downto 0):= (others=>'Z');
			cz:out std_logic_vector(1 downto 0):= (others=>'Z');
			imm9_l:out std_logic_vector(15 downto 0):= (others=>'Z');
			imm9_s:out std_logic_vector(15 downto 0):= (others=>'Z');
			imm6:out std_logic_vector(15 downto 0):= (others=>'Z'));
end entity inst_reg;

architecture Equations of inst_reg is 
signal q1:std_logic_vector(15 downto 0):= (others=>'Z');


 begin
	process(Clk)
	
	begin
		if(clk='1') then
			q1<=A;
		end if;
		end process;
		
	op <= q1(15 downto 12);
	RA <= q1(11 downto 9);
	RB <= q1(8 downto 6);
	RC <= q1(5 downto 3);
	cz <= q1(1 downto 0);
	imm6(5 downto 0) <= q1(5 downto 0);
	imm6(15 downto 6) <= (others => q1(5));
	imm9_s(8 downto 0) <=q1(8 downto 0);
	imm9_s(15 downto 9) <=(others => q1(8));
	imm9_l(15 downto 7) <= q1(8 downto 0);
	imm9_l(6 downto 0) <=(others => '0');
	
end Equations;
	
	----------------------------------------------------------------------------------
	library ieee;
use ieee.std_logic_1164.all;
package Fulladder is	

	component FULL_ADDER is
		port ( A,B,Cin : in STD_LOGIC; S,Cout : out STD_LOGIC);
	end component FULL_ADDER;
	
	end package Fulladder;
		
------------------------------------full adder--------------------------------------
  
library ieee;
use ieee.std_logic_1164.all;
entity FULL_ADDER is
   port (A, B, Cin: in std_logic; S, Cout: out std_logic);
end entity FULL_ADDER;

architecture Equations of FULL_ADDER is
begin
   S <= (A xor B) xor Cin;
   Cout <= (A and B) or ((A or B) and Cin) ;
end Equations;


------------------------------alu component package---------------------------------
library ieee;
use ieee.std_logic_1164.all;

package alu_components is
	component sixteen_bit_adder is
		port(	A,B :in std_logic_vector(15 downto 0) ; S:  out std_logic_vector(15 downto 0);C :out std_logic );
	end component sixteen_bit_adder;

	component sixteen_bit_nand is
		port(	A,B :in std_logic_vector(15 downto 0) ; S:  out std_logic_vector(15 downto 0));
	end component sixteen_bit_nand;	
	
	component sixteen_bit_xor is
		port(	A,B :in std_logic_vector(15 downto 0) ; S:  out std_logic_vector(15 downto 0));
	end component sixteen_bit_xor;	
	
end package alu_components;

---------------------------------16 bit adder---------------------------------------

library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Fulladder.all;
entity sixteen_bit_adder is
		port(	A,B :in std_logic_vector(15 downto 0) ; S:  out std_logic_vector(15 downto 0);C : out std_logic );
end entity sixteen_bit_adder;
architecture Equations of sixteen_bit_adder is 
	signal c1 : std_logic_vector(15 downto 0);

	begin
		f1:FULL_ADDER
			port map (A => A(0),B => B(0), Cin => '0', S=> S(0) ,Cout => c1(0));
		f2:FULL_ADDER
			port map (A => A(1),B => B(1), Cin => c1(0), S=> S(1) ,Cout => c1(1));
		f3:FULL_ADDER
			port map (A => A(2),B => B(2), Cin => c1(1), S=> S(2) ,Cout => c1(2));
		f4:FULL_ADDER
			port map (A => A(3),B => B(3), Cin => c1(2), S=> S(3) ,Cout => c1(3));
		f5:FULL_ADDER
			port map (A => A(4),B => B(4), Cin => c1(3), S=> S(4) ,Cout => c1(4));
		f6:FULL_ADDER
			port map (A => A(5),B => B(5), Cin => c1(4), S=> S(5) ,Cout => c1(5));
		f7:FULL_ADDER
			port map (A => A(6),B => B(6), Cin => c1(5), S=> S(6) ,Cout => c1(6));
		f8:FULL_ADDER
			port map (A => A(7),B => B(7), Cin => c1(6), S=> S(7) ,Cout => c1(7));
		f9:FULL_ADDER
			port map (A => A(8),B => B(8), Cin => c1(7), S=> S(8) ,Cout => c1(8));
		f10:FULL_ADDER
			port map (A => A(9),B => B(9), Cin => c1(8), S=> S(9) ,Cout => c1(9));
		f11:FULL_ADDER
			port map (A => A(10),B => B(10), Cin => c1(9), S=> S(10) ,Cout => c1(10));
		f12:FULL_ADDER
			port map (A => A(11),B => B(11), Cin => c1(10), S=> S(11) ,Cout => c1(11));
		f13:FULL_ADDER
			port map (A => A(12),B => B(12), Cin => c1(11), S=> S(12) ,Cout => c1(12));
		f14:FULL_ADDER
			port map (A => A(13),B => B(13), Cin => c1(12), S=> S(13) ,Cout => c1(13));
		f15:FULL_ADDER
			port map (A => A(14),B => B(14), Cin => c1(13), S=> S(14) ,Cout => c1(14));
		f16:FULL_ADDER
			port map (A => A(15),B => B(15), Cin => c1(14), S=> S(15) ,Cout => C);
end Equations;

--------------------------------------16 bit nand------------------------------------
library ieee;
use ieee.std_logic_1164.all;
entity sixteen_bit_nand is
		port(	A,B :in std_logic_vector(15 downto 0) ; S:  out std_logic_vector(15 downto 0));
end entity sixteen_bit_nand;

architecture Equations of sixteen_bit_nand is 
	begin
		S(0)<= A(0) nand B(0) ;
		S(1)<= A(1) nand B(1) ;
		S(2)<= A(2) nand B(2) ;
		S(3)<= A(3) nand B(3) ;
		S(4)<= A(4) nand B(4) ;
		S(5)<= A(5) nand B(5) ;
		S(6)<= A(6) nand B(6) ;
		S(7)<= A(7) nand B(7) ;
		S(8)<= A(8) nand B(8) ;
		S(9)<= A(9) nand B(9) ;
		S(10)<= A(10) nand B(10) ;
		S(11)<= A(11) nand B(11) ;
		S(12)<= A(12) nand B(12) ;
		S(13)<= A(13) nand B(13) ;
		S(14)<= A(14) nand B(14) ;
		S(15)<= A(15) nand B(15) ;
	end Equations;
	
--------------------------------------16 bit xor------------------------------------

library ieee;
use ieee.std_logic_1164.all;
entity sixteen_bit_xor is
		port(	A,B :in std_logic_vector(15 downto 0) ; S:  out std_logic_vector(15 downto 0));
end entity sixteen_bit_xor;

architecture Equations of sixteen_bit_xor is 
	begin
		S(0)<= A(0) xor B(0) ;
		S(1)<= A(1) xor B(1) ;
		S(2)<= A(2) xor B(2) ;
		S(3)<= A(3) xor B(3) ;
		S(4)<= A(4) xor B(4) ;
		S(5)<= A(5) xor B(5) ;
		S(6)<= A(6) xor B(6) ;
		S(7)<= A(7) xor B(7) ;
		S(8)<= A(8) xor B(8) ;
		S(9)<= A(9) xor B(9) ;
		S(10)<= A(10) xor B(10) ;
		S(11)<= A(11) xor B(11) ;
		S(12)<= A(12) xor B(12) ;
		S(13)<= A(13) xor B(13) ;
		S(14)<= A(14) xor B(14) ;
		S(15)<= A(15) xor B(15) ;
	end Equations;	

-------------------------------------ALU--------------------------------------

library ieee;
use ieee.std_logic_1164.all;
library work;
use work.alu_components.all;
use work.mux.all;
package ALU1 is
	component ALU is
		port(A,B :in std_logic_vector(15 downto 0):= (others=>'Z');
				S1,s2 :in std_logic;
				Y1:out std_logic_vector(15 downto 0):= (others=>'Z');
				C_flag,Z_flag:out std_logic:= '0');
	end component ALU;
end package ALU1;


library ieee;
use ieee.std_logic_1164.all;
library work;
use work.alu_components.all;
use work.mux.all;
entity ALU is
	port(A,B :in std_logic_vector(15 downto 0):= (others=>'Z');
			S1,s2 :in std_logic;
			Y1:out std_logic_vector(15 downto 0):= (others=>'Z');
			C_flag,Z_flag:out std_logic:= '0');
end entity ALU;

architecture Equations of ALU is

	signal Cout,zf1,zf2,zf3,zf4:std_logic;
	signal zero,ad,n,x,Y:std_logic_vector(15 downto 0);
	
begin
	
	zero <= (others =>'0');
	
	add1:sixteen_bit_adder
		port map( A => A,B => B, S=> ad,C=>Cout);
	nand1:sixteen_bit_nand
		port map(A=> A,B=>B,S=>n);
	xor1:sixteen_bit_xor
		port map(A=> A,B=>B,S=>x);
	mux1:sixteen_bit_4
		port map( s1 => s1, s2 => s2 ,A => ad,B => n, C => x ,D =>zero,Y=>Y);
	
	zf3 <= (A(1) xnor B(1)) or (A(2) xnor B(2)) or (A(3) xnor B(3)) or (A(4) xnor B(4)) or (A(5) xnor B(5)) or (A(6) xnor B(6)) or (A(7) xnor B(7)) or (A(8) xnor B(8)) or (A(9) xnor B(9)) or (A(10) xnor B(10)) or (A(11) xnor B(11)) or (A(12) xnor B(12)) or (A(13) xnor B(13)) or (A(14) xnor B(14)) or (A(15) xnor B(15)) ;
	zf4<=  A(0) xnor B(0);
	
	Zf1 <= zf4 and (not zf3);
	zf2 <= not (Y(0) or Y(1) or Y(2) or Y(3) or Y(4) or Y(5) or Y(6) or Y(7) or Y(8) or Y(9) or Y(10) or Y(11) or Y(12) or Y(13) or Y(14) or Y(15));	
	 
	C_flag <= (not s1) and (not s2) and (Cout and (not zf1));
	Z_flag <= ((not s1) and (not s2) and zf1 )or (( s1 xor s2) and zf2);
	
	Y1 <= Y;
end Equations;

------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
package cytu is
component counter2 is
    Port ( clk: in std_logic:='0'; -- clock input
           reset: in std_logic:='0'; -- reset input 
           counter: out std_logic_vector(2 downto 0):=(others=>'0') -- output 4-bit counter
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
------------------------------decoder---------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

package dfgh is
component decoder is
    port(CF,ZF: in std_logic:= '0';
         IR1: in std_logic_vector(3 downto 0):= (others=>'Z');
         IR2: in std_logic_vector(1 downto 0):= (others=>'Z');
         PreS: in std_logic_vector(4 downto 0):= "00001";
         NextS: out std_logic_vector(4 downto 0) := "00010";
         enablepins: out std_logic_vector(26 downto 0):= (others=>'Z');
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
    port(CF,ZF: in std_logic:= '0';
         IR1: in std_logic_vector(3 downto 0):= (others=>'Z');
         IR2: in std_logic_vector(1 downto 0):= (others=>'Z');
         PreS: in std_logic_vector(4 downto 0):= "00001";
         NextS: out std_logic_vector(4 downto 0):= "00010";
         enablepins: out std_logic_vector(26 downto 0) := "111000000000000000011001000";
			reset:out std_logic;
			FSM_counter:in std_logic_vector(2 downto 0):= (others=>'0'));
end entity decoder;

architecture behavioral of decoder is

    begin


	 ir:
	 process(Pres)			
begin
            if(PreS = "00001") then --S1
                enablepins <="111000000000000000011001000";
					 NextS <= "00010";--s2
					 
				elsif(PreS = "00100") then -- S4
                enablepins <="000000000000100000000110000";
						  NextS <= "00101";--s5
            

            elsif(PreS ="00110") then --S6
                enablepins <= "000000000000010000000110000";
                    NextS <= "00111"; --S7


            elsif(Pres ="01000") then --S8
                enablepins <= "000000010000000100000110000";
					 NextS <= "01101"; --S13
					 
				elsif(PreS = "01011") then --S11
						enablepins <= "001000000110000010111000000";
						if(IR1="0110") then
							NextS <= "01100"; --S12
							Reset<='1';
						end if;
						
            elsif(PreS = "01010") then --S10
						enablepins <= "000010000000000010111000000";
						if(IR1="0101") then
							NextS <= "11001"; --S25
							Reset<='1';
						end if;
						
				elsif(PreS = "01011") then --S7
						enablepins <= "000000000001010000000110000";
						NextS <= "00001"; --S1
						
				elsif(PreS = "11001") then --S25
                enablepins <="000110000000000010111000000";
					 if(IR1="0101") then
						if(FSM_counter/="111") then
							NextS <= "11001";--s1
							Reset<='0';
						else	
							NextS<="00001";
						end if;
					 end if;
							
				elsif(PreS = "01100") then -- s12
                enablepins <="001000000111000010111000000";
					 if(IR1="0110") then
						if(FSM_counter/="111") then
							NextS <= "01100";--s24
							Reset<='0';
						else
							NextS<="11000";
						end if;
					end if;

            elsif(PreS ="11000") then --S24
                enablepins <= "000000001110000101110000000";
                    NextS <= "00001"; --S1


            elsif(Pres ="10000") then --S16
                enablepins <= "000000000000000000000110010";
					 NextS <= "10001"; --S17
					 
				elsif(PreS = "10001") then --S17
					 enablepins  <="000000000000000000001001000";
						NextS <= "01111"; --S15
						
            elsif(PreS = "01110") then --S14
						enablepins <= "000000000000000000010001000";
						NextS <= "01111"; --S15
						
				 elsif(PreS = "10100") then --S20
						enablepins <= "001000000000001010000110001";
						NextS <= "10010"; --S18
				
				 elsif(PreS = "10101") then --S21
                enablepins <="000000000001110000000110000";
					 NextS <= "00001";--s1
					 
				elsif(PreS = "10111") then -- S23
                enablepins <="000000000011110010000110000";
						  NextS <= "00001";--s1
            

            elsif(PreS ="10011") then --S19
                enablepins <= "000000000101110010000110000";
                    NextS <= "00001"; --S1


            elsif(Pres ="10110") then --S22
                enablepins <= "000100000000000011000110000";
					 NextS <= "00001"; --S1
					 
				elsif(PreS = "01111") then --S15
						enablepins <= "000000000000000000010001100";
						NextS <= "00001"; --S1
						
          
			 elsif(PreS = "00010") then --S2
                enablepins <="000001000000000000000111100";
                if((IR1 = "0101") or (IR1 = "0100") ) then
                    NextS <= "01000";--s8
                elsif(IR1 = "0011")  then
                    NextS <= "00110";--s6
                elsif((IR1 = "1001") or (IR1 = "1000")) then
                    NextS <= "00100";--s4
                elsif((IR1 = "0000") or (IR1 = "0001") or (IR1 = "1100")or (IR1 = "0111")or(IR1 = "0110")or(IR1 = "0010")) then
                    NextS <= "00011";--s3
					 else
						  NextS <="00001";
                end if;
					 
			 elsif(PreS = "00011") then -- S3
                enablepins <="000000101000000100000110000";

                if(IR1 ="0110") then -- LA
                    NextS <= "01011";--s11 
					 elsif(IR1 ="0111") then -- SA
                    NextS <= "01010";--s10 
					 elsif((IR1 = "0000") or (IR1 = "0010") or (IR1 = "1100")) then--BEQ,ADD,NAND
                    NextS <= "01001";--s9  
					 elsif(IR1 ="0001") then -- ADI
                    NextS <= "01101"; --s13  
					 else
						  NextS <= "00001";
					
                end if;
          
                    
			
            elsif(PreS = "01001") then --S9
						enablepins <= "000000010000110111100000000";
					 if(IR1 ="1100") then--beq
                    NextS <= "10000"; --S16
                
					 elsif((IR1 = "0010") or (IR1 = "0000")) then--add,nand
                    NextS <= "10010"; --S18
                end if;
						
            elsif(PreS = "01101") then --S13
						enablepins <= "000000000000000011101000000";
					 if(IR1 ="0101") then
                    NextS <= "10110"; --S22
                
					 elsif(IR1 ="0100") then
                    NextS <= "10100"; --S20
                
					 elsif(IR1 ="0001") then--adi
                    NextS <= "10010"; --S18
               end if;
						
            elsif(PreS = "01011") then --S5
						enablepins <= "000000010001100000000110000";
					if(IR1 ="1000") then--jal
                    NextS <= "01110"; --S14
                
					 elsif(IR1 ="1001") then--jlr
                    NextS <= "01111"; --S15
                end if;
					 
            elsif(PreS = "10010") then --S18
						
					 if(IR1 ="0001") then--adi
						enablepins <= "000000000100110010000110011";
                    NextS <= "10011"; --S19
                
					 elsif(IR1 ="0100") then--load
						enablepins <= "000000000000110010000110000";
                    NextS <= "10101"; --S21
                
					 elsif((IR1 ="0000")or(IR1 = "0010")) then
						enablepins <= "000000000010110010000110010";
                    NextS <= "10111"; --S23
                end if;
												   
           end if;
            
            end process;

end behavioral;



------------------------------------------multi cycle----------------------------------

library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;	 
use ieee.std_logic_unsigned.all;

library work;
use work.ALU1.all;
use work.mux.all;
use work.reg1.all;
use work.inst_reg1.all;
use work.flipflop1.all;
use work.reg_file1.all;
use work.dfgh.all;
use work.zxcv.all;
use work.cytu.all;


entity multi_cycle is
	port(clk,reset:in std_logic:='0');
end entity multi_cycle;
	
architecture Equations of multi_cycle is

signal pc_in,pc_out,alu_out,read_ad,t2_out,t2_in,t1_in,mem_data,t3_out,d1_out,d2_out,d3_in,RA_in,RB_in:std_logic_vector(15 downto 0):= (others=>'Z');
signal A2_in,A1_in,A3_in:std_logic_vector(2 downto 0):= (others=>'Z');
signal zf_in,cf_in,zf,cf,resetpin:std_logic:= '0';
signal op_out:std_logic_vector(3 downto 0):= (others=>'Z');
signal cz_out:std_logic_vector(1 downto 0):= (others=>'Z');
signal ns:std_logic_vector(4 downto 0):= "00010";
signal ps:std_logic_vector(4 downto 0):= "00001";
signal counter_in:std_logic_vector(2 downto 0):= (others=>'0');
signal imm6_out,imm9_s_out,imm9_l_out,ir_in :std_logic_vector(15 downto 0):= (others=>'Z');
signal RA_out,RB_out,RC_out:std_logic_vector(2 downto 0):= (others=>'Z');
signal con: std_logic_vector(26 downto 0) :="111000000000000000011001000";


begin




count1:counter2
	port map(clk=>clk ,reset=>resetpin ,counter=>counter_in );
d1:decoder
   port map( CF=>cf ,ZF=> zf,enablepins => con,IR1=>op_out ,IR2 =>cz_out, NextS=>ns  ,PreS=>ps,reset =>resetpin,FSM_counter => counter_in ) ;

reg5:reg_5bit
	port map(D=>ns , Clk=> clk,Q=>ps,reset=>'0' );	
pc:reg
	   port map(Q =>pc_out ,Clk=> con(26), D=>pc_in,reset=>reset);	
m1:sixteen_bit_2
		port map(B=>pc_out ,A=>t2_out ,s=>con(25) ,Y=>read_ad );
memory:Mem_synced
		port map( re_ad=>read_ad ,wr_ad=>t2_out ,Mem_datain=>mem_data ,Mem_wr=>con(23) ,Mem_re=>con(24) ,Mem_dataout=>ir_in );
m2:sixteen_bit_2
		port map(A=>t3_out ,B=>d1_out ,s=>con(22) ,Y=>mem_data );
ir:inst_reg
		port map(RA =>RA_out,RB => RB_out ,RC => RC_out,Clk=>con(21),A=>ir_in,op=>op_out,imm6 => imm6_out, imm9_s => imm9_s_out ,imm9_l=>imm9_l_out, cz=>cz_out );
m3:three_bit_2
		port map(A=>RA_out ,B=>RB_out ,s=>con(18) ,Y=>A2_in );
m4:three_bit_4
		port map(A=>counter_in ,B=>RA_out ,C=>RB_out ,D=>"000" ,s1=>con(19) ,s2=>con(20) ,Y=>A1_in );
m5:three_bit_4
		port map(A=>RA_out ,B =>RC_out, C =>RB_out, D=>counter_in , s1=>con(16) ,s2=>con(17) ,Y=> A3_in  );
r:reg_file
		port map(wr_ad=>A3_in ,RA_ad=>A1_in ,RB_ad=>A2_in ,RAv=>d1_out ,RBv=>d2_out ,Mem_wr=>con(15) ,data_in=> d3_in);
m6:sixteen_bit_4
		port map(A=>ir_in ,B =>imm9_l_out , C =>pc_out, D=>t2_out , s1=>con(13) ,s2=>con(14) ,Y=>d3_in   );
m7:sixteen_bit_4
		port map( A=>alu_out ,B =>d1_out, C =>ir_in, D=>"0000000000000000" , s1=>con(11) ,s2=>con(12) ,Y=>t2_in  );
t3:reg
		port map(Q =>t3_out ,Clk=> con(9), D=>d2_out ,reset=>reset);
t2:reg
		port map(Q =>t2_out ,Clk=> con(10), D=>t2_in,reset=>reset );
m8:sixteen_bit_4
		port map( A=>t3_out ,B =>imm6_out, C =>imm9_s_out, D=>"0000000000000001" , s1=> con(6),s2=>con(7) ,Y=>RB_in );
m9:sixteen_bit_2
		port map(A=>pc_out ,B=>t2_out ,s=>con(8) ,Y=>RA_in );
al:alu
		port map( A=>RA_in ,B=>RB_in , s1 =>con(4) ,s2=>con(5)  ,Y1=>alu_out, C_flag=>cf_in, Z_flag=>zf_in);
zfr:flipflop
		port map(D =>zf_in ,Clk=> con(1), Q=>zf ,reset=>reset);
cfr:flipflop
		port map(D =>cf_in ,Clk=> con(0), Q=>cf,reset=>reset );
m10:sixteen_bit_2
		port map( A=>d1_out ,B=>alu_out ,s=>con(3) ,Y=>t1_in);
t1:reg
		port map(Q =>pc_in ,Clk=> con(2), D=>t1_in,reset=>reset );
		
end Equations;


