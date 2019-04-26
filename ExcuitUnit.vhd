Library ieee;
Use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
Entity EXUnit is port( 
R1,R2,imm : in std_logic_vector (15 downto 0);
S : in std_logic_vector (4 downto 0); 
Cin,Clk,enable,Rst : in std_logic;
Output : out std_logic_vector (15 downto 0);
Output2 : out std_logic_vector (15 downto 0);
N,Z,Cout : out std_logic_vector(0 downto 0)
);
end EXUnit;
Architecture a_EXUnit of EXUnit is
component ALUUnit is port( 
R1,R2,imm : in std_logic_vector (15 downto 0);
S : in std_logic_vector (4 downto 0); 
Cin,Clk : in std_logic;
Output : out std_logic_vector (15 downto 0);
Output2 : out std_logic_vector (15 downto 0);
N,Z,Cout : out std_logic
);
end component;
component my_FR is 
  port( Clk,En,Rst : in std_logic; 
        Z,C,N : in std_logic_vector(0 downto 0);
        ZF,Nf,CF : out std_logic_vector(0 downto 0)); 
end component;

signal nflag,zflag,cflag : std_logic_vector (0 downto 0);
begin
alufunctionalunit :ALUUnit port map (R1,R2,imm,S,Cin,Clk,Output,Output2,nflag(0),zflag(0),cflag(0));
flags :my_FR port map (Clk,enable,Rst,zflag,cflag,nflag,Z,N,Cout);
 
end architecture;