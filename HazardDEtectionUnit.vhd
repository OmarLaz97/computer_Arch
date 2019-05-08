library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY HDU IS PORT (
Reset : in std_logic; --imp
OpCode : in std_logic_vector (4 downto 0); 
Mem_Read_ID_EX  :in std_logic; --to detect load use case--
Mem_Read_EX_MEM :in std_logic; --to stall in case of using memory
Mem_Write_1_EX_MEM :in std_logic; --to stall in case of using memory
Mem_Write_2_EX_MEM :in std_logic; --to stall in case of using memory
Rsrc,Rdst,RW1 :in std_logic_vector (2 downto 0);
Pc_W,IF_ID_W :out std_logic;
Stall:out std_logic);

END ENTITY HDU;


ARCHITECTURE a_HDU OF HDU IS
signal bool_sig: std_logic_vector(1 downto 0);
BEGIN
process(Reset,Mem_Read_ID_EX,Mem_Read_EX_MEM,Mem_Write_1_EX_MEM,Mem_Write_2_EX_MEM,Rsrc,Rdst,RW1)

begin
-- check load use case-
if Reset='1' then 
Pc_W <='1' ;
IF_ID_W <='1';
stall <= '0';
elsif Reset='0' then 

if Mem_Read_ID_EX ='1' then 
if RW1 = Rsrc or RW1=Rdst then
Pc_W <='0' ;
IF_ID_W <='0';
stall <= '1';
else 
Pc_W <='1' ;
IF_ID_W <='1';
stall <= '0';
end if;
end if;

if Mem_Read_EX_MEM ='1' or Mem_Write_1_EX_MEM='1' or Mem_Write_2_EX_MEM='1' then
Pc_W <='0' ;
IF_ID_W <='0';
stall <= '1';
else 
Pc_W <='1' ;
IF_ID_W <='1';
stall <= '0';
end if;
end if;

end process;


END a_HDU;

