library std;
use std.textio.all;
library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;

entity Testbench is
end entity;
architecture Behave of Testbench is
  constant number_of_inputs  : integer := 16;			---- edit this to match the number of input bits in the DUT
  constant number_of_outputs : integer := 16;			---- edit this to match the number of output bits in the DUT

  component DUT is
   port(input_vector: in std_logic_vector(15 downto 0);     --edit this to match the DUT file entity definition
       	output_vector: out std_logic_vector(15 downto 0));
  end component;

  signal input_vector  : std_logic_vector(number_of_inputs-1 downto 0) := (others => '0');
  signal output_vector : std_logic_vector(number_of_outputs-1 downto 0) := (others => '0');

  function to_string(x: string) return string is
     variable ret_val: string(1 to x'length);
      alias lx : string (1 to x'length) is x;
  begin  
      ret_val := lx;
      return(ret_val);
  end to_string;

begin
  process 
    variable err_flag : boolean := false;
    File INFILE: text open read_mode is "C:\Users\chara\Downloads\tacefile2_adv_NaN.txt";    -- path to the tracefile location
    FILE OUTFILE: text  open write_mode is "C:\Users\chara\Downloads\output2-2.txt c";   -- path to save the result for the tracefile given.

    variable input_var: bit_vector (number_of_inputs-1 downto 0);
    variable output_var: bit_vector (number_of_outputs-1 downto 0);
    variable mask_var: bit_vector (number_of_outputs-1 downto 0);
    variable input_var_s: std_logic_vector (number_of_inputs-1 downto 0);
    variable output_var_s: std_logic_vector (number_of_outputs-1 downto 0);
    variable mask_var_s: std_logic_vector (number_of_outputs-1 downto 0);

    variable output_comp_var: std_logic_vector (number_of_outputs-1 downto 0);
    constant ZZZZ : std_logic_vector(number_of_outputs-1 downto 0) := (others => '0');

    variable INPUT_LINE: Line;
    variable OUTPUT_LINE: Line;
    variable LINE_COUNT: integer := 0;
		
	
	 
    
  begin
    while not endfile(INFILE) loop 
          LINE_COUNT := LINE_COUNT + 1;

	  readLine (INFILE, INPUT_LINE);
          read (INPUT_LINE, input_var);
          read (INPUT_LINE, output_var);
          read (INPUT_LINE, mask_var);
	
          input_var_s := to_StdLogicvector(input_var);
	  output_var_s := to_StdLogicvector(output_var);
	  mask_var_s := to_StdLogicvector(mask_var);

	  input_vector <= input_var_s;
	  wait for 50 ns;
		
      output_comp_var := mask_var_s and(output_vector xor output_var_s);

	  if (output_comp_var  /= ZZZZ) then
             write(OUTPUT_LINE,to_string("ERROR: line "));
             write(OUTPUT_LINE, LINE_COUNT);
             writeline(OUTFILE, OUTPUT_LINE);
             err_flag := true;
          end if;

          write(OUTPUT_LINE, input_var);
          write(OUTPUT_LINE, to_string(" "));
          write(OUTPUT_LINE, output_var);
          writeline(OUTFILE, OUTPUT_LINE);

    end loop;

    assert (err_flag) report "SUCCESS, all tests passed." severity note;
    assert (not err_flag) report "FAILURE, some tests failed." severity error;

    wait;
  end process;
  dut_instance: DUT 
     	port map(
		input_vector => input_vector,
		output_vector => output_vector);

end Behave;
