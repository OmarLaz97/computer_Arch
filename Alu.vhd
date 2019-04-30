
Library ieee;
Use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
Entity Alu is port( 
R1,R2 : in std_logic_vector (15 downto 0);
imm : in std_logic_vector (4 downto 0);
Cin: in std_logic;
S: in std_logic_vector (4 downto 0);
not1,inc1,dec1,add1,mul1,sub1,and1,or1,shl1,shr1 ,setc,clc: in std_logic;
Output : out std_logic_vector (15 downto 0);
Output2 : out std_logic_vector (15 downto 0);
N,Z,Cout : out std_logic);
end Alu;

architecture myimplementation of Alu  is
component Adder is port( 
      a,b : in std_logic_vector (15 downto 0);
      Cin,enable: in std_logic;
      F : out std_logic_vector (15 downto 0);
      Cout: out std_logic);
 END component;


  
  component shift is port( 
      a : in std_logic_vector (15 downto 0);
      LorR : in std_logic;
      imm :  integer  range 0 to 16;
      enable :in  std_logic;
      Cout :out std_logic;
      F : out std_logic_vector (15 downto 0)
    );
  end component;
  component LogicNot is port( 
      a : in std_logic_vector (15 downto 0);
      enable: in std_logic;
      F : out std_logic_vector (15 downto 0)
    );
     end component;
     component LogicAnd is port( 
      a,b : in std_logic_vector (15 downto 0);
      enable: in std_logic;
      F : out std_logic_vector (15 downto 0)
    );
  end component;
    component LogicOr is port( 
      a,b : in std_logic_vector (15 downto 0);
      enable: in std_logic;
      F : out std_logic_vector (15 downto 0)
    );
  end component;

component Multiplier is port( 
      a,b : in std_logic_vector (15 downto 0);
      enable: in std_logic;
      F1,F2 : out std_logic_vector (15 downto 0);
      Cout: out std_logic
    );
  end component;
 signal F1,F2,F3,F4,F5,F6,F7,F8,F10,F11,F12: std_logic_vector (15 downto 0);
 signal tempCout1,tempCout2,tempCout3,tempCout4:std_logic;
 signal tempCout5,tempCout8,tempCout9:std_logic;
 signal shifter : integer  range 0 to 65536;
 signal notr1:std_logic_vector (15 downto 0);
 signal notr2:std_logic_vector (15 downto 0);
begin 
  shifter<=to_integer(unsigned(imm));
  notr1<= not R1;
  notr2<= not R2;

 adder16 : adder  port map (R1, R2, Cin,add1,F1, tempCout1); 
 subtract : adder  port map (R1,notr2,'1',sub1,F3, tempCout3);
 Decr : adder port map (R1, x"FFFE"  ,'1',dec1, F4, tempCout4);  
 increment : adder  port map (R1, x"0001",'0',inc1, F5, tempCout5); 
 shiftleft : shift port map (R1,'0',shifter,shl1,tempCout8,F6);
 shiftright : shift port map (R1,'1',shifter,shr1,tempCout9,F7);
 R1andR2: LogicAnd port map (R1,R2,and1,F10);
 R1orR2: LogicOR port map (R1,R2,or1,F11);
 noR1: LogicNot port map (R1,not1,F12); 
Multipliy : Multiplier port map (R1,R2,mul1,F2,F8,tempCout2);

with S select
--add--
 Output<=F1 when "01001",
--sub--
 F3 when "01011",
--and-
F10  when "01100" ,
--or--
F11  when "01101" ,
--shift left--
F6  when "01110",
--shift right--
F7  when "01111",
--NOT--
F12  when "00011" ,
--increment--
F5  when "00100",
--decrement--
F4  when "00101",
--Multiply--
F8  when "01010",
R1 when others;

with S select
--add--
 N<=F1(15) when "01001",
--sub--
 F3(15) when "01011",
--and-
F10(15)  when "01100" ,
--or--
F11(15)  when "01101" ,
--shift left--
F6(15)  when "01110",
--shift right--
F7(15)  when "01111",
--NOT--
F12(15)  when "00011" ,
--increment--
F5(15)  when "00100",
--decrement--
F4(15)  when "00101",
--Multiply--
F2(15)  when "01010",
--SetC--
'0' when "00001",
--ClearC--
'0' when others;


--Cout--
with S select
--add--
 Cout<=tempCout1 when "01001",
--sub--
 not tempCout3 when "01011",
--and-
'0'  when "01100" ,
--or--
'0'  when "01101" ,
--shift left--
tempCout8  when "01110",
--shift right--
tempCout9  when "01111",
--NOT--
'0'  when "00011" ,
--increment--
tempCout5  when "00100",
--decrement--
not tempCout4  when "00101",
--Myltiply--
tempCout2 when "01010",
--SetC--
'1' when "00001",
--ClearC--
'0' when others;

Output2<=F2;
  
process(F1,F3,F4,F5,F6,F7,F10,F11,F12,F2,F8)
    begin
--Zero flag--
      --add--
  if (S="01001") then 
  if (F1=x"0000") then
    Z<='1'; else Z<='0';
  end if;
  
 --Sub--
  elsif (S="01011") then 
  if (F3=x"0000") then
    Z<='1'; else Z<='0';
  end if;
  
  
 --and-- 
elsif (S="01100") then 
  if (F10=x"0000") then
    Z<='1'; else Z<='0';
  end if;
  
 --or--  
  elsif (S="01101") then 
  if (F11=x"0000") then
    Z<='1'; else Z<='0';
  end if;

  --shift left--
   elsif (S="01110") then 
  if (F6=x"0000") then
   Z<='1'; else Z<='0';
  end if;
  
  --shift right--
  elsif (S="01111") then 
  if (F7=x"0000") then
  Z<='1'; else Z<='0';
  end if;
 
  --NOT--
  elsif (S="00011") then 
  if (F12=x"0000") then
    Z<='1'; else Z<='0';
  end if;

  --increment--
 elsif (S="00100") then 
  if (F5=x"0000") then
    Z<='1'; else Z<='0';
  end if;
  
  --decrement--
   elsif (S="00101") then 
  if (F4=x"0000") then
   Z<='1'; else Z<='0';
  end if;
 
  --Multiply--
  elsif (S="01010") then 
  if (F2=x"0000" and F8=x"0000") then
   Z<='1'; else Z<='0';
  end if;
 --SetC--
  elsif (S="00001") then Z<='0';

 --Multiply--
  elsif (S="00010") then Z<='0';


  end if;
  end process;
end architecture;
