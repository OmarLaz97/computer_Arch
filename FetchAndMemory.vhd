library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FetchMemory is
port(
R2: in std_logic;
Clk,Reset,Int: in std_logic;
datain1,datain2: in std_logic_vector(15 downto 0);
SP,EA:in std_logic_vector(31 downto 0);
Rsrc:in std_logic_vector(15 downto 0);
dataout1,dataout2: inout std_logic_vector(15 downto 0);
PCWrite: in std_logic;
FetchIn1: in std_logic_vector(31 downto 0);
Mux1: in std_logic;
W_reg1:in  std_logic_vector (2 downto 0);
W_reg2:in  std_logic_vector (2 downto 0);
W_data1:in std_logic_vector (15 downto 0);
W_data2:in std_logic_vector (15 downto 0)

);
end entity;


architecture FetchMemoryModule of FetchMemory is

COMPONENT Mux4x2 IS  
		Generic ( n : integer := 16); 
		PORT (SEl	:  IN  std_logic_vector (1 downto 0);
		      IN1,IN2, IN3, IN4	:  IN  std_logic_vector (n-1 downto 0);
  		      OUT1      :  OUT std_logic_vector (n-1 downto 0));    
END COMPONENT;



component Memory is 
generic(n: integer :=20; m: integer:=16);
port(
clk: in std_logic;
We1,We2: in std_logic;
Re1,Re2: in std_logic;
Reset,Int: in std_logic;
address: in std_logic_vector(31 downto 0);
datain1,datain2: in std_logic_vector(m-1 downto 0);
dataout1,dataout2: out std_logic_vector(m-1 downto 0)
) ;
end component Memory;

component Fetch is
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
end component;

component IF_ID is 
Port (
        Clk: in std_logic;
        resetSignal: in std_logic;
	regEn: in std_logic; 
        Instr: in std_logic_vector(15 downto 0);
        PC: in std_logic_vector(31 downto 0);
        PC_Pl: in std_logic_vector(31 downto 0);

        Instr_Out: out std_logic_vector(15 downto 0);
        PC_Out: out std_logic_vector(31 downto 0);
        PC_Pl_Out: out std_logic_vector(31 downto 0)
     );
End component;


component CU is 
  port(  

        clk: in std_logic;
        opCode : in std_logic_vector(4 downto 0); 
	resetSignalin : in std_logic;
        resetSignal : out std_logic;
        Mux_PcP1_Call_Jump: out std_logic;
        Mux_Mux1_Mem: out std_logic;
        Mux_MemAdressValue: out std_logic_vector (1 downto 0);
        Mem_Write1_1address: out std_logic;
        Mem_write2_2addresses: out std_logic;
        Mem_Read: out std_logic;
        Mux_MemData: out std_logic_vector(1 downto 0);
        Reg_File_Read: out std_logic;
        Multiply_Sig: out std_logic;
        Stack_Write: out std_logic;
        Mux_Stack: out std_logic_vector(1 downto 0);
        ALU_OP: out std_logic_vector(4 downto 0);
        Flag_Write: out std_logic;
        Jump_Signal: out std_logic;
        Call_Sig: out std_logic;
        WB_DeMux: out std_logic;
        WB_Mux: out std_logic_vector(1 downto 0);
        WB_Sig: out std_logic); 
End component;

component Reg_file is
	port(
		Clk, Rst: in std_logic;
		R_src: in std_logic_vector (2 downto 0);
		R_dst: in  std_logic_vector (2 downto 0);
		W_reg1: in std_logic_vector (2 downto 0);
		W_reg2: in std_logic_vector (2 downto 0);
		W_data1:in std_logic_vector (15 downto 0);
		W_data2:in std_logic_vector (15 downto 0);
		MultSig: in std_logic;
		wbSig: in std_logic;
		R_data1: out std_logic_vector(15 downto 0);
		R_data2: out std_logic_vector (15 downto  0));
end component;


