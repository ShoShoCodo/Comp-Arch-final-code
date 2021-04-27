--Create a DCD 3 to 8 decoder
--this component will select where to write
--3 inputs//8 outputs
Library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DCD3X8_EN is
port(A : IN std_logic_vector(2 downto 0);
		B : out std_logic_vector(7 downto 0);
		EN: IN STD_LOGIC);

END DCD3X8_EN;

architecture DECODE of DCD3X8_EN is
BEGIN
	process(A,en)
	
	begin
	IF (EN='1') THEN
		case A is 
			when "000" => B <= "00000001";
			when "001" => B <= "00000010";
			when "010" => B <= "00000100";
			when "011" => B <= "00001000";
			when "100" => B <= "00010000";
			when "101" => B <= "00100000";
			when "110" => B <= "01000000";
			when "111" => B <= "10000000";
			when others =>B <= "00000000";
		END case;
		ELSE
		B <= "00000000";
		END IF;
	END process;
END DECODE;