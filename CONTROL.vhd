Library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CONTROL is
port(
Opcode : in std_logic_vector(15 downto 0);
ZERO : IN STD_LOGIC;
RegDST, REGWrite, ALUSrc, Memwrite,MEMread, MEMToReg, Branch,jump : out std_logic;
ALU_SEL: OUT STD_LOGIC_VECTOR(2 DOWNTO 0));
 -- not including the ALUop and the PCSRC at this moment because they will be added with later functions 
END CONTROL;
 
architecture STRUCT of control is 
--signals 
--components
signal B : std_logic_vector(7 downto 0);
begin
--portmapping
process (opcode)
begin
		case Opcode(15 downto 12) is 
			when "0000" => -- This is for R-type instructions THE OPCODE IS 0000
					B 			<= "11000010"; 
					ALU_SEL 	<= OPCODE(2 DOWNTO 0); --ALU SEL IS WHATEVER THE FUNCT IS
			when "1011" => -- LW THE OPCODE IS 1011
					B 			<= "01101110"; 
					ALU_SEL 	<= "010";-- LW THE OPCODE IS 1011 ALU SEL IS ADD
			when "1111" => -- SW THE OPCODE IS 1111
					B 			<= "00110010"; 
					ALU_SEL 	<= "010"; -- SW THE OPCODE IS 1111 ALU SEL IS ADD
			when "0100" => -- BEQ THE OPCODE IS 0100
					B 			<= "00000011"; 
					ALU_SEL 	<= "110"; -- BEQ THE OPCODE IS 0100 ALU SEL IS SUBTRACT
			when "0010" => -- JUMP THE OPCODE IS 0010 PCSEL=0 WITH JUMP
					B 			<= "00000000"; 
					ALU_SEL 	<= "010"; -- JUMP THE OPCODE IS 0010 PCSEL=0 WITH JUMP
			when others => 
					B 			<= "00000010"; -- THIS MAKES PCSEL1 = 1 TO SELECT THE pc+2
					ALU_SEL 	<="010"; -- THIS MAKES PCSEL1 = 1 TO SELECT THE pc+2
		END case;
	
	RegDST 	<=B(7);
	REGWrite	<=B(6);
	ALUSrc	<=B(5);
	Memwrite	<=B(4);--ONLY HIGH FOR SW
	MEMread	<=B(3);
	MEMToReg	<=B(2); --ONLY HIGH FOR LW
	Jump		<=B(1); --PCSEL1
	Branch	<=B(0) AND ZERO; --PCSEL0
end process;


	

end STRUCT;