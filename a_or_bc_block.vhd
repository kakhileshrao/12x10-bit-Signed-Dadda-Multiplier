--Block to perform A+BC operation

library ieee;
use ieee.std_logic_1164.all;

entity a_or_bc_block is
port( in1, in2, in3 :in std_logic;
		out1 : out std_logic);
		
		end a_or_bc_block;
		
architecture arch1 of a_or_bc_block is
begin
out1<= in1 or (in2 and in3);
end arch1;