LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY Mux2x1bit IS  
		PORT (SEl	:  IN  std_logic;
		      IN1,IN2	:  IN  std_logic;
  		      OUT1      :  OUT std_logic);    
END ENTITY Mux2x1bit;


ARCHITECTURE Data_flow OF Mux2x1bit IS
BEGIN
   out1 <= in1 when SEl = '0'
   else   in2; 
END Data_flow;

