LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY Mux8x3 IS  
		Generic ( n : integer := 16); 
		PORT (SEl	:  IN  std_logic_vector (2 downto 0);
		      IN1, IN2, IN3, IN4, IN5, IN6, IN7, IN8:  IN  std_logic_vector (n-1 downto 0);
  		      OUT1:  OUT std_logic_vector (n-1 downto 0));    
END ENTITY Mux8x3;


ARCHITECTURE Data_flow OF Mux8x3 IS
BEGIN
   out1 <= in1 when SEl = "000"
   else in2 when SEl = "001"
   else in3 when SEl = "010"
   else in4 when SEl = "011" 
   else in5 when SEl = "100"
   else in6 when SEl = "101"
   else in7 when SEl = "110"
   else in8; 
END Data_flow;

