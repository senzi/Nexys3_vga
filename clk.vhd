library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity clk_div is
    port ( clk_in : in     std_logic;
           clk_25 : inout  std_logic);
end clk_div;

architecture behavioral of clk_div is
signal   clkdiv  : std_logic_vector(1 downto 0) :="00";
constant killclk : std_logic_vector             :="01";

begin
   process(clk_in)
	begin
		if clk_in= '1' and clk_in'event then
	    	clkdiv <= clkdiv + 1;
		  	if(clkdiv = killclk) then 
            	clk_25 <= not clk_25;
             	clkdiv <= (others => '0');			 
		  	end if;
		end if;
	end process;
end behavioral;

