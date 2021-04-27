--SHIFT LEFT BY ONE BIT 
--INPUT IS A 16 BIT NUMBER

Library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SHLONE is
--GENERIC(TWO :STD_LOGIC);
PORT(
X: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
y: OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
);
END SHLONE;

architecture struct of sHlone is
--constants
begin
process(X)
begin

y <= std_logic_vector(shift_left(unsigned(x),1)); -- need to cast it to unsigned to work in the function and hen cast it back to a vector
end process;
end struct; 