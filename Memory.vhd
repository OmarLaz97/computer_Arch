library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


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
	process(clk) is
	begin 
		if Reset='1' then
			dataout1<=Memory(0);
		else 

		if clk'event and rising_edge(clk) then


			
				if We1='1' and We2='1'then 
				Memory(to_integer(unsigned(address(19 downto 0)))) <= datain1;

					if to_integer(unsigned(address(19 downto 0)))<=((2**n)-2) then
					Memory(to_integer(unsigned(address(19 downto 0))+1)) <= datain2;
					end if;

				elsif We1='1' and We2='0' then 
					Memory(to_integer(unsigned(address(19 downto 0)))) <= datain1;
				end if;

				if Re1='1' and Re2='1' then 
				dataout1<=Memory(to_integer(unsigned(address(19 downto 0))));
				
					if to_integer(unsigned(address))<=((2**n)-2) then
					dataout2<=Memory(to_integer(unsigned(address(19 downto 0))+1));
					end if;

				elsif Re1='1' and Re2='0' then 
					dataout1<=Memory(to_integer(unsigned(address(19 downto 0))));

				end if;				

			end if;
		end if;
	end process;
end architecture;