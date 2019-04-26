

Library ieee;
Use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
Entity LogicAnd is port( 
      a,b : in std_logic_vector (15 downto 0);
      enable: in std_logic;
      F : out std_logic_vector (15 downto 0)
    );
  end LogicAnd;
Architecture a_LogicAnd of LogicAnd is 
begin
  process(enable)
    begin
if (enable='1')
  then
  F<=a and b;
end if;
end process;
end a_LogicAnd;


