LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY Mux2x1 IS  
		Generic ( n : integer := 16); 
		PORT (SEl	:  IN  std_logic;
		      IN1,IN2	:  IN  std_logic_vector (n-1 downto 0);
  		      OUT1      :  OUT std_logic_vector (n-1 downto 0));    
END ENTITY Mux2x1;


ARCHITECTURE Data_flow OF Mux2x1 IS
BEGIN
   out1 <= in1 when SEl = '0'
   else   in2; 
END Data_flow;

