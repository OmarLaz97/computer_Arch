library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC is
port(
PCwrite,clk: in std_logic;
PCinput: in std_logic_vector(31 downto 0);
PCPlusOne: out std_logic_vector(31 downto 0);
PCoutput: out std_logic_vector(31 downto 0)
);
end entity;



architecture PCModule of PC is
begin 

	process(clk)
		variable C: integer;
	begin
		if rising_edge(clk) then
			if PCwrite='1' then
				PCoutput<=PCinput;
				C:=to_integer(unsigned(PCinput));
				C:=C+1;
				PCPlusOne<=std_logic_vector(to_unsigned(C,32));
			end if;

		end if;


	end process;

end architecture;