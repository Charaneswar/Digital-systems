library ieee;
use ieee.std_logic_1164.all;
package Gates is	

	component FULL_ADDER is
		port ( A,B,Cin : in STD_LOGIC; S,Cout : out STD_LOGIC);
	end component FULL_ADDER;
	
	component mux is
		port(A,B,S : in STD_LOGIC; Y : out STD_LOGIC);
	end component mux;
	
	end package Gates;
	
-------------------------full adder------------------
  
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

---------------------------2 to 1-mux------------------------

library ieee;
use ieee.std_logic_1164.all;
entity mux is
	port(A,B,S : in STD_LOGIC; Y : out STD_LOGIC);
end entity mux;
architecture Equations of mux is
begin
	Y <= (A and (not S)) or (B and S);
end Equations;


 ---------------------------------------adder package-------------------------------



library ieee;
use ieee.std_logic_1164.all;

package adder is
	component five_bit_adder is
		port(	A,B :in std_logic_vector(4 downto 0) ; S:  out std_logic_vector(4 downto 0);C :out std_logic );
	end component five_bit_adder;
	
	component three_bit_adder is
		port(	A,B :in std_logic_vector(2 downto 0) ; Ci: in std_logic; S:  out std_logic_vector(2 downto 0);C :out std_logic );
	end component three_bit_adder;
end package adder;


---------------------------------three bit adder--------------------

library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;
entity three_bit_adder is
		port(	A,B :in std_logic_vector(2 downto 0) ; Ci: in std_logic; S:  out std_logic_vector(2 downto 0);C : out std_logic );
end entity three_bit_adder;
architecture Equations of three_bit_adder is 
	signal c1 : std_logic_vector(2 downto 0);

	begin
		f1:FULL_ADDER
			port map (A => A(0),B => B(0), Cin => Ci, S=> S(0) ,Cout => c1(0));
		f2:FULL_ADDER
			port map (A => A(1),B => B(1), Cin => c1(0), S=> S(1) ,Cout => c1(1));
		f3:FULL_ADDER
			port map (A => A(2),B => B(2), Cin => c1(1), S=> S(2) ,Cout => C);
	
end Equations;

---------------------------------------five bit adder------------------------
library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;
entity five_bit_adder is
		port(	A,B :in std_logic_vector(4 downto 0); S:  out std_logic_vector(4 downto 0);C : out std_logic );
end entity five_bit_adder;
architecture Equations of five_bit_adder is 
	signal c1 : std_logic_vector(4 downto 0);

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
			port map (A => A(4),B => B(4), Cin => c1(3), S=> S(4) ,Cout => C);
			
end Equations;			

------------------------------main code combining all blocks----------------		
	 

library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;
use work.adder.all;

entity floatmulti is
	port(x,y : in std_logic_vector(7 downto 0); z: out std_logic_vector(15 downto 0) );
end floatmulti;

architecture Equations of floatmulti is
	signal ca,mul: std_logic_vector(19 downto 0);
	signal pr: std_logic_vector(14 downto 0);
	signal ca1: std_logic_vector(3 downto 0);
	signal pr1: std_logic_vector(4 downto 0);
	signal pr2: std_logic_vector(8 downto 0);
	signal inf,uf: std_logic; 
	begin
	
			mul(4) <= '0';
			mul(3) <= y(0);
			mul(2) <= y(0) and x(3) ; 
			mul(1) <= y(0) and x(2) ;
			mul(0) <= y(0) and x(1) ;
			
			mul(9) <= y(1) ;
			mul(8) <= y(1) and x(3);
			mul(7) <= y(1) and x(2);
			mul(6) <= y(1) and x(1);
			mul(5) <= y(1) and x(0);
			
			mul(14) <= y(2) ;
			mul(13) <= y(2) and x(3);
			mul(12) <= y(2) and x(2);
			mul(11) <= y(2) and x(1);
			mul(10) <= y(2) and x(0);
			
			mul(19) <= y(3) ;
			mul(18) <= y(3) and x(3);
			mul(17) <= y(3) and x(2);
			mul(16) <= y(3) and x(1);
			mul(15) <= y(3) and x(0);
			
			
	   z(15) <= x(7) xor y(7) ;
		fb1:five_bit_adder
			port map(
			A => mul(4 downto 0),
			B => mul(9 downto 5),

			S(0) => pr(1),
			S( 4 downto 1) => ca(3 downto 0),
			C => ca(4));
			
	  fb2:five_bit_adder
			port map(
			A => ca( 4 downto 0),
			B => mul(14 downto 10),
			

			
			S(0) => pr(2),
			S( 4 downto 1) => ca(8 downto 5),
			C => ca(9));
			
	 	fb3:five_bit_adder
			port map(
			A => ca( 9 downto 5),
			B => mul(19 downto 15),

			S(0) => pr(3),
			S( 4 downto 1) => ca(13 downto 10),
			C => ca(14));	
			
	 	fb4:five_bit_adder
			port map(
			A => ca( 14 downto 10), 
			B(4) => '1' ,
			B(3 downto 0) => x( 3 downto 0),
			S( 4 downto 0) => pr(8 downto 4),
			C => pr(9));
		fb7:five_bit_adder
			port map(
			A => ca( 14 downto 10), 
			B(4) => '1' ,
			B(3 downto 0) => x( 3 downto 0),
			S( 4 downto 0) => pr1(4 downto 0));

		pr(0) <= x(0) and y(0);
		pr2(8 downto 5) <= pr1(3 downto 0);
		pr2(4 downto 1) <= pr(3 downto 0);
		pr2(0) <= '0';
		m1:mux
			port map(A =>pr2(0) , B=> pr(0) , S=> pr(9) ,Y => z(1));
		m2:mux
			port map(A =>pr2(1) , B=> pr(1) , S=> pr(9) ,Y => z(2));
		m3:mux
			port map(A =>pr2(2) , B=> pr(2) , S=> pr(9) ,Y => z(3));
		m4:mux
			port map(A =>pr2(3) , B=> pr(3) , S=> pr(9) ,Y => z(4));
		m5:mux
			port map(A =>pr2(4) , B=> pr(4) , S=> pr(9) ,Y => z(5));
		m6:mux
			port map(A =>pr2(5) , B=> pr(5) , S=> pr(9) ,Y => z(6));
		m7:mux
			port map(A =>pr2(6) , B=> pr(6) , S=> pr(9) ,Y => z(7));
		m8:mux
			port map(A =>pr2(7) , B=> pr(7) , S=> pr(9) ,Y => z(8));
		m9:mux
			port map(A =>pr2(8) , B=> pr(8) , S=> pr(9) ,Y => z(9));
		
	tb:three_bit_adder
			port map ( A => x(6 downto 4) ,B => y(6 downto 4) ,S => ca1( 2 downto 0) ,Ci => pr(9), C=>ca1(3));
	fb5:five_bit_adder
			port map ( A(4)=>'0',A(3 downto 0) => ca1( 3 downto 0), B => "01001" , S => pr(14 downto 10));
	
	uf <= (x(6) or x(5) or x(4)) and (y(6) or y(5) or y(4));
	
	z(0) <= '0';
	z(14 downto 10) <= pr (14 downto 10);
	
end Equations;			
