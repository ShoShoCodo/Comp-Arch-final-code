--Design a 3-input, 2 inputs will be the inputs and 1 input will be the select, 16-bit multiplexer MUX3x16

Library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PCJMP is
port(
		
		PC : IN std_logic_vector(15 downto 0);
		JUMP_ADD : IN std_logic_vector(11 downto 0);
		OUTx : out std_logic_vector(15 downto 0));

END PCJMP;

ARCHITECTURE STRUCT OF PCJMP IS
BEGIN 

OUTx<= PC(15 downto 13) & JUMP_ADD &'0';

END STRUCT;