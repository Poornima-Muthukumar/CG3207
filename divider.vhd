----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:57:12 10/02/2013 
-- Design Name: 
-- Module Name:    adder32 - Behavioral 
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity divider32 is
    Port ( operand1 : in  STD_LOGIC_VECTOR (31 downto 0);
           operand2 : in  STD_LOGIC_VECTOR (31 downto 0);
           result1 : out  STD_LOGIC_VECTOR (31 downto 0);
           result2 : out  STD_LOGIC_VECTOR (31 downto 0);
           clk : in  STD_LOGIC);
end divider32;



architecture arch_divider32 of divider32 is

signal div_result: std_logic_vector (31 downto 0):= (others=>'0');
signal div_remainder: std_logic_vector (31 downto 0):= (others=>'0');

begin
process(clk)
variable remainder: std_logic_vector(31 downto 0):= (others=>'0');
variable count:  std_logic_vector(31 downto 0):= (others=>'0');
begin
if (clk'event and clk='1') then

remainder:=operand1;
for i in 0 to 3 loop 
if remainder > operand2 then
   count:=count+1;   
   remainder:= remainder - operand2;
else 
exit;
end if;
end loop;
end if;
result1 <= count;
result2 <= remainder;
end process;
end arch_divider32;