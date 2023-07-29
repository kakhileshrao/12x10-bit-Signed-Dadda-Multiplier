--XOR gate block

library ieee;
use ieee.std_logic_1164.all;

entity xor_block is
port( in1, in2 :in std_logic;
		out1 : out std_logic);
		
		end xor_block;
		
architecture arch1 of xor_block is
begin
out1<= in1 xor in2;
end arch1;