-- CREATE 4 BIT ADDER 
Library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ADD4 is
PORT
 (
	 x_in, Y_in	: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	 carry_in1 	: IN STD_LOGIC;
	 sum 			: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	 carry_out 	: OUT STD_LOGIC
 );

END ADD4;

architecture ARCH of ADD4 is

	SIGNAL h_sum 		: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL carry_gen	: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL carry_prop : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL carry_in 	: STD_LOGIC_VECTOR(3 DOWNTO 1);

BEGIN
	 h_sum <= x_in XOR y_in;
	 carry_gen <= x_in AND y_in;
	 carry_prop <= x_in OR y_in;

	process(CARRY_GEN, CARRY_PROP, CARRY_IN)
	begin
		CARRY_IN(1)<= CARRY_GEN(0) OR (CARRY_PROP(0) AND CARRY_IN1);
		
		INST: FOR I IN 1 TO (3-1) LOOP
			CARRY_IN(I+1) <= CARRY_GEN(I) OR (CARRY_PROP(I) AND CARRY_IN(I));
			END LOOP;
			
			CARRY_OUT <= CARRY_GEN(3) OR (CARRY_PROP(3) AND CARRY_IN(3));
	END process;
	
	SUM(0) <= H_SUM(0) XOR CARRY_IN1; -- THIS IS USING THE OTHER CARRY IN 
	SUM(3 DOWNTO 1) <= H_SUM(3 DOWNTO 1) XOR CARRY_IN(3 DOWNTO 1);
	
	END ARCH;