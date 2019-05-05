library ieee;
use ieee.std_logic_1164.all;
library work;
use work.reg1.all;

package inst_reg1 is
component inst_reg is 
   port(RA,RB,RC:out std_logic_vector(2 downto 0); 
			Clk :in std_logic; 
			A:in std_logic_vector(15 downto 0);
			op:out std_logic_vector(3 downto 0);
			cz:out std_logic_vector(1 downto 0);
			imm9_l:out std_logic_vector(15 downto 0);
			imm9_s:out std_logic_vector(15 downto 0);
			imm6:out std_logic_vector(15 downto 0));
end component inst_reg;
end package inst_reg1;

---------------------------------instruction register------------------------------

library ieee;
use ieee.std_logic_1164.all;
library work;
use work.reg1.all;
entity inst_reg is 
   port(RA,RB,RC:out std_logic_vector(2 downto 0); 
			Clk :in std_logic; 
			A:in std_logic_vector(15 downto 0);
			op:out std_logic_vector(3 downto 0);
			cz:out std_logic_vector(1 downto 0);
			imm9_l:out std_logic_vector(15 downto 0);
			imm9_s:out std_logic_vector(15 downto 0);
			imm6:out std_logic_vector(15 downto 0));
end entity inst_reg;

architecture Equations of inst_reg is 
signal q1:std_logic_vector(15 downto 0);
 begin
	r1:reg
		port map(D =>A, Clk => Clk ,Q => q1);
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
	
	
	
	
	
	
	
	



























