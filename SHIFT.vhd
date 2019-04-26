Library ieee;
Use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
Entity shift is port( 
      a : in std_logic_vector (15 downto 0);
      LorR : in std_logic;
      imm : in integer  range 0 to 65536;
      enable :in  std_logic;
      Cout :out std_logic;
      F : out std_logic_vector (15 downto 0)
    );
  end shift;
Architecture a_shift of shift is 
begin
process(LorR,imm,a)
variable  temp1,temp2:std_logic_vector (15 downto 0);
variable  templ,tempr:std_logic;
  begin 
    if(enable='1')
    then
    temp1:=a;
    temp2:=a;
 for i in 1 to imm loop
   templ:=temp1(15);
   tempr:=temp2(0);
temp1:=temp1(14 downto 0)&'0';
temp2:='0'&temp2(15 downto 1);
end loop;
 
if (LorR='0') then F<=temp1; Cout<=templ;
  else F<=temp2; Cout<=tempr;
 end if;
end if;
end process;
end a_shift;
