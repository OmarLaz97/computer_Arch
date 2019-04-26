LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY Mux4x2 IS  
		Generic ( n : integer := 16); 
		PORT (SEl	:  IN  std_logic_vector (1 downto 0);
		      IN1,IN2, IN3, IN4	:  IN  std_logic_vector (n-1 downto 0);
  		      OUT1      :  OUT std_logic_vector (n-1 downto 0));    
END ENTITY Mux4x2;


ARCHITECTURE Data_flow OF Mux4x2 IS
BEGIN
   out1 <= in1 when SEl = "00"
   else   in2 when Sel = "01"
   else in3 when SEl =  "10"
   else in4; 
END Data_flow;

