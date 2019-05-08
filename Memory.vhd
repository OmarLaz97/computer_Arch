LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;


entity Memory is 
generic(n: integer :=20; m: integer:=16);
port(
clk: in std_logic;
We1,We2: in std_logic;
Re1,Re2: in std_logic;
Reset,Int: in std_logic;
address: in std_logic_vector(31 downto 0);
datain1,datain2: in std_logic_vector(m-1 downto 0);
dataout1,dataout2: out std_logic_vector(m-1 downto 0)
) ;
end entity Memory;


architecture MyMemory of Memory is

type Memory_type is array (0 to (2**n)-1) of std_logic_vector(m-1 downto 0);
signal Memory : Memory_type;
 
begin 
	process(clk,address,We1,We2) is
	begin 
		

		if Reset='0' and rising_edge(clk) then


			
				if We1='1' and We2='1'then 
				Memory(to_integer(unsigned(address(19 downto 0)))) <= datain1;

					if to_integer(unsigned(address(19 downto 0)))<=((2**n)-2) then
					Memory(to_integer(unsigned(address(19 downto 0))+1)) <= datain2;
					end if;

				elsif We1='1' and We2='0' then 
					Memory(to_integer(unsigned(address(19 downto 0)))) <= datain1;
				end if;
end if;

				
	end process;

dataout1<=Memory(to_integer(unsigned(address(19 downto 0)))) when Re1='1' and  Re2='1' and Reset='0' else
Memory(to_integer(unsigned(address(19 downto 0))))when Re1='1' and  Re2='0' and Reset='0'else
Memory(0) when Reset='1' else 
(others=> 'Z');
				
				
dataout2<=Memory(to_integer(unsigned(address(19 downto 0))+1)) when Re1='1' and  Re2='1' and Reset='0'else
(others=> 'Z');								

									
end architecture;