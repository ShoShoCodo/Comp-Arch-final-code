--INCTWO
--INCREASE A 16 BIT NUMBER BY 2
--REMOVED THE CARRY OUT, MAY NEED TO ADD BACK?
Library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity INCTWO is
--GENERIC(TWO :STD_LOGIC);
PORT
 (
	 x_in	: IN STD_LOGIC_VECTOR(15 DOWNTO 0); --takes in the 16 bit input
	 sum 			: OUT STD_LOGIC_VECTOR(15 DOWNTO 0) -- sends out the 16 bit output
	 --doesn't need to declare the constant of 2
 );

END INCTWO;

architecture STRUCT OF INCTWO IS 
--COMPONENTS HERE 

constant TWO : STD_LOGIC_VECTOR(15 DOWNTO 0) := "0000000000000010";

COMPONENT ADD16 IS 
PORT
 (
	 x_in, Y_in	: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	 carry_in1 	: IN STD_LOGIC;
	 sum 			: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	 carry_out 	: OUT STD_LOGIC
 );
END COMPONENT;
--SIGNALS HERE 

BEGIN
--GENERIC MAP(TWO => "0000000000000010");
--PORTMAPS HERE	
ADD2: ADD16 PORT MAP(x_in,TWO,'0',sum);

--PROCESS HERE

END STRUCT;