signal Mux1Output: std_logic_vector(31 downto 0);
signal Mux2Output: std_logic_vector(15 downto 0);
signal Mux3Output: std_logic_vector(15 downto 0);
signal Memout: std_logic_vector(31 downto 0);
signal Instr_Out : std_logic_vector (15 downto 0); 
signal PC_Out,PC_Pl_Out : std_logic_vector(31 downto 0);

signal opCode: std_logic_vector(4 downto 0);

signal resetSignal :std_logic;
signal Mux_PcP1_Call_Jump:  std_logic;
signal Mux_Mux1_Mem: std_logic;
signal Mux_MemAdressValue: std_logic_vector (1 downto 0);
signal Mem_Write1_1address:  std_logic;
signal Mem_write2_2addresses:  std_logic;
signal Mem_Read: std_logic;
signal Mux_MemData:  std_logic_vector(1 downto 0);
signal Reg_File_Read:  std_logic;
signal Multiply_Sig:  std_logic;
signal Stack_Write:  std_logic;
signal Mux_Stack:  std_logic_vector(1 downto 0);
signal ALU_OP:  std_logic_vector(4 downto 0);
signal Flag_Write:  std_logic;
signal Jump_Signal:  std_logic;
signal Call_Sig:  std_logic;
signal WB_DeMux:  std_logic;
signal WB_Mux: std_logic_vector(1 downto 0);
signal WB_Sig:  std_logic; 

signal PCout: std_logic_vector(31 downto 0);
signal PCPlusOne: std_logic_vector(31 downto 0);

signal Rsrc1,Rsrc2 : std_logic_vector (2 downto 0);


signal MultSig:  std_logic;
signal wbSig:  std_logic;
signal R_data1:  std_logic_vector(15 downto 0);
signal R_data2:  std_logic_vector (15 downto  0);
begin



Memout<=("0000000000000000" & dataout1 );

Mux11:Mux4x2 GENERIC MAP(32) PORT MAP(Mux_MemAdressValue,PCout,SP,EA,(Others =>'0'),Mux1Output);
Mux22:Mux4x2 GENERIC MAP(16) PORT MAP(Mux_MemData,Rsrc,PCout(31 downto 16),PCPlusOne(31 downto 16),(Others =>'0'),Mux2Output);
Mux33:Mux4x2 GENERIC MAP(16) PORT MAP(Mux_MemData,(Others =>'0'),PCout(15 downto 0),PCPlusOne(15 downto 0),(Others =>'0'),Mux3Output);


Fetch1:Fetch PORT MAP(FetchIn1,Memout,PCWrite,Int,Clk,Reset,Mux1,Mux_Mux1_Mem,PCout,PCPlusOne);
Memory1:Memory PORT MAP(Clk,Mem_Write1_1address,Mem_write2_2addresses,Mem_Read,R2,Reset,Int,Mux1Output,Mux2Output,Mux3Output,dataout1,dataout2);
fetchdecode:IF_ID PORT MAP (Clk,Reset,'1',dataout1,PCout,PCPlusOne,Instr_Out,PC_Out,PC_Pl_Out);

opCode <= Instr_Out(15 downto 11);
Rsrc1<= Instr_Out(10 downto 8);
Rsrc2<= Instr_Out(7 downto 5);
controlUnit:CU PORT MAP (Clk,opCode,Reset,resetSignal,Mux_PcP1_Call_Jump,Mux_Mux1_Mem,Mux_MemAdressValue,Mem_Write1_1address,Mem_write2_2addresses,Mem_Read,Mux_MemData,Reg_File_Read,Multiply_Sig,Stack_Write,Mux_Stack,ALU_OP,Flag_Write,Jump_Signal,Call_Sig,WB_DeMux,WB_Mux,WB_Sig);
RegFile :Reg_file PORT MAP(Clk,Reset,Rsrc1,Rsrc2,W_reg1,W_reg2,W_data1,W_data2,MultSig,wbSig,R_data1,R_data2 );
end architecture;