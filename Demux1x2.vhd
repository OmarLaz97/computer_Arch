LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY Demux2x1 IS  
		Generic ( n : integer := 16); 
		PORT (SEl		:  IN  std_logic;
		      IN1		:  IN  std_logic_vector (n-1 downto 0);
  		      OUT1, OUT2	:  OUT std_logic_vector (n-1 downto 0));    
END ENTITY Demux2x1;


ARCHITECTURE Data_flow OF Demux2x1 IS
BEGIN
   out1 <= in1 when SEl = '0'
   else   (others=>'0'); 

   out2 <= in1 when SEl = '1'
   else   (others=>'0'); 


END Data_flow;

