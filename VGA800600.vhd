library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity vga is
	port(	clk_25	:	in  std_logic;
			vs	    :	out std_logic;
			hs	    :	out std_logic;
			vpixel	:	out std_logic_vector(9 downto 0);
			hpixel	:	out std_logic_vector(9 downto 0));
end vga;

architecture behavioral of vga is

constant hpixel_temp  : std_logic_vector(9 downto 0) :="1100100000";
constant vpixel_temp  : std_logic_vector(9 downto 0) :="1000001001";

constant hspluse_wide :	std_logic_vector(9 downto 0) :="0001100000";
constant vspluse_wide :	std_logic_vector(2 downto 0) :="010";

signal synch : std_logic := '0'; 
signal syncv : std_logic := '0'; 

signal h_count	: std_logic_vector(9 downto 0);
signal v_count	: std_logic_vector(9 downto 0);

begin
	process(clk_25)
	begin
		if clk_25'event and clk_25='1' then
			if h_count=hpixel_temp-1 then	
				synch<='1';
				h_count<="0000000000";
				v_count<=v_count+1;
			else
				h_count<=h_count+1;
			end if;
			
			if v_count=vpixel_temp-1 then
				syncv<='1';
				v_count<="0000000000";
			end if;
			
			if synch='1' then
				if h_count+1=hspluse_wide then
					synch<='0';
				end if;
			end if;
			
			if syncv='1' then
				if v_count=vspluse_wide then
					syncv<='0';
				end if;
			end if;
		end if;
	end process;
	
		vs<=syncv;
		hs<=synch;
		vpixel<=v_count;
		hpixel<=h_count;
		
end behavioral;
