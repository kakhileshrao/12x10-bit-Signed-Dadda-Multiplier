--AND gate block

library ieee;
use ieee.std_logic_1164.all;

entity and_block is
port( in1, in2 :in std_logic;
		out1 : out std_logic);
		
		end and_block;
		
architecture arch1 of and_block is
begin
out1<= in1 and in2;
end arch1;