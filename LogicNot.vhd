Library ieee;
Use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
Entity LogicNot is port( 
      a : in std_logic_vector (15 downto 0);
      enable: in std_logic;
      F : out std_logic_vector (15 downto 0)
    );
  end LogicNot;
Architecture a_LogicNot of LogicNot is 
begin
  process(enable)
    begin
if (enable='1')
  then
  F<= not a;
end if;
end process;
end a_LogicNot;
