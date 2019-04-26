Library ieee;
Use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

Entity Multiplier is port( 
      a,b : in std_logic_vector (15 downto 0);
      enable: in std_logic;
      F1,F2 : out std_logic_vector (15 downto 0);
      Cout: out std_logic
    );
  end Multiplier;
Architecture a_Multiplier of Multiplier is 
signal temp: std_logic_vector (32 downto 0);
begin
 process(enable,a,b)
 variable a1,b1,c1,c2 : integer;
  begin
if (enable='1')
  then
  a1:=to_integer(signed(a));
  b1:=to_integer(signed(b));
  temp <= std_logic_vector(to_signed(a1*b1,33));
end if;

end process;
  F1<=temp(31 downto 16);
  F2<=temp(15 downto 0);
  Cout<=temp(32);
end a_Multiplier;


