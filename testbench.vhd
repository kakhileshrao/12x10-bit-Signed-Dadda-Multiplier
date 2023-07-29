
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is
end entity;

architecture behavior of testbench is
component dadda_multi is
	 port(
    a: in std_logic_vector(9 downto 0);
    b: in std_logic_vector(11 downto 0);
    p: out std_logic_vector(21 downto 0)
  ); 
  end component dadda_multi;

	signal a :std_logic_vector( 9 downto 0):= (others => '0');   ----signals that go into the dut
	signal b :std_logic_vector( 11 downto 0):= (others => '0'); 
	signal p: std_logic_vector(21 downto 0):= (others => '0');
	signal expected_outp : std_logic_vector(21 downto 0):= (others => '0');
	begin
		dut: dadda_multi port map (a,b,p);
		process
			begin
					for i in -500 to 500 loop
						for j in -2000 to 2000 loop
							a <= std_logic_vector(to_signed(i, 10));
							b <= std_logic_vector(to_signed(j, 12));
							expected_outp <= std_logic_vector(to_signed((i * j),22));
							wait for 5 ns;
							assert (to_integer(signed(p)) = i * j) report "Fail!" severity error;
						end loop;
					end loop;
			assert false report "Success!" severity note;
			wait;
		end process;
end architecture behavior;





-- ---------------------------------------------
-- ---------------------------test bench---------------------------------
-- ---------------------------          ---------------------------------



-- library ieee;
-- use ieee.std_logic_1164.all;    ---standard ieee package
-- use ieee.numeric_std.all;       ---for arithmetic operations like addition
-- use std.textio.all;             ---provides more facilities inn addition to the std_logic_textio package in ieee library
-- use ieee.std_logic_textio.all; ---package that provides text io facility

-- entity tb is end entity;

-- architecture arch2 of tb is
-- --*********************************
-- constant len: integer:= 10;
-- --*********************************
-- signal a :std_logic_vector( 9 downto 0);   ----signals that go into the dut
-- signal b :std_logic_vector( 11 downto 0); 
-- signal carry_in : std_logic;
-- signal sum : std_logic_vector(21 downto 0);
-- signal carry_out : std_logic;

-- signal expected_sum : std_logic_vector((2*len-1) downto 0);  ---expected sum and carry outputs to be extracted from the input file
-- --signal expected_cout : std_logic;

-- component dadda_multi is
-- 	 port(
--     a: in std_logic_vector(9 downto 0);
--     b: in std_logic_vector(11 downto 0);
--     p: out std_logic_vector(21 downto 0)
--   ); component dadda_multi;

-- begin
-- dut: dadda_multi port map(a,b,sum);  ---DUT

-- process
-- variable v_a: std_logic_vector( 9 downto 0);
-- variable v_b: std_logic_vector( 11 downto 0);
-- --variable v_carry_in: std_logic;
-- variable v_expected_sum: std_logic_vector( 21 downto 0);
-- --variable v_expected_cout: std_logic;
-- file f_inp: text;  ----file where input as well as the corresponding correct output is stored
-- file f_outp: text; ---file where computed outputs will be stored
-- variable line_in, line_out: line; ---line is like a pointer to string

-- begin
-- file_open(f_inp,"inp.txt", read_mode);
-- file_open(f_outp, "outp.txt", write_mode);

-- while( not endfile(f_inp)) loop
-- readline(f_inp, line_in); ---read a line from file object

-- ---now we have read the entire line. Now this single line contains input cin, a and b as well as corresponding sum and carry output.

-- ---The inputs and outputs is stored in the line in the following format: 
-- ---(1 bit carry_out)(32 bit 'a' input)(32 bit 'b' input)(32 bit sum output)(1 bit carry_in input)

-- --read(line_in,v_expected_cout); ---segregate various terms from the line read
-- read(line_in,v_expected_sum);
-- read(line_in,v_a);
-- read(line_in,v_b);
-- --read(line_in,v_carry_in);



-- --now the signals going into the dut can be assigned these values

-- a<= v_a;
-- b<= v_b;
-- --carry_in<= v_carry_in;

-- expected_sum<= v_expected_sum;
-- --expected_cout<= v_expected_cout;

-- wait for 10 us;

-- line_out:= null;

-- ---now we enter the inputs and the computed outputs in the output file by first putting it in a line and then writing it in the file
-- write(line_out, carry_out);  ------writing the various data elements into the line
-- write(line_out, sum);
-- write(line_out, a);  
-- write(line_out, b);
-- write(line_out, carry_in);


-- writeline(f_outp, line_out); ---writing the line into the output file

-- assert ( sum = expected_sum) report "mismatch" severity failure; ---asser statement to report mismatch in expected 
-- end loop;                                                                                      ---and calculated values
--  report "success" severity note;
--  file_close(f_inp);             ---close the file
--  file_close(f_outp);
--  wait;
--  end process;
--  end architecture arch2;
 
 
 



