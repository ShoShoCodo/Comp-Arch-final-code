---bitwise AND 
Library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity BWAND4 is
PORT
 (
	 x_IN 		: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	 Y_IN			: IN STD_LOGIC_VECTOR(3 DOWNTO 0);	
	 Z_OUT		: OUT STD_LOGIC_VECTOR(3 DOWNTO 0)	
 );

END BWAND4;

architecture ARCH of BWAND4 is

BEGIN
PROCESS(x_IN,y_IN)
BEGIN
	 
	 Z_OUT <= X_IN AND y_IN;
	 
	END PROCESS;
END ARCH;