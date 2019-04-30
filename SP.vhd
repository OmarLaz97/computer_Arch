Library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


Entity SP is port(
Clk,Rst,En: in std_logic;
SEL: in std_logic_vector(1 downto 0);
SP: out std_logic_vector(31 downto 0));
end SP;

Architecture a_SP of SP is

component SP_ndff is 
  Generic ( n : integer := 32); 
  port( Clk,En,Rst : in std_logic; 
        d : in std_logic_vector(n-1 downto 0); 
        q : out std_logic_vector(n-1 downto 0)); 
end component;

component Mux4x2 IS  
		Generic ( n : integer := 16); 
		PORT (SEl	:  IN  std_logic_vector (1 downto 0);
		      IN1,IN2, IN3, IN4	:  IN  std_logic_vector (n-1 downto 0);
  		      OUT1      :  OUT std_logic_vector (n-1 downto 0));    
END component;

component Mux2x1 IS  
		Generic ( n : integer := 16); 
		PORT (SEl	:  IN  std_logic;
		      IN1,IN2	:  IN  std_logic_vector (n-1 downto 0);
  		      OUT1      :  OUT std_logic_vector (n-1 downto 0));    
END component;

signal SP_ALU,SP_bff: std_logic_vector(31 downto 0);
signal op :std_logic_vector(31 downto 0);
begin 

SP_buffer: SP_ndff generic map(n => 32) port map(Clk,En,Rst,SP_ALU,SP_bff);
out_MUX: Mux2x1 generic map(n => 32) port map(SEL(1),SP_bff,SP_ALU,SP);
with SEL select
op<= std_logic_vector(to_signed(-1,32)) when "00",
std_logic_vector(to_signed(-2,32)) when "01",
std_logic_vector(to_signed(1,32)) when "10",
std_logic_vector(to_signed(2,32)) when others;



SP_ALU<=std_logic_vector(to_signed(((to_integer(signed(op)))+(to_integer(signed(SP_bff)))),32));


 
end Architecture;