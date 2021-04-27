--ins mem
--16 BIT ADDRESS INPUT, 16 BIT OUTPUT 
-- ADDRESSES ARE FROM 0X0000 TO 0X003F, BETWEEN 0 AND 111111 EVERYTHING ELSE 0

Library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity INS_MEM is
port(
		ADDR : IN std_logic_vector(15 downto 0);
		DOUT: OUT std_logic_vector(15 downto 0));
		--CHECK: OUT STD_LOGIC);
END INS_MEM;

architecture ARCH of INS_MEM is
TYPE INS_ARR IS ARRAY( INTEGER RANGE <>) OF STD_logic_vector(15 DOWNTO 0);
SIGNAL MEM_INT: INS_ARR(31 DOWNTO 0);
SIGNAL SEL : STD_LOGIC_VECTOR(31 DOWNTO 0); -- THIS IS OUTPUT FROM THE 5x32 AND ACTS AS THE SELECT
SIGNAL ADDR_IN_CHECK: STD_LOGIC; -- THIS IS USED TO CHECK THAT THE ADDRESSES ARE VALID 
SIGNAL MEM_ADDR_CHECK: STD_LOGIC; -- THIS IS USED TO CHECK THAT THE ADDRESSES ARE VALID 
--SIGNALS

COMPONENT DCD5X32 is
port(A : IN std_logic_vector(4 downto 0);
		B : out std_logic_vector(31 downto 0);
		EN1: IN STD_LOGIC);
END COMPONENT;

BEGIN
--PORTMAPPING/OTHER
--CHECKS TO MAKE SURE FIRST TEN BITS ARE =0 SINCE WE ARE ONLY USING 5..0
ADDR_IN_CHECK <=((NOT addr(15)) AND (NOT addr(14)) AND (NOT addr(13)) AND (NOT addr(12))AND (NOT addr(11))AND (NOT addr(10))AND (NOT addr(9))AND (NOT addr(8)) AND (NOT addr(7))AND (NOT addr(6)));
--CHECK<=ADDR_IN_CHECK;

SELECTION: DCD5X32 PORT MAP( ADDR(5 DOWNTO 1), SEL,ADDR_IN_CHECK);
--PROCESS
		MEM_INT(0)<= "0000000111001010"; --pc=00 lowest mem R0 0X000 to R7 0X0100, R1<-- R0+R7, THIS WILL MOVE IT INTO THE ADDRESS SPACE FOR THE DATA 
		MEM_INT(1)<= "0000000111010010";	--pc=10 add $2,$0,$7 lowest mem R0 0X000 to R7 0X0100, R2<-- R0+R7
		MEM_INT(2)<= "1011111110000000"; --pc=100 lw $6, 0($7)
		MEM_INT(3)<= "1011111011000010";	--pc=110 lw $3, 2($7)
		MEM_INT(4)<= "1111001001000100";	--pc=1000 sw $1,  4($1)
		MEM_INT(5)<= "0000011011100010"; --pc=1010 add $4,$3,$3
		MEM_INT(6)<= "1011000001000100";	--pc=1100 lw $1, 4($0) out of bounds check
		MEM_INT(7)<= "0100011011000110";	--pc=1110 BEQ $3,$3, x0006, should jump to 14
		MEM_INT(14)<="0010000000000000";	--Jump back to inst 0
		
PROCESS(ADDR)
BEGIN
	
		FOR I IN 0 TO 31 LOOP
			IF SEL(I) ='1' THEN-- AND MEM_INT(i)(6)='0' THEN --MAKE SURE BIT 6 IS ZERO FOR THE ADDRESS SIZE 
			--Addresses need to be between 0x0000 to 0x003F
			MEM_ADDR_CHECK <= (MEM_INT(I)(15) OR MEM_INT(I)(14) OR MEM_INT(I)(13) OR MEM_INT(I)(12)) AND( MEM_INT(I)(5) OR MEM_INT(I)(4)); -- we need 5 and 6 bit low for storing the adress but only if the opcode is not R-type
			--CHECK<=MEM_ADDR_CHECK;
					if MEM_ADDR_CHECK='0' then
					DOUT <= MEM_INT(I); 
					else
					DOUT <= "ZZZZZZZZZZZZZZZZ"; 
					end if;
			elsif ADDR_IN_CHECK ='0' then
			DOUT <= "ZZZZZZZZZZZZZZZZ"; 
			END IF;
		END LOOP;	
END PROCESS;
END ARCH;