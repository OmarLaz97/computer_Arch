library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FetchMemory is
port(
W1,W2,R1,R2: in std_logic;
clk,Reset,Int: in std_logic;
Mux7,Mux8: in std_logic_vector(1 downto 0);
datain1,datain2: in std_logic_vector(15 downto 0);
SP,EA:in std_logic_vector(31 downto 0);
Rsrc:in std_logic_vector(15 downto 0);
dataout1,dataout2: inout std_logic_vector(15 downto 0);
PCWrite: in std_logic;
FetchIn1: in std_logic_vector(31 downto 0);
Mux1,Mux2: in std_logic;
PCout: inout std_logic_vector(31 downto 0);
PCPlusOne: inout std_logic_vector(31 downto 0)
);
end entity;


architecture FetchMemoryModule of FetchMemory is

COMPONENT Mux4x2 IS  
		Generic ( n : integer := 16); 
		PORT (SEl	:  IN  std_logic_vector (1 downto 0);
		      IN1,IN2, IN3, IN4	:  IN  std_logic_vector (n-1 downto 0);
  		      OUT1      :  OUT std_logic_vector (n-1 downto 0));    
END COMPONENT;



component Memory is 
generic(n: integer :=20; m: integer:=16);
port(
clk: in std_logic;
We1,We2: in std_logic;
Re1,Re2: in std_logic;
Reset,Int: in std_logic;
address: in std_logic_vector(31 downto 0);
datain1,datain2: in std_logic_vector(m-1 downto 0);
dataout1,dataout2: out std_logic_vector(m-1 downto 0)
) ;
end component Memory;

component Fetch is
port(
FetchIn1: in std_logic_vector(31 downto 0);
MemOut: in std_logic_vector(31 downto 0);
PCWrite: in std_logic;
int: in std_logic;
clk: in std_logic;
Reset: in std_logic;
Mux1,Mux2: in std_logic;
PCout: out std_logic_vector(31 downto 0);
PCPlusOne: inout std_logic_vector(31 downto 0)
);
end component;

signal Mux1Output: std_logic_vector(31 downto 0);
signal Mux2Output: std_logic_vector(15 downto 0);
signal Mux3Output: std_logic_vector(15 downto 0);
signal Memout: std_logic_vector(31 downto 0);

begin

Memout<=("0000000000000000" & dataout1 );

Mux11:Mux4x2 GENERIC MAP(32) PORT MAP(Mux8,PCout,SP,EA,(Others =>'0'),Mux1Output);
Mux22:Mux4x2 GENERIC MAP(16) PORT MAP(Mux7,Rsrc,PCout(31 downto 16),PCPlusOne(31 downto 16),(Others =>'0'),Mux2Output);
Mux33:Mux4x2 GENERIC MAP(16) PORT MAP(Mux7,(Others =>'0'),PCout(15 downto 0),PCPlusOne(15 downto 0),(Others =>'0'),Mux3Output);


Fetch1:Fetch PORT MAP(FetchIn1,Memout,PCWrite,Int,clk,Reset,Mux1,Mux2,PCout,PCPlusOne);


Memory1:Memory PORT MAP(clk,W1,W2,R1,R2,Reset,Int,Mux1Output,Mux2Output,Mux3Output,dataout1,dataout2);



end architecture;