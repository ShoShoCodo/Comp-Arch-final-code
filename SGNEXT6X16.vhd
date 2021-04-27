-- sgnext6X16
--sign extended from 6 bits to 16 bits


Library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sgnext6X16 is
--GENERIC(TWO :STD_LOGIC);
PORT
 (
	 x_in	: IN STD_LOGIC_VECTOR(5 DOWNTO 0); --takes in the 16 bit input
	 sum 			: OUT STD_LOGIC_VECTOR(15 DOWNTO 0) -- sends out the 16 bit output
	 --doesn't need to declare the constant of 2
 );

END sgnext6X16;
architecture struct of sgnext6X16 is 

--signals

BEGIN

process (x_in)
begin
    SUM <= (others => X_IN(5)); -- should use XIN(5) OR 1 AND 0 for sign extended
    SUM(5 downto 0) <= X_IN; -- sets the LEAST MOST BITS TO THE INPUT VALUE
end process;
END STRUCT;