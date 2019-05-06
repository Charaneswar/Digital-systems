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
		port(A,B :in std_logic_vector(15 downto 0):= (others=>'0');
				S1,s2 :in std_logic;
				Y1:out std_logic_vector(15 downto 0):= (others=>'0');
				C_flag,Z_flag:out std_logic:= '0');
	end component ALU;
end package ALU1;


library ieee;
use ieee.std_logic_1164.all;
library work;
use work.alu_components.all;
use work.mux.all;
entity ALU is
	port(A,B :in std_logic_vector(15 downto 0):= (others=>'0');
			S1,s2 :in std_logic;
			Y1:out std_logic_vector(15 downto 0):= (others=>'0');
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





