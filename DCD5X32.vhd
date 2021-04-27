--Create 5X32 DECODE USING TWO DCD 3 to 8 decoders
--this component will select where to write
--5 inputs//32 outputs
Library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DCD5X32 is
port(A : IN std_logic_vector(4 downto 0);
		B : out std_logic_vector(31 downto 0);
		EN1: IN STD_logic);

END DCD5X32;

ARCHITECTURE STRUCT OF DCD5X32 IS

	COMPONENT DCD3X8_EN IS 
	port(A : IN std_logic_vector(2 downto 0);
			B : out std_logic_vector(7 downto 0);
			EN: IN STD_LOGIC);
	
	END COMPONENT;
	
SIGNAL EN : STD_LOGIC_vector(1 downto 0);
SIGNAL EN_mux : STD_LOGIC_vector(3 downto 0);
SIGNAL B1, B2, B3, B4 : STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN
EN <= A(4 downto 3); -- takes the 4th and 5th element and uses them in a 2x4 mux for the enable bit on the 3x8 decoders

DECODER1: DCD3X8_EN PORT MAP(A(2 DOWNTO 0), B1, EN_mux(0));
DECODER2: DCD3X8_EN PORT MAP(A(2 DOWNTO 0), B2, EN_mux(1));
DECODER3: DCD3X8_EN PORT MAP(A(2 DOWNTO 0), B3, EN_mux(2));
DECODER4: DCD3X8_EN PORT MAP(A(2 DOWNTO 0), B4, EN_mux(3));
process(a)
begin
case EN is
when "00" => EN_mux <= "0001"; when "01" => EN_mux <= "0010"; when "10" => EN_mux <= "0100"; when "11" => EN_mux <= "1000";
end case;

IF EN1 ='1' THEN
	B<= B4&B3&B2&B1;
	else
	B<= "00000000000000000000000000000000";
	END IF; 
end process;

END STRUCT;