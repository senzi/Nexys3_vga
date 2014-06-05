library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity keyscan is
	port	(	clk_1k	:	in std_logic;
				key_in	:	in std_logic_vector(2 downto 0);
				key_num	:	inout std_logic_vector(3 downto 0)				
			);
end keyscan;

architecture behavioral of keyscan is

signal key1_flag,key2_flag,key3_flag	:	std_logic;
signal auto_add	:	std_logic;
begin
	process(clk_1k,key_in)
	variable timer	:	integer range 0 to 20;
	variable delay	:	integer range 0 to 14999;
	begin
		if clk_1k'event and clk_1k='1' then
			case key_in is 
				when "001" =>
					if timer=20 then	
						timer:=0;
						key1_flag<='1';		--下一个画面  的按键标志 
					else
						timer:=timer+1;
					end if;	
				when "010"=>
					if timer=20 then
						timer:=0;
						key2_flag<='1';		--上一个画面  的按键标志
					else
						timer:=timer+1;
					end if;
				when "100" =>
					if timer=20 then
						timer:=0;
						key3_flag<='1';  		--自动 下一个画面  的按键标志
					else
						timer:=timer+1;
					end if;
				when others=>null;
			if key1_flag='1' and key_in="000" then		
				key1_flag<='0';
				if auto_add='0' then
					if key_num<"1001" then
						key_num<=key_num+1;
					else
						key_num<="0000";
					end if;
				end if;
			end if;
			
			if key2_flag='1' and key_in="000" then
				key2_flag<='0';
				if auto_add='0' then
					if key_num>"0000" then
						key_num<=key_num-1;
					else
						key_num<="1001";
					end if;
				end if;
			end if;
			
			if key3_flag='1' and key_in="000" then
				key3_flag<='0';
				auto_add<=not auto_add;
			end if;
			
			if auto_add='1' then
				delay:=delay+1;
				if delay=14999 then
					if key_num<"1001" then
						key_num<=key_num+1;
					else
						key_num<="0000";
					end if;
					delay:=0;
				end if;
			else
				delay:=0;
			end if;
			
			end case;
		end if;
	end process;

end behavioral;
