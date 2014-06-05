library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
	Port ( 
		   i_clk    :  in   STD_LOGIC;
         rgb      :  out  STD_LOGIC_VECTOR (7 downto 0);
         vs       :  out  STD_LOGIC;
         hs       :  out  STD_LOGIC);
end top;

architecture Behavioral of top is

component clk_div is
	port ( 
			clk_in   :  in     std_logic;
         clk_25   :  inout  std_logic);
end component;

component vga is
	port (
			clk_25	:	in  std_logic;
			vs	      :	out std_logic;
			hs	      :	out std_logic;
			vpixel	:	out std_logic_vector(9 downto 0);
			hpixel	:	out std_logic_vector(9 downto 0));
end component;

component draw is
	port	(
			 clk_25	:	in  std_logic;
			 v_count	:	in  std_logic_vector(9 downto 0);
			 h_count :	in  std_logic_vector(9 downto 0);
		    rgb		:	out std_logic_vector(7 downto 0)
			);
end component;

signal clk25      :  std_logic;
signal vcount     :  std_logic_vector( 9 downto 0);
signal hcount     :  std_logic_vector( 9 downto 0);
signal keynum     :  std_logic_vector( 3 downto 0);


begin
u1: clk_div   port map (clk_in=>i_clk,clk_25=>clk25);
u2: vga       port map (clk_25=>clk25,vs=>vs,hs=>hs,vpixel=>vcount,hpixel=>hcount);
u3: draw      port map (clk_25=>clk25,v_count=>vcount,h_count=>hcount,rgb=>rgb);

end Behavioral;

