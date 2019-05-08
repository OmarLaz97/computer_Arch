LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY FU IS PORT (
Reset: in std_logic;
WB_EX_Mem_S: in std_logic;
WB_Mem_WB_S: in std_logic;
Mult_S1: in std_logic;
Mult_S2: in std_logic;
One_Op_EX_Mem: in std_logic;
One_Op_Mem_WB: in std_logic;
R_Src: in std_logic_vector(2 downto 0); 
R_Dst: in std_logic_vector(2 downto 0); 
R_Src_EX_Mem: in std_logic_vector(2 downto 0); 
R_Dst_EX_Mem: in std_logic_vector(2 downto 0); 
R_Src_Mem_WB: in std_logic_vector(2 downto 0); 
R_Dst_Mem_WB: in std_logic_vector(2 downto 0);
F01: out std_logic;
F02: out std_logic;
F11: out std_logic;
F12: out std_logic;
F0: out std_logic_vector(1 downto 0);
F1: out std_logic_vector(1 downto 0)
);
END ENTITY FU;


ARCHITECTURE a_FU OF FU IS
BEGIN
process(Reset,WB_EX_Mem_S,WB_Mem_WB_S,Mult_S1,Mult_S2,One_Op_EX_Mem,One_Op_Mem_WB,R_Src,R_Dst,R_Src_EX_Mem,R_Dst_EX_Mem,R_Src_Mem_WB,R_Dst_Mem_WB)
Begin

if Reset = '1' then 
    F0 <= "00";
    F1 <= "00";
elsif Reset = '0' then 

if (WB_EX_Mem_S = '1' and Mult_S1 = '1' and One_Op_EX_Mem = '0') then 
if R_Src_EX_Mem = R_Src  then
    F0 <= "01";
    F01 <= '0';
elsif R_Dst_EX_Mem = R_Src then
    F0 <= "01";
    F01 <= '1';
End if;
if R_Src_EX_Mem = R_Dst  then
    F1 <= "01";
    F11 <= '0';
elsif R_Dst_EX_Mem = R_Dst then
    F1 <= "01";
    F11 <= '1';
End if;
End if;

if (WB_Mem_WB_S = '1' and Mult_S2 = '1' and One_Op_Mem_WB = '0') then 
if R_Src_Mem_WB = R_Src  then
    F0 <= "10";
    F02 <= '0';
elsif R_Dst_Mem_WB = R_Src then
    F0 <= "10";
    F02 <= '1';
End if;
if R_Src_Mem_WB = R_Dst  then
    F1 <= "10";
    F12 <= '0';
elsif R_Dst_Mem_WB = R_Dst then
    F1 <= "10";
    F12 <= '1';
End if;
End if;

if (WB_EX_Mem_S = '1' and One_Op_EX_Mem = '1' and Mult_S1 = '0') then 
if R_Src_EX_Mem = R_Src  then
    F0 <= "01";
    F01 <= '0';
End if;
if R_Src_EX_Mem = R_Dst  then
    F1 <= "01";
    F11 <= '0';
End if;
End if;

if (WB_Mem_WB_S = '1' and One_Op_Mem_WB = '1' and Mult_S2 = '0') then 
if R_Src_Mem_WB = R_Src  then
    F0 <= "10";
    F02 <= '0';
End if;
if R_Src_Mem_WB = R_Dst  then
    F1 <= "10";
    F12 <= '0';
End if;
End if;

if (WB_EX_Mem_S = '1' and Mult_S1 = '0' and One_Op_EX_Mem = '0') then 
if R_Dst_EX_Mem = R_Src  then
    F0 <= "01";
    F01 <= '1';
End if;
if R_Dst_EX_Mem = R_Dst  then
    F1 <= "01";
    F11 <= '1';
End if;
End if;

if (WB_Mem_WB_S = '1' and Mult_S2 = '0' and One_Op_Mem_WB = '0') then 
if R_Dst_Mem_WB = R_Src  then
    F0 <= "10";
    F02 <= '1';
End if;
if R_Dst_Mem_WB = R_Dst  then
    F1 <= "10";
    F12 <= '1';
End if;
End if;

End if;
End process;

END a_FU;


