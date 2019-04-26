
Library ieee;
Use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
Entity LogicOr is port( 
      a,b : in std_logic_vector (15 downto 0);
      enable: in std_logic;
      F : out std_logic_vector (15 downto 0)
    );
  end LogicOr;
Architecture a_LogicOr of LogicOr is 
begin
 process(enable)
    begin
if (enable='1')
  then
  F<=a or b;
end if;
end process;
end a_LogicOr;