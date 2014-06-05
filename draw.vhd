library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity draw is
	port	(	clk_25	:	in std_logic;				
				v_count	:	in std_logic_vector(9 downto 0);
				h_count :	in std_logic_vector(9 downto 0);
				rgb		:	out std_logic_vector(7 downto 0)
			);
end draw;

architecture behavioral of draw is

signal box_x         : std_logic_vector(9 downto 0) :="0010010000";--144
signal box_y         : std_logic_vector(9 downto 0) :="0000011100";-- 28
constant box_height  : std_logic_vector(6 downto 0) :="0100100";   -- 75
constant box_width   : std_logic_vector(6 downto 0) :="0100100";   -- 75

constant porchleft   : std_logic_vector(9 downto 0) :="0010010000";--144
constant porchtop    : std_logic_vector(9 downto 0) :="0000100100";-- 36
constant porchbottom : std_logic_vector(9 downto 0) :="0111110100";--516
constant porchright  : std_logic_vector(9 downto 0) :="1100010000";--784

signal flag_up     : std_logic := '0';
signal flag_left   : std_logic := '0';


begin
	process(clk_25)
	begin
		if clk_25'event and clk_25='1' then
			if    ((h_count >= box_x)     and (h_count < box_x+box_width )   and 
			       (v_count >= box_y)     and (v_count < box_y+box_height)) then
				rgb <= x"A5";
			elsif ((h_count >= porchleft) and (h_count < porchright )        and 
				   (v_count >= porchtop ) and (v_count < porchbottom))      then
				rgb <= x"ce";
			else rgb <= "00000000";
			end if;
			
			if(h_count = "0000000001" and v_count = "0000000001") then
				if(flag_left = '0') then
					box_x <= box_x + 1;								
					if(box_x + box_width = porchright - 1 ) then
						flag_left <= '1';
					end if;							
				else
					box_x <= box_x - 1;								
					if(box_x = porchleft) then
						flag_left <= '0';
						end if;
				end if;
				if(flag_up = '0') then 
					box_y <= box_y + 1;							
					if(box_y + box_height = porchbottom - 1) then
						flag_up <= '1';
					end if;
				else 
					box_y <= box_y - 1;
					if(box_y = porchtop) then
						flag_up <= '0';
					end if;
				end if;
			end if;
		end if;
	end process; 
end behavioral;
