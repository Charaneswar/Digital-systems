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
	port(clk,reset,reset2:in std_logic);
end entity multi_cycle;
	
architecture Equations of multi_cycle is

signal pc_in,pc_out,alu_out,read_ad,t2_out,t2_in,t1_in,mem_data,ir_in ,t3_out,d1_out,d2_out,d3_in,imm6_out,imm9_s_out,imm9_l_out,RA_in,RB_in:std_logic_vector(15 downto 0):= (others=>'0');
signal RA_out,RB_out,RC_out,A2_in,A1_in,A3_in:std_logic_vector(2 downto 0):= (others=>'0');
signal zf_in,cf_in,zf,cf,resetpin:std_logic:= '0';
signal op_out:std_logic_vector(3 downto 0):= (others=>'0');
signal cz_out:std_logic_vector(1 downto 0):= (others=>'0');
signal con:std_logic_vector(26 downto 0):= "100110001101111011100110011";
signal ns:std_logic_vector(4 downto 0):= (others=>'Z');
signal ps:std_logic_vector(4 downto 0):= (others=>'0');
signal counter_in:std_logic_vector(2 downto 0):= (others=>'0');




begin




count1:counter2
	port map(clk=>clk ,reset=>resetpin ,counter=>counter_in );
d1:decoder
   port map( CF=>cf ,ZF=> zf,enablepins => con,IR1=>op_out ,IR2 =>cz_out, NextS=>ns, reset_in=>reset2  ,PreS=>ps,reset =>resetpin,FSM_counter => counter_in ) ;

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


