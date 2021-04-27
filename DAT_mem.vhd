--DAT_MEM
--2 16- BIT INPUTS 
--16 MEMORY WORDS(32 BYTES) AND THE MEMORY IS BYTE ADDRESSABLE 
--EACH WORD ADDRESS WILL HOLD 2 BYTES
--BYTE ADDRESSES FROM 0X0100 TO 0X011F
--1 WORD = 2 BYTES

Library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DAT_MEM is
port(
		CLK: IN STD_LOGIC;
		WE,RE: IN STD_LOGIC;
		ADDR,DIN : IN std_logic_vector(15 downto 0);
		DOUT: OUT std_logic_vector(15 downto 0);
	Check: out std_logic);
END DAT_MEM;

architecture MEM_MAP of DAT_MEM is

COMPONENT reg8 is  --This declares reg 8 as a register
port(clk, wr_en: in std_logic;
d: in std_logic_vector(7 downto 0); -- 8 bit input 
q: out std_logic_vector(7 downto 0) -- 8 bit output 
);
END COMPONENT;

COMPONENT DCD4X16 is
port(A : IN std_logic_vector(3 downto 0);
		B : out std_logic_vector(15 downto 0);
		EN1: IN std_logic);

END COMPONENT;
--SIGNALS
TYPE data_ARR IS ARRAY( INTEGER RANGE <>) OF STD_logic_vector(15 DOWNTO 0);
SIGNAL INTERNAL_BUS: data_ARR(15 DOWNTO 0);
SIGNAL SEL : STD_LOGIC_VECTOR(15 DOWNTO 0);
Signal word_sel_and: STD_logic_vector(15 downto 0); --This is a vector for anding with the WE to select the register to write to  
SIGNAL ADDRESS_CHECK: STD_LOGIC; -- THIS WILL CHECK TO MAKE SURE THE ADDRESS IS WITHIN RANGE 
BEGIN
--PORTMAPPING
--Addresses need to be between 0x0100 to 0x011F
ADDRESS_CHECK <=((NOT addr(15)) AND (NOT addr(14)) AND (NOT addr(13)) AND (NOT addr(12))AND (NOT addr(11))AND (NOT addr(10)) AND (NOT addr(9))AND addr(8)) AND (NOT addr(7))AND (NOT addr(6))AND (NOT addr(5));
DECODER: dcd4x16 PORT MAP(ADDR(4 DOWNTO 1),SEL,ADDRESS_CHECK);-- DECODES THE ADDRESS BITS 1-->4 INTO 16 BITS FOR EACH REGISTER
WORDGEN: FOR i IN  2 TO 15 GENERATE
	word_sel_and(I) <= SEL(i) AND WE;
	B0: REG8 PORT MAP(CLK,word_sel_and(I),DIN(7 DOWNTO 0),INTERNAL_BUS(i)(7 DOWNTO 0));
	B1: REG8 PORT MAP(CLK,word_sel_and(I),DIN(15 DOWNTO 8),INTERNAL_BUS(i)(15 DOWNTO 8));
END GENERATE;

PROCESS(CLK)         
begin
check<= address_CHECK;
INTERNAL_BUS(0) <= "1100110011001100";
INTERNAL_BUS(1) <= "0000111100001111";

	if RE='0' then -- enable bit
			DOUT <= "ZZZZZZZZZZZZZZZZ";	
			ELSE
					case SEL is
							when "0000000000000001" => DOUT <= INTERNAL_BUS(0);
							when "0000000000000010" => DOUT <= INTERNAL_BUS(1);
							when "0000000000000100" => DOUT <= INTERNAL_BUS(2);
							when "0000000000001000" => DOUT <= INTERNAL_BUS(3);
							when "0000000000010000" => DOUT <= INTERNAL_BUS(4);
							when "0000000000100000" => DOUT <= INTERNAL_BUS(5);
							when "0000000001000000" => DOUT <= INTERNAL_BUS(6);
							when "0000000010000000" => DOUT <= INTERNAL_BUS(7);
							when "0000000100000000" => DOUT <= INTERNAL_BUS(8);
							when "0000001000000000" => DOUT <= INTERNAL_BUS(9);
							when "0000010000000000" => DOUT <= INTERNAL_BUS(10);
							when "0000100000000000" => DOUT <= INTERNAL_BUS(11);
							when "0001000000000000" => DOUT <= INTERNAL_BUS(12);
							when "0010000000000000" => DOUT <= INTERNAL_BUS(13);
							when "0100000000000000" => DOUT <= INTERNAL_BUS(14);
							when "1000000000000000" => DOUT <= INTERNAL_BUS(15);
							when others => DOUT <= "ZZZZZZZZZZZZZZZZ"; --THIS WILL HAPPEN IF THE ADDRESS IS OUTSIDE OF THE RANGE
						end case;
			--end if;
		end if; -- ends clock check if
	end process; 
END MEM_MAP;