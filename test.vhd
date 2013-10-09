
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity logical_shifters_1 is
    port(CLK : in std_logic;
         DI : in unsigned(7 downto 0);
         SEL : in unsigned(1 downto 0);
         SO : out unsigned(7 downto 0));
end logical_shifters_1;

architecture archi of logical_shifters_1 is
   process (CLK)
   begin
      if (CLK'event and CLK = '1') then
         case s is
            when "00" => SO <= DI ;
            when "01" => SO <= DI sll 1;
            when "10" => S0 <= DI sll 2;
            when "11" => SO <= DI sll 3;
            when others => SO <= DI ;
         end case;
      end if;
   end process;
end archi;


				