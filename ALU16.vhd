--16 BIT ALU
Library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



ENTITY ALU16 IS
PORT(
		A,B : IN STD_LOGIC_Vector(15 DOWNTO 0); -- 4 4-bit inputs
		S			: IN STD_LOGIC_Vector(2 DOWNTO 0);
		-- NOTE INITIAL CIN IS SET TO SEL(2), IT IS NOT INPUT FROM COUT UNTIL SECOND ALU4
		F			: OUT STD_LOGIC_Vector(15 DOWNTO 0);
	 COUT, OVERFLOW, ZERO	: OUT STD_LOGIC);
	 
END ALU16;

ARCHITECTURE Behavior OF ALU16 IS
 
COMPONENT ALU4
PORT
 (
	 A, B		: IN STD_LOGIC_VECTOR(3 DOWNTO 0); --ONE BIT CONTROL WHICH WILL BE THE 3RD BIT OF THE SEL FOR THE ALU 
	 SEL			: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
	 CIN,LESS			: IN STD_LOGIC;
	 F				: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	 COUT, OVERFLOW, SET, ZERO	: OUT STD_LOGIC
 );
END COMPONENT;


SIGNAL NC, COUT1, COUT2, COUT3, ZERO1, ZERO2, ZERO3,ZERO4, LASTSET: STD_LOGIC;  
BEGIN
ALU0: ALU4 PORT MAP(A(3 DOWNTO 0), B(3 DOWNTO 0), S, S(2),LASTSET,F(3 DOWNTO 0), COUT1, NC, NC, ZERO1);
ALU1: ALU4 PORT MAP(A(7 DOWNTO 4), B(7 DOWNTO 4), S, COUT1,'0',	F(7 DOWNTO 4), COUT2, NC, NC, ZERO2);
ALU2: ALU4 PORT MAP(A(11 DOWNTO 8), B(11 DOWNTO 8), S, COUT2,'0',F(11 DOWNTO 8), COUT3, NC, NC, ZERO3);
ALU3: ALU4 PORT MAP(A(15 DOWNTO 12), B(15 DOWNTO 12), S, COUT3,'0',F(15 DOWNTO 12), COUT, OVERFLOW, LASTSET, ZERO4);

change_state: PROCESS(A,B,S)
BEGIN
ZERO<= NOT(ZERO1 OR ZERO2 OR ZERO3 OR ZERO4);


END PROCESS change_state;
END Behavior;
