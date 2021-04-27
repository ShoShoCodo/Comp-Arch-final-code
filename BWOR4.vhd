---bitwise OR
Library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity BWOR4 is
PORT
 (
	 x_IN 		: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	 Y_IN			: IN STD_LOGIC_VECTOR(3 DOWNTO 0);	
	 Z_OUT		: OUT STD_LOGIC_VECTOR(3 DOWNTO 0)	
 );

END BWOR4;

architecture ARCH of BWOR4 is

BEGIN
PROCESS(x_IN,y_IN)
BEGIN
	-- FOR I IN 3 TO 0 LOOP 
	 Z_OUT <= X_IN OR y_IN;
	-- END LOOP;
	END PROCESS;
END ARCH;