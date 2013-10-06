----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:39:18 09/18/2013 
-- Design Name: 
-- Module Name:    alu - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alu is
Port (	Clk			: in	STD_LOGIC;
		Control		: in	STD_LOGIC_VECTOR (5 downto 0);
		Operand1	: in	STD_LOGIC_VECTOR (31 downto 0);
		Operand2	: in	STD_LOGIC_VECTOR (31 downto 0);
		Result1		: out	STD_LOGIC_VECTOR (31 downto 0);
		Result2		: out	STD_LOGIC_VECTOR (31 downto 0);
		Debug		: out	STD_LOGIC_VECTOR (31 downto 0));
end alu;



architecture arch_alu of alu is

component adder32 is
    Port ( operand1 : in  STD_LOGIC_VECTOR (31 downto 0);
           operand2 : in  STD_LOGIC_VECTOR (31 downto 0);
           result : out  STD_LOGIC_VECTOR (31 downto 0);
           debug : out  STD_LOGIC_VECTOR (31 downto 0);
           clk : in  STD_LOGIC);
end component;

component multiplier32 is
    Port ( operand1 : in  STD_LOGIC_VECTOR (31 downto 0);
           operand2 : in  STD_LOGIC_VECTOR (31 downto 0);
           result1 : out  STD_LOGIC_VECTOR (31 downto 0);
           result2 : out  STD_LOGIC_VECTOR (31 downto 0);
           clk : in  STD_LOGIC);
end component;

Signal temp_result_adder : std_logic_vector(31 downto 0);
Signal temp_result_subtractor : std_logic_vector(31 downto 0);
Signal temp_debug_adder : std_logic_vector(31 downto 0);
Signal temp_debug_subtractor : std_logic_vector(31 downto 0);

Signal temp_result_unsignedadder : std_logic_vector(31 downto 0);
Signal temp_result_unsignedsubtractor : std_logic_vector(31 downto 0);
Signal temp_debug_unsignedadder : std_logic_vector(31 downto 0);
Signal temp_debug_unsignedsubtractor : std_logic_vector(31 downto 0);
Signal temp_result1_multiplier : std_logic_vector(31 downto 0);
Signal temp_result2_multiplier : std_logic_vector(31 downto 0);
Signal temp_result1_unsignedmultiplier : std_logic_vector(31 downto 0);
Signal temp_result2_unsignedmultiplier : std_logic_vector(31 downto 0);


Signal final_Operand1: std_logic_vector(31 downto 0);
Signal final_Operand2: std_logic_vector(31 downto 0);
Signal final_Operand3: std_logic_vector(31 downto 0);
Signal operand3: std_logic_vector(31 downto 0);
begin
 
final_Operand1 <= not operand1 + 1 when operand1(31)='1' else
						operand1 when operand1(31)='0' ;
						
final_Operand2 <= not operand2 + 1 when operand2(31)='1' else
						operand2 when operand2(31)='0';
						

final_operand3 <= not final_operand2 +1;
operand3 <= not operand2 +1;

					
adder : adder32 port map( Operand1 ,Operand2 , temp_result_adder,temp_debug_adder,clk);
subtractor : adder32 port map( Operand1 ,operand3 , temp_result_subtractor,temp_debug_subtractor,clk);
adder_u : adder32 port map( final_Operand1 ,final_Operand2 , temp_result_unsignedadder,temp_debug_unsignedadder,clk);
subtractor_u : adder32 port map( final_Operand1 , final_operand3, temp_result_unsignedsubtractor,temp_debug_unsignedsubtractor,clk);
multiplier: multiplier32 port map( Operand1 ,Operand2 , temp_result1_multiplier,temp_result2_multiplier,clk);
multiplier_u: multiplier32 port map( final_Operand1 ,final_Operand2 , temp_result1_unsignedmultiplier,temp_result2_unsignedmultiplier,clk);
process (Clk)
begin  
   if (Clk'event and Clk = '1') then
      if Control(5) = '1' then
         Result1 <= X"00000000";
		 Result2 <= X"00000000";
		 Debug   <= X"00000000";

		elsif (Control = "000001") then
		Result1 <=temp_result_adder;
		Debug <= temp_debug_adder;
		
		elsif (Control = "000010") then
		Result1 <= temp_result_unsignedadder;
		Debug <= temp_debug_unsignedadder;
		
		elsif (Control = "000011") then
		Result1 <=temp_result_subtractor;
		Debug <= temp_debug_subtractor;
		
		elsif (Control = "000100") then
		Result1 <=temp_result_unsignedsubtractor;
		Debug <= temp_debug_unsignedsubtractor;
		
		elsif (Control = "000101") then
		Result1 <=temp_result1_multiplier;
		Result2 <=temp_result2_multiplier;
		
		elsif (Control = "000110") then
		Result1 <=temp_result1_unsignedmultiplier;
		Result2 <=temp_result2_unsignedmultiplier;
		
      else
       
		 Result1 <= operand1;
		 Result2 <= operand2;
		 Debug   <= (Control(1) & Control(0) & Control & Control & Control & Control & Control);
      end if;
   end if;
end process;


end arch_alu;

