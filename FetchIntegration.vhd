library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Fetch is
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
end entity;


architecture FetchModule of Fetch is

component PC is
port(
PCwrite,clk: in std_logic;
PCinput: in std_logic_vector(31 downto 0);
PCPlusOne: out std_logic_vector(31 downto 0);
PCoutput: out std_logic_vector(31 downto 0)
);
end component;


component Mux2x1 IS  
		Generic ( n : integer := 16); 
		PORT (SEl	:  IN  std_logic;
		      IN1,IN2	:  IN  std_logic_vector (n-1 downto 0);
  		      OUT1      :  OUT std_logic_vector (n-1 downto 0));    
END component Mux2x1;


signal InputToPC:std_logic_vector(31 downto 0);
signal FirstMux: std_logic_vector(31 downto 0);
signal SecondMux: std_logic_vector(31 downto 0);
signal SecondMuxSelector: std_logic;

begin

SecondMuxSelector<=Mux2 or int or Reset;

LeftMux:Mux2x1 GENERIC MAP(32) PORT MAP(Mux1,PCPlusOne,FetchIn1,FirstMux);

RightMux:Mux2x1 GENERIC MAP(32) PORT MAP(SecondMuxSelector,FirstMux,MemOut,InputToPC);

PCModule: PC PORT MAP(PCWrite,clk,InputToPC,PCPlusOne,PCout);





end architecture;
