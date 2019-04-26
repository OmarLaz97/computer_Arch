Library ieee;
Use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
Entity ALUUnit is port( 
R1,R2,imm : in std_logic_vector (15 downto 0);
S : in std_logic_vector (4 downto 0); 
Cin,Clk : in std_logic;
Output : out std_logic_vector (15 downto 0);
Output2 : out std_logic_vector (15 downto 0);
N,Z,Cout : out std_logic
);
end ALUUnit;
Architecture a_ALUUnit of ALUUnit is 


component AluCu is port( 
Clk : in std_logic;
S : in std_logic_vector (4 downto 0); 
not1,inc1,dec1,add1,mul1,sub1,and1,or1,shl1,shr1,setc,clc : out std_logic);
end component;


component Alu is port( 
R1,R2 : in std_logic_vector (15 downto 0);
imm : in std_logic_vector (15 downto 0);
Cin: in std_logic;
S: in std_logic_vector (4 downto 0);
not1,inc1,dec1,add1,mul1,sub1,and1,or1,shl1,shr1,setc,clc : in std_logic;
Output : out std_logic_vector (15 downto 0);
Output2 : out std_logic_vector (15 downto 0);
N,Z,Cout : out std_logic);
end component;

signal not1,inc1,dec1,add1,mul1,sub1,and1,or1,shl1,shr1,setc,clc : std_logic ;

begin
controlunit :AluCu port map (Clk,S,not1,inc1,dec1,add1,mul1,sub1,and1,or1,shl1,shr1,setc,clc);
ALUunit: Alu port map(R1,R2,imm,Cin,S,not1,inc1,dec1,add1,mul1,sub1,and1,or1,shl1,shr1,setc,clc,Output,Output2,N,Z,Cout); 
 

end architecture;


