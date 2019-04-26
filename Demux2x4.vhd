LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY Mux2x4 IS  
		Generic ( n : integer := 16); 
		PORT (SEl			:  IN  std_logic_vector (1 downto 0);
		      IN1			:  IN  std_logic_vector (n-1 downto 0);
  		      OUT1, OUT2, OUT3, OUT4	:  OUT std_logic_vector (n-1 downto 0));    
END ENTITY Mux2x4;


ARCHITECTURE Data_flow OF Mux2x4 IS
BEGIN
   out1 <= in1 when SEl = "00"
   else   (others=>'0'); 

   out2 <= in1 when SEl = "01"
   else   (others=>'0'); 

   out3 <= in1 when SEl = "10"
   else   (others=>'0'); 

   out4 <= in1 when SEl = "11"
   else   (others=>'0'); 


END Data_flow;

