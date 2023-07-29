--Main adder block and its Test Bench

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity brentkungadder_dadda is
port( a,b :in std_logic_vector(20 downto 0);
		--carry_in : in std_logic;
		--add_out: out std_logic_vector(22 downto 0));
		sum : out std_logic_vector(20 downto 0);
		carry_out : out std_logic);
		
		end brentkungadder_dadda;
		
architecture arch1 of brentkungadder_dadda is

component and_block is
port( in1, in2 :in std_logic;
		out1 : out std_logic);
		
		end component and_block;
		
component a_or_bc_block is
port( in1, in2, in3 :in std_logic;
		out1 : out std_logic);
		
		end component a_or_bc_block;
		
component xor_block is
port( in1, in2 :in std_logic;
		out1 : out std_logic);
		
		end component xor_block;

--signal sum: std_logic_vector(21 downto 0);
--signal carry_out : std_logic;

--signal g1_pseudo : std_logic :='0';              --G value of rightmost first stage

signal g1: std_logic_vector( 20 downto 0) := (others=> '0');  --Signals for assigning G and P values of various stages
signal p1: std_logic_vector( 20 downto 0) := (others=> '0');
signal g2: std_logic_vector( 9 downto 0) := (others=> '0');
signal p2: std_logic_vector( 9 downto 0) := (others=> '0');
signal g3: std_logic_vector( 4 downto 0) := (others=> '0');
signal p3: std_logic_vector( 4 downto 0) := (others=> '0');
signal g4: std_logic_vector( 1 downto 0) := (others=> '0');
signal p4: std_logic_vector( 1 downto 0) := (others=> '0');
signal g5: std_logic_vector( 0 downto 0) := (others=> '0');
signal p5: std_logic_vector( 0 downto 0) := (others=> '0');
--signal g6,p6 : std_logic :='0';

signal carry_internal : std_logic_vector( 21 downto 0) := (others=> '0'); --Signals for internal carry bits

signal p: std_logic_vector(20 downto 0) := (others=> '0');  ---P of each term for sum calculation

begin

--rightmost first block
--stage_a: entity work.xor_block(arch1) port map( a(0), b(0), p1(0));
--stage_b: and_block port map( a(0), b(0), g1(0));
--stage_b: entity work.and_block(arch1) port map( a(0), b(0), g1_pseudo);   --UNCOMMENT THESE 2 LINES IF CIN IS NOT 0
--stage_c: entity work.a_or_bc_block(arch1) port map( g1_pseudo, p1(0), carry_in, g1(0)); --and start the first generate from 1

--rest of the blocks
generate_first_stage: for i in 0 to 20 generate
							stage1_0: xor_block port map( a(i), b(i), p1(i));
							stage1_1: and_block port map( a(i), b(i), g1(i));
end generate generate_first_stage;

generate_second_stage: for i in 0 to 9 generate
							stage2_0: a_or_bc_block port map( g1((2*i)+1), p1((2*i)+1), g1(2*i), g2(i));
							stage2_1: and_block port map( p1(2*i+1), p1(2*i), p2(i));
end generate generate_second_stage;

generate_third_stage: for i in 0 to 4 generate
							stage3_0: a_or_bc_block port map( g2(2*i+1), p2(2*i+1), g2(2*i), g3(i));
							stage3_1: and_block port map( p2(2*i+1), p2(2*i), p3(i));
end generate generate_third_stage;

generate_fourth_stage: for i in 0 to 1 generate
							stage4_0: a_or_bc_block port map( g3(2*i+1), p3(2*i+1), g3(2*i), g4(i));
							stage4_1: and_block port map( p3(2*i+1), p3(2*i), p4(i));
end generate generate_fourth_stage;

generate_fifth_stage: for i in 0 to 0 generate
							stage5_0: a_or_bc_block port map( g4(1), p4(1), g4(0), g5(0));
							--stage5_1: and_block port map( p4(1), p4(0), p5(0));
end generate generate_fifth_stage;



--carry_out <= g6;
--carry_out<= g6 or (p(6) and carry_in);
carry_internal(0)<= '0';
carry_internal(1)<= g1(0);
carry_internal(2)<= g2(0);
carry_internal(4)<= g3(0);
carry_internal(8)<= g4(0);
carry_internal(16)<= g5(0);

--carry internals that use first stage g and p values
generate_carry_stage1: for i in 1 to 10 generate
							carry_stage1: a_or_bc_block port map(g1(2*i),p1(2*i),carry_internal(2*i), carry_internal(2*i+1));
end generate generate_carry_stage1;

--carry internals that use second stage g and p values
generate_carry_stage2: for i in 1 to 4 generate
							carry_stage2: a_or_bc_block port map(g2(2*i),p2(2*i),carry_internal(4*i), carry_internal(4*i+2));
end generate generate_carry_stage2;

--carry internals that use third stage g and p values
 generate_carry_stage3: for i in 1 to 2 generate
 							carry_stage3: a_or_bc_block port map(g3(2*i),p3(2*i),carry_internal(8*i), carry_internal(8*i+4));
 end generate generate_carry_stage3;

carry_out <= carry_internal(21);


--sum terms
generate_sum_stage: for i in 0 to 20 generate
							sum_stage0: xor_block port map(a(i),b(i), p(i)); 
							sum_stage1: xor_block port map(p(i),carry_internal(i), sum(i));
end generate generate_sum_stage;

--add_out <= carry_out & sum;

end arch1;


