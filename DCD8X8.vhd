--Create a DCD 3 to 8 decoder
--this component will select where to write
--3 inputs//8 outputs
Library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DCD8X8 is
port(A : IN std_logic_vector(2 downto 0);
		B : out std_logic_vector(7 downto 0));

END DCD8X8;

architecture decoder of DCD8X8 is
BEGIN
	process(A)
	begin
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
	END process;
END decoder;