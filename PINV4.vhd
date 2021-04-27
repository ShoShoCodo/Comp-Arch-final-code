---bitwise 4-BIT INVERTER 
Library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PINV4 is
PORT
 (
	 x_IN 		: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	 y_OUT		: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	 SEL			: IN STD_LOGIC -- ONE BIT CONTROL WHICH WILL BE THE 3RD BIT OF THE SEL FOR THE ALU
 );

END PINV4 ;

architecture ARCH of PINV4  is
	--SIGNAL X_INV		: STD_LOGIC_VECTOR(3 DOWNTO 0); -- NOT NEEDED 
BEGIN
PROCESS(SEL)
	BEGIN -- Could also XOR B with the SEL signal 
	 FOR I IN 0 TO (3) LOOP
		Y_OUT(I) <= X_IN(I) XOR SEL;
	 END LOOP;
	
--		 FOR I IN 0 TO (3) LOOP
--				IF (SEL = '1') THEN 
--						Y_OUT(I) <= NOT X_IN(I); -- inverts the input and sends it to the output  is sel is SUB or SLT
--				  ELSE
--				  Y_OUT(I) <= X_IN(I);
--				  END IF;
--			 END LOOP;
		 END PROCESS;
END ARCH;