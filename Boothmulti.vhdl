

------------------------------------Gates package----------------------------------
library ieee;
use ieee.std_logic_1164.all;
package Gates is	

  component HALF_ADDER is
   port (A, B: in std_logic; S, C: out std_logic);
  end component HALF_ADDER;

	component FULL_ADDER is
		port ( A,B,Cin : in STD_LOGIC; S,Cout : out STD_LOGIC);
	end component FULL_ADDER;
	
	component mux is
		port(A,B,S : in STD_LOGIC; Y : out STD_LOGIC);
	end component mux;
	
	end package Gates;
	
----------------Half adder---------------------------
	  
library ieee;
use ieee.std_logic_1164.all;
entity HALF_ADDER is
   port (A, B: in std_logic; S, C: out std_logic);
end entity HALF_ADDER;

architecture Equations of HALF_ADDER is
begin
   S <= (A xor B);
   C <= (A and B);
end Equations;

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

----------------------------mux------------------------

library ieee;
use ieee.std_logic_1164.all;
entity mux is
	port(A,B,S : in STD_LOGIC; Y : out STD_LOGIC);
end entity mux;
architecture Equations of mux is
begin
	Y <= (A and (not S)) or (B and S);
end Equations;

------------------------booth multiplier package-----------------------------------
	

library ieee;
use ieee.std_logic_1164.all;

package booth_multiplier is
	component booth_encoder is
		port(q2,q1,q0: in std_logic; sing,doub,neg: out std_logic);
	end component booth_encoder;
	
	component booth_decoder is
		port(sing,y1,y0,doub,neg: in std_logic; p: out std_logic);
	end component booth_decoder;
	
	component nine_bit_adder is
		port(	A,B :in std_logic_vector(8 downto 0) ; S:  out std_logic_vector(8 downto 0);C :out std_logic );
	end component nine_bit_adder;
end package booth_multiplier;

--------------------------booth encoder-----------------------

library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;
entity booth_encoder is
	port(q2,q1,q0 :in std_logic; sing,doub,neg: out std_logic);
end entity booth_encoder;

architecture Equations of booth_encoder is
	begin
	sing <= q1 xor q0;
	
	m:mux
		port map( A => (q1 and q0), B => ((not q1) and (not q0)), S=>q2 ,Y => doub);
	neg <= q2;
end Equations;

------------------------------------booth decoder-------------------------

library ieee;
use ieee.std_logic_1164.all;
entity booth_decoder is
	port(sing,y1,y0,doub,neg: in std_logic; p: out std_logic);
end entity booth_decoder;

architecture Equations of booth_decoder is
	begin
	p <= ((y1 nand sing) nand (y0 nand doub))xor neg;
end Equations;

-------------------------nine bit adder---------------------------------

library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;
entity nine_bit_adder is
		port(	A,B :in std_logic_vector(8 downto 0) ; S:  out std_logic_vector(8 downto 0);C : out std_logic );
end entity nine_bit_adder;
architecture Equations of nine_bit_adder is 
	signal c1 : std_logic_vector(8 downto 0);

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
			port map (A => A(8),B => B(8), Cin => c1(7), S=> S(8) ,Cout => C);
			
end Equations;

--------------------------------partial product package--------------------------

library ieee;
use ieee.std_logic_1164.all;

package partial_product is
	component partial is
		port( A :in std_logic_vector(7 downto 0);B:in std_logic_vector(2 downto 0);pr:out std_logic_vector(8 downto 0));
	end component partial;
end package partial_product;

library ieee;
use ieee.std_logic_1164.all;
library work;
use work.booth_multiplier.all;
use work.Gates.all;
entity partial is
	port( A :in std_logic_vector(7 downto 0);B:in std_logic_vector(2 downto 0); pr:out std_logic_vector(8 downto 0));
