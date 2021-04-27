--- -CREATE A 16 BIT REGISTER FROM THE 8 BIT REGISTER


LIBRARY IEEE; 
USE IEEE.STD_LOGIC_1164.ALL;

entity reg8_2x2 is 
		port(clk, wr_en: in std_logic;
		d: in std_logic_vector(15 downto 0); -- 8 bit input 
		q: out std_logic_vector(15 downto 0) -- 8 bit output 
		);
		end reg8_2X2;
architecture arch of reg8_2X2 is
	COMPONENT REG8 is
		port(clk, wr_en: in std_logic;
		d: in std_logic_vector(7 downto 0); -- 8 bit input 
		q: out std_logic_vector(7 downto 0)); -- 8 bit output 
		
			END COMPONENT REG8; 
--SIGNALS
	BEGIN
REGMAP : REG8 PORT MAP (Clk, wr_en, D(7 downto 0),Q(7 downto 0));
REGMAP2 : REG8 PORT MAP (Clk, wr_en, D(15 downto 8),Q(15 downto 8));
end arch;