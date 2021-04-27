-- create an 8 bit register REG8
--8 bit input d(7:0)
--1 bit enable EN
--rising edge enable clock CLK
--8 bit OUTput 

LIBRARY IEEE; 
USE IEEE.STD_LOGIC_1164.ALL;

entity reg8 is 
port(clk, wr_en: in std_logic;
d: in std_logic_vector(7 downto 0); -- 8 bit input 
q: out std_logic_vector(7 downto 0) -- 8 bit output 
);
end reg8;
architecture arch of reg8 is 
begin 
	process(clk) 
	begin 
--		if (reset ='1') then 
--		q <= (others => '0');
--		els
		if (clk'event and clk ='1') then --rising edge enable clock CLK
			if wr_en='1' then -- enable bit
			q <=d;
			end if;
		end if;
	end process; 
end arch;