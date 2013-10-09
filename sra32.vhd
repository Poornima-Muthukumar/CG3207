----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:57:12 10/02/2013 
-- Design Name: 
-- Module Name:    and32 - Behavioral 
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
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sra32 is
    Port ( operand1 : in   BIT_VECTOR (31 downto 0);
           operand2 : in  std_logic_vector (31 downto 0);
           result1 : out  BIT_VECTOR   (31 downto 0);
           clk : in  STD_LOGIC);
end sra32;

architecture arch_sra32 of sra32 is
signal result: BIT_VECTOR  (31 downto 0):= "00000000000000000000000000000000";

begin
process(clk)
variable shiftbits : integer;
begin
if (clk'event and clk='1') then
shiftbits :=conv_integer(operand2);


result <=  operand1 sra shiftbits;
end if;

result1 <= result;
end process;
end arch_sra32;