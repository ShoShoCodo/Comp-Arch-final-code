--Create 4X16 DECODE USING TWO DCD 3 to 8 decoders
--this component will select where to write
--4 inputs//16 outputs
Library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DCD4X16 is
port(A : IN std_logic_vector(3 downto 0);
		B : out std_logic_vector(15 downto 0);
		EN1: IN std_logic); -- THIS ENABLE IS USED TO CHECK THE ADDRESS RANGES

END DCD4X16;

ARCHITECTURE STRUCT OF DCD4X16 IS
COMPONENT DCD3X8_EN IS 
port(A : IN std_logic_vector(2 downto 0);
		B : out std_logic_vector(7 downto 0);
		EN: IN STD_LOGIC);
END COMPONENT;

SIGNAL NOT_EN : STD_LOGIC;
SIGNAL B1 : std_logic_vector(7 downto 0);
SIGNAL B2 : std_logic_vector(7 downto 0);

BEGIN
NOT_EN <= NOT(A(3));
DECODER1: DCD3X8_EN PORT MAP(A(2 DOWNTO 0), B1,A(3));
DECODER2: DCD3X8_EN PORT MAP(A(2 DOWNTO 0), B2, NOT_EN);

PROCESS(A,EN1)
BEGIN
	IF EN1 ='1' THEN
	B<= B1&B2;
	else
	B<= "0000000000000000";
	END IF; 
END PROCESS;
END STRUCT;