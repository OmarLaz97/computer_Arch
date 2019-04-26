Library ieee;
Use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

Entity Adder is port( 
      a,b : in std_logic_vector (15 downto 0);
      Cin,enable: in std_logic;
      F : out std_logic_vector (15 downto 0);
      Cout: out std_logic
    );
  end Adder;
Architecture a_adder of Adder is 
begin
 process(enable,a,b,Cin)
 variable c : std_logic_vector(16 downto 0);
  begin
    c(0):=Cin;
  if (enable='1')
  then
    For i IN 0 to 15 Loop
      F(i)<= a(i) Xor b(i) xor c(i);
      c(i+1) := (a(i) and b(i)) or (a(i) and c(i)) or (b(i) and c(i));
    end Loop;
    Cout<=c(16); 
end if;
end process;
end a_adder;



