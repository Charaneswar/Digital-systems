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
use work.zxcv.all;

entity multi_cycle is
	port(zf,cf :out std_logic; op_out:out std_logic_vector(3 downto 0); cz_out:out std_logic_vector(1 downto 0);
	      con:in std_logic_vector(26 downto 0);counter:in std_logic_vector(2 downto 0));
end entity multi_cycle;
	
architecture Equations of multi_cycle is

signal pc_in,pc_out,alu_out,read_ad,t2_out,t2_in,t1_in,mem_data,ir_in,t3_out,d1_out,d2_out,d3_in,imm6_out,imm9_s_out,imm9_l_out,RA_in,RB_in:std_logic_vector(15 downto 0);
signal RA_out,RB_out,RC_out,A2_in,A1_in,A3_in:std_logic_vector(2 downto 0);
signal zf_in,cf_in:std_logic;

begin

pc:reg
	   port map(Q =>pc_out ,Clk=> con(0), D=>pc_in);	
m1:sixteen_bit_2
		port map(A=>pc_out ,B=>t2_out ,s=>con(1) ,Y=>read_ad );
memory:Mem_synced
		port map( re_ad=>read_ad ,wr_ad=>t2_out ,Mem_datain=>mem_data ,Mem_wr=>con(3) ,Mem_re=>con(2) ,Mem_dataout=>ir_in );
m2:sixteen_bit_2
		port map(A=>t3_out ,B=>d1_out ,s=>con(4) ,Y=>mem_data );
ir:inst_reg
		port map(RA =>RA_out,RB => RB_out ,RC => RC_out,Clk=>con(5),A=>ir_in,op=>op_out,imm6 => imm6_out, imm9_s => imm9_s_out ,imm9_l=>imm9_l_out, cz=>cz_out );
m3:three_bit_2
		port map(A=>RA_out ,B=>RB_out ,s=>con(8) ,Y=>A2_in );
m4:three_bit_4
		port map(A=>counter ,B=>RA_out ,C=>RB_out ,D=>"000" ,s1=>con(7) ,s2=>con(6) ,Y=>A1_in );
m5:three_bit_4
		port map(A=>RA_out ,B =>RC_out, C =>RB_out, D=>counter , s1=>con(10) ,s2=>con(9) ,Y=> A3_in  );
r:reg_file
		port map(wr_ad=>A3_in ,RA_ad=>A1_in ,RB_ad=>A2_in ,RAv=>d1_out ,RBv=>d2_out ,Mem_wr=>con(11) ,data_in=> d3_in);
m6:sixteen_bit_4
		port map(A=>ir_in ,B =>imm9_l_out , C =>pc_out, D=>t2_out , s1=>con(13) ,s2=>con(12) ,Y=>d3_in   );
m7:sixteen_bit_4
		port map( A=>alu_out ,B =>d1_out, C =>ir_in, D=>"0000000000000000" , s1=>con(15) ,s2=>con(14) ,Y=>t2_in  );
t3:reg
		port map(Q =>t3_out ,Clk=> con(17), D=>d2_out );
t2:reg
		port map(Q =>t2_out ,Clk=> con(16), D=>t2_in );
m8:sixteen_bit_4
		port map( A=>t3_out ,B =>imm6_out, C =>imm9_s_out, D=>"0000000000000100" , s1=> con(20),s2=>con(19) ,Y=>RB_in );
m9:sixteen_bit_2
		port map(A=>pc_out ,B=>t2_out ,s=>con(18) ,Y=>RA_in );
al:alu
		port map( A=>RA_in ,B=>RB_in , s1 =>con(22) ,s2=>con(21)  ,Y1=>alu_out, C_flag=>cf_in, Z_flag=>zf_in);
zfr:flipflop
		port map(D =>zf_in ,Clk=> con(25), Q=>zf );
cfr:flipflop
		port map(D =>cf_in ,Clk=> con(26), Q=>cf );
m10:sixteen_bit_2
		port map( A=>d1_out ,B=>alu_out ,s=>con(23) ,Y=>t1_in);
t1:reg
		port map(Q =>pc_in ,Clk=> con(24), D=>t1_in );
		
end Equations;


