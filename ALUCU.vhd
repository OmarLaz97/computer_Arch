
Library ieee; 
Use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity AluCu is port( 
Clk : in std_logic;
S : in std_logic_vector (4 downto 0); 
not1,inc1,dec1,add1,mul1,sub1,and1,or1,shl1,shr1,setc,clc : out std_logic);
end AluCu;
architecture a_AluCu of AluCu  is



begin 
 process(Clk,S)
  begin
--add--
if    (S(4 downto 0)="01001") then 
not1<='0';inc1<='0';dec1<='0';add1<='1';mul1<='0';
sub1<='0';and1<='0';or1<='0';shl1<='0';shr1<='0'; 
setc<='0';clc<='0';
--sub--
elsif (S(4 downto 0)="01011") then 
not1<='0';inc1<='0';dec1<='0';add1<='0';mul1<='0';
sub1<='1';and1<='0';or1<='0';shl1<='0';shr1<='0'; 
setc<='0';clc<='0';
--and-
elsif (S(4 downto 0)="01100") then 
not1<='0';inc1<='0';dec1<='0';add1<='0';mul1<='0';
sub1<='0';and1<='1';or1<='0';shl1<='0';shr1<='0'; 
setc<='0';clc<='0'; 
--or--
elsif (S(4 downto 0)="01101") then 
not1<='0';inc1<='0';dec1<='0';add1<='0';mul1<='0';
sub1<='0';and1<='0';or1<='1';shl1<='0';shr1<='0';  
setc<='0';clc<='0';
--shift left--
elsif (S(4 downto 0)="01110") then 
not1<='0';inc1<='0';dec1<='0';add1<='0';mul1<='0';
sub1<='0';and1<='0';or1<='0';shl1<='1';shr1<='0'; 
setc<='0';clc<='0'; 
--shift right--
elsif (S(4 downto 0)="01111") then 
not1<='0';inc1<='0';dec1<='0';add1<='0';mul1<='0';
sub1<='0';and1<='0';or1<='0';shl1<='0';shr1<='1'; 
setc<='0';clc<='0';
--NOT--
elsif (S(4 downto 0)="00011") then 
not1<='1';inc1<='0';dec1<='0';add1<='0';mul1<='0';
sub1<='0';and1<='0';or1<='0';shl1<='0';shr1<='0'; 
setc<='0';clc<='0';
--increment--
elsif (S(4 downto 0)="00100") then 
not1<='0';inc1<='1';dec1<='0';add1<='0';mul1<='0';
sub1<='0';and1<='0';or1<='0';shl1<='0';shr1<='0';  
setc<='0';clc<='0';
--decrement--
elsif (S(4 downto 0)="00101") then 
not1<='0';inc1<='0';dec1<='1';add1<='0';mul1<='0';
sub1<='0';and1<='0';or1<='0';shl1<='0';shr1<='0'; 
setc<='0';clc<='0';
--Multiply--
elsif (S(4 downto 0)="01010") then 
not1<='0';inc1<='0';dec1<='0';add1<='0';mul1<='1';
sub1<='0';and1<='0';or1<='0';shl1<='0';shr1<='0'; 
setc<='0';clc<='0';
--SetC--
elsif (S(4 downto 0)="00001") then
not1<='0';inc1<='0';dec1<='0';add1<='0';mul1<='0';
sub1<='0';and1<='0';or1<='0';shl1<='0';shr1<='0';
setc<='1';clc<='0'; 
--ClearC--
elsif (S(4 downto 0)="00010") then
not1<='0';inc1<='0';dec1<='0';add1<='0';mul1<='0';
sub1<='0';and1<='0';or1<='0';shl1<='0';shr1<='0';
setc<='0';clc<='1'; 

else 
not1<='0';inc1<='0';dec1<='0';add1<='0';mul1<='0';
sub1<='0';and1<='0';or1<='0';shl1<='0';shr1<='0';
setc<='0';clc<='0'; 
end if;
end process ;
end architecture;



