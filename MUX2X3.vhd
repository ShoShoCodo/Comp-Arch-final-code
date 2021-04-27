--Design a 3-input, 2 inputs will be the inputs and 1 input will be the select, 16-bit multiplexer MUX3x16

Library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MUX2X3 is
port(
		S: IN STD_LOGIC;
		W0 : IN std_logic_vector(2 downto 0);
		W1 : IN std_logic_vector(2 downto 0);
		F : out std_logic_vector(2 downto 0));

END MUX2X3;

ARCHITECTURE STRUCT OF MUX2X3 IS
BEGIN 
change_state: PROCESS(S)
BEGIN
CASE S IS  
		when '0' => f <= w0; -- when S is 0 select the first input w0
		when '1' => f <= w1;
		when others => f <= w0; -- all other options should not occur
		end case;
			END PROCESS change_state;
END STRUCT;