end entity partial;
architecture Equations of partial is
signal pr1,ca : std_logic_vector(8 downto 0);
begin
	d0:booth_decoder
		port map(sing => B(0)  , y1=> A(0) ,doub=>B(1) , y0=>'0' ,neg=> B(2) , p=>pr1(0) );
	ha0:HALF_ADDER
		port map(A => pr1(0)  , B=> B(2), C=>ca(0) , S=> pr(0));
	d1:booth_decoder
		port map(sing => B(0)  , y1=> A(1) ,doub=>B(1) , y0=>A(0) ,neg=> B(2) , p=>pr1(1) );
	ha1:HALF_ADDER
		port map(A => pr1(1)  , B=> ca(0), C=>ca(1) , S=> pr(1));
	d2:booth_decoder
		port map(sing => B(0)  , y1=> A(2) ,doub=>B(1) , y0=>A(1),neg=> B(2) , p=>pr1(2) );
	ha2:HALF_ADDER
		port map(A => pr1(2)  , B=> ca(1), C=>ca(2) , S=> pr(2));
	d3:booth_decoder
		port map(sing => B(0)  , y1=> A(3) ,doub=>B(1) , y0=>A(2),neg=> B(2) , p=>pr1(3) );
	ha3:HALF_ADDER
		port map(A => pr1(3)  , B=> ca(2), C=>ca(3) , S=> pr(3));
	d4:booth_decoder
		port map(sing => B(0)  , y1=> A(4) ,doub=>B(1) , y0=>A(3),neg=> B(2) , p=>pr1(4) );
	ha4:HALF_ADDER
		port map(A => pr1(4)  , B=> ca(3), C=>ca(4) , S=> pr(4));
	d5:booth_decoder
		port map(sing => B(0)  , y1=> A(5) ,doub=>B(1) , y0=>A(4),neg=> B(2) , p=>pr1(5) );
	ha5:HALF_ADDER
		port map(A => pr1(5)  , B=> ca(4), C=>ca(5) , S=> pr(5));
	d6:booth_decoder
		port map(sing => B(0)  , y1=> A(6) ,doub=>B(1) , y0=>A(5),neg=> B(2) , p=>pr1(6) );
	ha6:HALF_ADDER
		port map(A => pr1(6)  , B=> ca(5), C=>ca(6) , S=> pr(6));
	d7:booth_decoder
		port map(sing => B(0)  , y1=> A(7) ,doub=>B(1) , y0=>A(6),neg=> B(2) , p=>pr1(7) );
	ha7:HALF_ADDER
		port map(A => pr1(7)  , B=> ca(6), C=>ca(7) , S=> pr(7));
	d8:booth_decoder
		port map(sing => B(0)  , y1=> A(7) ,doub=>B(1) , y0=>A(7),neg=> B(2) , p=>pr1(8) );
	ha8:HALF_ADDER
		port map(A => pr1(8)  , B=> ca(7), C=>ca(8) , S=> pr(8));
end Equations;
	
		
------------------------------main code combining all blocks----------------		
	 

library ieee;
use ieee.std_logic_1164.all;
library work;
use work.booth_multiplier.all;
use work.partial_product.all;

entity Boothmulti is
	port(mr,md : in std_logic_vector(7 downto 0); pt: out std_logic_vector(15 downto 0) );
end Boothmulti;
architecture booth_multiplication of Boothmulti is
signal sing,doub,neg : std_logic_vector(3 downto 0);
signal add0,add4,add5 : std_logic_vector(6 downto 0);
signal add1,add2,add3 : std_logic_vector(8 downto 0);
begin
	e1:booth_encoder
		port map(q0 => '0' , q1 =>mr(0) ,q2 =>mr(1),sing=>sing(0), doub =>doub(0),neg => neg(0)); 
	e2:booth_encoder
		port map(q0 => mr(1) , q1 =>mr(2) ,q2 =>mr(3),sing=>sing(1), doub =>doub(1),neg => neg(1)); 
	e3:booth_encoder
		port map(q0 => mr(3) , q1 =>mr(4) ,q2 =>mr(5),sing=>sing(2), doub =>doub(2),neg => neg(2)); 
	e4:booth_encoder
		port map(q0 => mr(5) , q1 =>mr(6) ,q2 =>mr(7),sing=>sing(3), doub =>doub(3),neg => neg(3)); 
	pa1:partial	
		port map( A => md , B(0)=>sing(0) , B(1)=> doub(0),B(2)=> neg(0), pr(1 downto 0)=>pt(1 downto 0),pr ( 8 downto 2) => add0 (6 downto 0));
   pa2:partial	
		port map( A => md , B(0)=>sing(1) , B(1)=> doub(1),B(2)=> neg(1),pr  => add1 );
	pa3:partial	
		port map( A => md , B(0)=>sing(2) , B(1)=> doub(2),B(2)=> neg(2),pr  => add2 );
	pa4:partial	
		port map( A => md , B(0)=>sing(3) , B(1)=> doub(3),B(2)=> neg(3),pr  => add3 );
	n1:nine_bit_adder
		port map( A => add1 , B(8) => ( add0(6) and '1') , B(7) => ( add0(6) and '1') , B(6 downto 0) => add0 , S(1 downto 0)=>pt(3 downto 2),S ( 8 downto 2) => add4 (6 downto 0));
	n2:nine_bit_adder
		port map( A => add2 , B(8) => ( add4(6) and '1') , B(7) => ( add4(6) and '1') , B(6 downto 0) => add4 , S(1 downto 0)=>pt(5 downto 4),S ( 8 downto 2) => add5 (6 downto 0));
	n3:nine_bit_adder
		port map( A => add3 , B(8) => ( add5(6) and '1') , B(7) => ( add5(6) and '1') , B(6 downto 0) => add5 , S =>pt(14 downto 6));
pt(15) <= (mr(7) xor md(7));	
end booth_multiplication;
		















