library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FetchMemory is
port(
Clk,Reset,Int: in std_logic;
InPort: in std_logic_vector(15 downto 0);
OutPort: out std_logic_vector(15 downto 0);
dataout1,dataout2: inout std_logic_vector(15 downto 0)


);
end entity;


architecture FetchMemoryModule of FetchMemory is

COMPONENT Mux4x2 IS  
		Generic ( n : integer := 16); 
		PORT (SEl	:  IN  std_logic_vector (1 downto 0);
		      IN1,IN2, IN3, IN4	:  IN  std_logic_vector (n-1 downto 0);
  		      OUT1      :  OUT std_logic_vector (n-1 downto 0));    
END COMPONENT;

component Mux2x1 IS  Generic ( n : integer := 16); 
		PORT (SEl	:  IN  std_logic;
		      IN1,IN2	:  IN  std_logic_vector (n-1 downto 0);
  		      OUT1      :  OUT std_logic_vector (n-1 downto 0));    
END component Mux2x1;




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

component SP is port(
Clk,Rst,En: in std_logic;
SEL: in std_logic_vector(1 downto 0);
SP: out std_logic_vector(31 downto 0));
end component;

component Mux8x3 IS  
		Generic ( n : integer := 16); 
		PORT (SEl	:  IN  std_logic_vector (2 downto 0);
		      IN1, IN2, IN3, IN4, IN5, IN6, IN7, IN8:  IN  std_logic_vector (n-1 downto 0);
  		      OUT1:  OUT std_logic_vector (n-1 downto 0));    
END component;

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
 	Instr2: in std_logic_vector(15 downto 0);
        PC: in std_logic_vector(31 downto 0);
        PC_Pl: in std_logic_vector(31 downto 0);

        Instr_Out: out std_logic_vector(15 downto 0);
        Instr2_Out: out std_logic_vector(15 downto 0);
        PC_Out: out std_logic_vector(31 downto 0);
        PC_Pl_Out: out std_logic_vector(31 downto 0);
	INPORT_IN: in std_logic_vector(15 downto 0);
	INPORT_OUT: out std_logic_vector(15 downto 0)
     );
End component;


component CUnit is 
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
        Mem_Read2: out std_logic; 
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
        WB_Sig: out std_logic;
        one_op: out std_logic;
        IN_OP: out std_logic;
        LDM_OP: out std_logic ); 
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
		R_data2: out std_logic_vector (15 downto  0);
		on_op : in std_logic
);
end component;

component ID_EX is 
  	port(   
	Clk: in std_logic;
        resetSignal: in std_logic;

       
        Mux_MemAdressValue: in std_logic_vector (1 downto 0);
        Mem_Write1_1address: in std_logic;
        Mem_write2_2addresses: in std_logic;
        Mem_Read: in std_logic;
        Mem_Read2: in std_logic;
        Mux_MemData: in std_logic_vector(1 downto 0);
        Reg_File_Read: in std_logic;
        
        Multiply_Sig: in std_logic;
        ALU_OP: in std_logic_vector(4 downto 0);
        Flag_Write: in std_logic;
        Jump_Signal: in std_logic;
        Call_Sig: in std_logic;
        WB_DeMux: in std_logic;
        WB_Mux: in std_logic_vector(1 downto 0);
        WB_Sig: in std_logic;
        RSrc: in std_logic_vector(15 downto 0); 
        RDest: in std_logic_vector(15 downto 0);
        RSrc_Address: in std_logic_vector(2 downto 0);
        RDest_Address: in std_logic_vector(2 downto 0);
        Imm_Val: in std_logic_vector(15 downto 0);
        Eff_Addr: in std_logic_vector(19 downto 0);
        Stack_Ptr: in std_logic_vector(31 downto 0);

        
        Mux_MemAdressValue_Out: out std_logic_vector (1 downto 0);
        Mem_Write1_1address_Out: out std_logic;
        Mem_write2_2addresses_Out: out std_logic;
        Mem_Read_Out: out std_logic;
        Mem_Read2_Out: out std_logic;
        Mux_MemData_Out: out std_logic_vector(1 downto 0);
        Reg_File_Read_Out: out std_logic;
        Multiply_Sig_Out: out std_logic;
        ALU_OP_Out: out std_logic_vector(4 downto 0);
        Flag_Write_Out: out std_logic;
        Jump_Signal_Out: out std_logic;
        Call_Sig_Out: out std_logic;
        WB_DeMux_Out: out std_logic;
        WB_Mux_Out: out std_logic_vector(1 downto 0);
        WB_Sig_Out: out std_logic;
        RSrc_Out: out std_logic_vector(15 downto 0); 
        RDest_Out: out std_logic_vector(15 downto 0);
        RSrc_Address_Out: out std_logic_vector(2 downto 0);
        RDest_Address_Out: out std_logic_vector(2 downto 0);
        Imm_Val_Out: out std_logic_vector(15 downto 0);
        Eff_Addr_Out: out std_logic_vector(19 downto 0);
        Stack_Ptr_Out: out std_logic_vector(31 downto 0);
        PC: in std_logic_vector(31 downto 0);
        PC_Pl: in std_logic_vector(31 downto 0);
	PC_Out: out std_logic_vector(31 downto 0);
        PC_Pl_Out: out std_logic_vector(31 downto 0);
	Shift_Value : in std_logic_vector (4 downto 0);
	Shift_Value_out : out std_logic_Vector (4 downto 0);
	INPORT_IN: in std_logic_vector(15 downto 0);
	INPORT_OUT: out std_logic_vector(15 downto 0);
 	one_op:in std_logic;
 	one_op_out: out std_logic;
        	IN_OP: in std_logic;
		IN_OP_OUT: out std_logic;
        	LDM_OP: in std_logic;
        	LDM_OP_OUT: out std_logic
     );
end component;

component Mem_Wb is 
  	port(   Clk,resetSignal		: in std_logic; 
        	ALU1_in, ALU2_in,Memout : in std_logic_vector(15 downto 0);
		Rsource_in, Rdest_in 	: in std_logic_vector(2 downto 0);
        	Multiply_Sig		: in std_logic;
     	        WB_DeMux		: in std_logic;
     	        WB_Mux			: in std_logic_vector(1 downto 0);
        	WB_Sig			: in std_logic;
        	Imm_Val			: in std_logic_vector(15 downto 0);
       		Multiply_Sig_Out: out std_logic;
        	WB_DeMux_Out: out std_logic;
        	WB_Mux_Out: out std_logic_vector(1 downto 0);
        	WB_Sig_Out: out std_logic;
        	Imm_Val_Out: out std_logic_vector(15 downto 0);
		ALU1_out  : out std_logic_vector (15 downto 0);
		ALU2_out  : out std_logic_vector (15 downto 0);
		Rsource_out : out std_logic_vector (2 downto 0);
		Rdest_out : out std_logic_vector (2 downto 0);
		Memout_mem : out std_logic_vector(15 downto 0);
		INPORT_IN: in std_logic_vector(15 downto 0);
		INPORT_OUT: out std_logic_vector(15 downto 0);
 		one_op: in std_logic;
 		one_op_out: out std_logic;
        	IN_OP: in std_logic;
		IN_OP_OUT: out std_logic;
        	LDM_OP: in std_logic;
        	LDM_OP_OUT: out std_logic

);
end component;

component Ex_Mem is 
  	port(   Clk,resetSignal		: in std_logic; 
        	ALU1_in, ALU2_in 	: in std_logic_vector(15 downto 0);
		Rsource_in, Rdest_in 	: in std_logic_vector(2 downto 0);
        	Mux_MemAdressValue	: in std_logic_vector (1 downto 0);
        	Mem_Write1_1address	: in std_logic;
        	Mem_write2_2addresses   : in std_logic;
        	Mem_Read		: in std_logic;
        	Mem_Read2		: in std_logic;
        	Mux_MemData		: in std_logic_vector(1 downto 0);
        	Multiply_Sig		: in std_logic;
     	        WB_DeMux		: in std_logic;
     	        WB_Mux			: in std_logic_vector(1 downto 0);
        	WB_Sig			: in std_logic;
        	Imm_Val			: in std_logic_vector(15 downto 0);
       		Eff_Addr		: in std_logic_vector(19 downto 0);
        	Stack_Ptr		: in std_logic_vector(31 downto 0);
      		Mux_MemAdressValue_Out  : out std_logic_vector (1 downto 0);
       		Mem_Write1_1address_Out : out std_logic;
      		Mem_write2_2addresses_Out: out std_logic;
       		Mem_Read_Out		: out std_logic;
       		Mem_Read2_Out		: out std_logic;
     		Mux_MemData_Out		: out std_logic_vector(1 downto 0);
       		Multiply_Sig_Out: out std_logic;
        	WB_DeMux_Out: out std_logic;
        	WB_Mux_Out: out std_logic_vector(1 downto 0);
        	WB_Sig_Out: out std_logic;
        	Imm_Val_Out: out std_logic_vector(15 downto 0);
        	Eff_Addr_Out: out std_logic_vector(19 downto 0);
        	Stack_Ptr_Out: out std_logic_vector(31 downto 0);
		ALU1_out  : out std_logic_vector (15 downto 0);
		ALU2_out  : out std_logic_vector (15 downto 0);
		Rsource_out : out std_logic_vector (2 downto 0);
		Rdest_out : out std_logic_vector (2 downto 0);
                PC: in std_logic_vector(31 downto 0);
                PC_Pl: in std_logic_vector(31 downto 0);
	        PC_Out: out std_logic_vector(31 downto 0);
                PC_Pl_Out: out std_logic_vector(31 downto 0);
		INPORT_IN: in std_logic_vector(15 downto 0);
		INPORT_OUT: out std_logic_vector(15 downto 0);
 		one_op: in std_logic;
 		one_op_out: out std_logic;
        	IN_OP: in std_logic;
		IN_OP_OUT: out std_logic;
        	LDM_OP: in std_logic;
        	LDM_OP_OUT: out std_logic

);
end component;

component Wb_unit is 
  	port(   ALU1_in,  Mem_in, ImmVal 	: in std_logic_vector(15 downto 0);
		In_port					: in std_logic_vector (15 downto 0);
		Sel_1					: in std_logic;
		Sel_2					: in std_logic_vector (1 downto 0); 	
        	RWr1 				: out std_logic_vector(15 downto 0);
		Out1	 				: out std_logic_vector(15 downto 0));
end component;

component EXUnit is port( 
R1,R2: in std_logic_vector (15 downto 0);
imm : in std_logic_vector (4 downto 0);
S : in std_logic_vector (4 downto 0); 
Cin,Clk,enable,Rst : in std_logic;
Output : out std_logic_vector (15 downto 0);
Output2 : out std_logic_vector (15 downto 0);
N,Z,Cout : out std_logic
);

end component;

component HDU IS PORT (
Reset : in std_logic; --imp
OpCode : in std_logic_vector (4 downto 0); 
Mem_Read_ID_EX  :in std_logic; --to detect load use case--
Mem_Read_EX_MEM :in std_logic; --to stall in case of using memory
Mem_Write_1_EX_MEM :in std_logic; --to stall in case of using memory
Mem_Write_2_EX_MEM :in std_logic; --to stall in case of using memory
Rsrc,Rdst,RW1 :in std_logic_vector (2 downto 0);
Pc_W,IF_ID_W :out std_logic;
Stall:out std_logic);

END component;

component FU IS PORT (
Reset: in std_logic;
WB_EX_Mem_S: in std_logic;
WB_Mem_WB_S: in std_logic;
Mult_S1: in std_logic;
Mult_S2: in std_logic;
One_Op_EX_Mem: in std_logic;
One_Op_Mem_WB: in std_logic;
IN_EX_Mem_S: in std_logic;
IN_Mem_WB_S: in std_logic;
LDM_EX_Mem_S: in std_logic;
LDM_Mem_WB_S: in std_logic;
Mem_R_Mem_WB_S: in std_logic;
R_Src: in std_logic_vector(2 downto 0); 
R_Dst: in std_logic_vector(2 downto 0); 
R_Src_EX_Mem: in std_logic_vector(2 downto 0); 
R_Dst_EX_Mem: in std_logic_vector(2 downto 0); 
R_Src_Mem_WB: in std_logic_vector(2 downto 0); 
R_Dst_Mem_WB: in std_logic_vector(2 downto 0);
F01: out std_logic_vector(1 downto 0);
F02: out std_logic_vector(2 downto 0);
F11: out std_logic_vector(1 downto 0);
F12: out std_logic_vector(2 downto 0);
F0: out std_logic_vector(1 downto 0);
F1: out std_logic_vector(1 downto 0)

);
END component;

component  my_DEnDFF is 
  Generic ( n : integer := 16); 
  port( Clk,En,Rst : in std_logic; 
        d : in std_logic_vector(n-1 downto 0); 
        q : out std_logic_vector(n-1 downto 0)); 
end component;

component Mux2x1bit IS  
		PORT (SEl	:  IN  std_logic;
		      IN1,IN2	:  IN  std_logic;
  		      OUT1      :  OUT std_logic);    
END component;


signal Mux1Output: std_logic_vector(31 downto 0);
signal Mux2Output: std_logic_vector(15 downto 0);
signal Mux3Output: std_logic_vector(15 downto 0);
signal Memout: std_logic_vector(31 downto 0);
signal Instr_Out : std_logic_vector (15 downto 0);
signal Instr2_Out : std_logic_vector (15 downto 0);  
signal PC_Out,PC_Pl_Out : std_logic_vector(31 downto 0);

signal opCode: std_logic_vector(4 downto 0);

signal resetSignal :std_logic;
signal Mux_PcP1_Call_Jump:  std_logic;
signal Mux_Mux1_Mem: std_logic;
signal Mux_MemAdressValue: std_logic_vector (1 downto 0);
signal Mem_Write1_1address:  std_logic;
signal Mem_write2_2addresses:  std_logic;
signal Mem_Read: std_logic;
signal Mem_Read2: std_logic;
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



signal R_data1:  std_logic_vector(15 downto 0);
signal R_data2:  std_logic_vector (15 downto  0);

signal   Mux_MemAdressValue_Out:  std_logic_vector (1 downto 0);
signal   Mem_Write1_1address_Out:  std_logic;
signal   Mem_write2_2addresses_Out:  std_logic;
signal   Mem_Read_Out:  std_logic;
signal   Mux_MemData_Out: std_logic_vector(1 downto 0);
signal   Reg_File_Read_Out:  std_logic;
signal   Multiply_Sig_Out:  std_logic;
signal   Stack_Write_Out:  std_logic;
signal   Mux_Stack_Out:  std_logic_vector(1 downto 0);
signal   ALU_OP_Out:  std_logic_vector(4 downto 0);
signal   Flag_Write_Out:  std_logic;
signal   Jump_Signal_Out:  std_logic;
signal   Call_Sig_Out:  std_logic;
signal   WB_DeMux_Out:  std_logic;
signal   WB_Mux_Out:  std_logic_vector(1 downto 0);
signal   WB_Sig_Out:  std_logic;
signal   RSrc_Out:  std_logic_vector(15 downto 0); 
signal   RDest_Out:  std_logic_vector(15 downto 0);
signal   RSrc_Address_Out:  std_logic_vector(2 downto 0);
signal   RDest_Address_Out:  std_logic_vector(2 downto 0);
signal   Imm_Val_Out:  std_logic_vector(15 downto 0);
signal   Eff_Addr_Out:  std_logic_vector(19 downto 0);
signal   Stack_Ptr_Out:  std_logic_vector(31 downto 0);

signal   imm : std_logic_vector (15 downto 0);
--signal   SP :  std_logic_vector (31 downto 0);
signal   EA :std_logic_vector (19 downto 0);
signal EAIN:std_logic_vector (31 downto 0);
signal ImmShift : std_logic_vector (4 downto 0);

signal ALuOutput1,ALuOutput2 : std_logic_vector (15 downto 0);
signal N,Z,Cout : std_logic; 



signal Mux_MemAdressValue_Out_EXME:  std_logic_vector (1 downto 0);
signal Mem_Write1_1address_Out_EXME:  std_logic;
signal Mem_write2_2addresses_Out_EXME:  std_logic;
signal Mem_Read_Out_EXME:  std_logic;
signal Mux_MemData_Out_EXME:  std_logic_vector(1 downto 0);
signal Multiply_Sig_Out_EXME:  std_logic;
signal WB_DeMux_Out_EXME:  std_logic;
signal WB_Mux_Out_EXME:  std_logic_vector(1 downto 0);
signal WB_Sig_Out_EXME:  std_logic;
signal Imm_Val_Out_EXME:  std_logic_vector(15 downto 0);
signal Eff_Addr_Out_EXME:  std_logic_vector(19 downto 0);
signal Stack_Ptr_Out_EXME:  std_logic_vector(31 downto 0);
signal ALU1_out_EXME:  std_logic_vector (15 downto 0);
signal ALU2_out_EXME:  std_logic_vector (15 downto 0);
signal Rsource_out_EXME:  std_logic_vector (2 downto 0);
signal Rdest_out_EXME:  std_logic_vector (2 downto 0);
signal PC_DE:  std_logic_vector(31 downto 0);
signal PC_Pl_DE:  std_logic_vector(31 downto 0);
signal PC_Out_EXME:  std_logic_vector(31 downto 0);
signal PC_Pl_Out_EXME:  std_logic_vector(31 downto 0);
signal immShiftin : std_logic_vector (4 downto 0);
signal js,Mux1Selector :std_logic;
signal INPORTIN_IF_ID,INPORTOUT_IF_ID,INPORTOUT_ID_IE,INPORTOUT_IE_IM: std_logic_vector(15 downto 0);
signal Mem_read2_ID_EX,Mem_read2_EX_Mem :std_logic;
signal PCWrite :  std_logic;
signal fitch_decode_W :std_logic;
signal stall :std_logic;
signal stallout: std_logic;
signal id_EXRESET :std_logic;

signal SP_OUT :std_logic_vector(31 downto 0);
signal WB_DeMux_Out_mem:  std_logic;
signal WB_Mux_Out_mem:  std_logic_vector(1 downto 0);
signal Imm_Val_Out_mem:  std_logic_vector(15 downto 0);
signal ALU1_out_mem  :  std_logic_vector (15 downto 0);
signal Memout_memwbbuff :  std_logic_vector(15 downto 0);
signal INPORT_OUT_mem:  std_logic_vector(15 downto 0);
signal Out1:  std_logic_vector(15 downto 0);

signal W_reg1:  std_logic_vector (2 downto 0);
signal W_reg2:  std_logic_vector (2 downto 0);
signal W_data1: std_logic_vector (15 downto 0);
signal W_data2: std_logic_vector (15 downto 0);
signal MultSig: std_logic;
signal wbSig  : std_logic;
signal one_op : std_logic;
signal one_op_IDEX : std_logic;
signal one_op_EXMEM : std_logic;
signal one_op_MEMWB : std_logic;
signal FetchIn1:  std_logic_vector(31 downto 0);
signal RestInstr_Out : std_logic_vector (15 downto 0);
signal RestRegEn:  std_logic_vector(1 downto 0);
signal RestRegEn_out:  std_logic_vector(1 downto 0);

signal F01:  std_logic_vector(1 downto 0);
signal F02:  std_logic_vector(2 downto 0);
signal F11:  std_logic_vector(1 downto 0);
signal F12:  std_logic_vector(2 downto 0);
signal F0:   std_logic_vector(1 downto 0);
signal F1:   std_logic_vector(1 downto 0);

signal IN_OP:  std_logic;
signal IN_OP_OUT:  std_logic;
signal LDM_OP:  std_logic;
signal LDM_OP_OUT:  std_logic;
signal IN_EXMEM,IN_MEMWB,LDM_EXMEM,LDM_MEMWB :std_logic;
signal MUXF01OUT :std_logic_vector (15 downto 0);
signal MUXF11OUT :std_logic_vector (15 downto 0);
signal MUXF02OUT :std_logic_vector (15 downto 0);
signal MUXF12OUT :std_logic_vector (15 downto 0);
signal MUXF0OUT :std_logic_vector (15 downto 0);
signal MUXF1OUT :std_logic_vector (15 downto 0);
begin



Memout<=("0000000000000000" & dataout1 );
EAIN<=("000000000000"&Eff_Addr_Out_EXME);
FetchIn1<=("0000000000000000"&FetchIn1(15 downto 0));
Mux11:Mux4x2 GENERIC MAP(32) PORT MAP(Mux_MemAdressValue_Out_EXME,PCout,Stack_Ptr_Out_EXME,EAIN,(Others =>'0'),Mux1Output);
Mux22:Mux4x2 GENERIC MAP(16) PORT MAP(Mux_MemData_Out_EXME,ALU1_out_EXME,PC_Out_EXME(31 downto 16),PC_Pl_Out_EXME(31 downto 16),(Others =>'0'),Mux2Output);
Mux33:Mux4x2 GENERIC MAP(16) PORT MAP(Mux_MemData_Out_EXME,(Others =>'0'),PC_Out_EXME(15 downto 0),PC_Pl_Out_EXME(15 downto 0),(Others =>'0'),Mux3Output);

INPORTIN_IF_ID <= InPort;
Fetch1:Fetch PORT MAP(FetchIn1,Memout,PCWrite,Int,Clk,Reset,Mux1Selector,Mux_Mux1_Mem,PCout,PCPlusOne);
Memory1:Memory PORT MAP(Clk,Mem_Write1_1address_Out_EXME,Mem_write2_2addresses_Out_EXME,'1','1',Reset,Int,Mux1Output,Mux2Output,Mux3Output,dataout1,dataout2);
fetchdecode:IF_ID PORT MAP (Clk,Reset,fitch_decode_W,dataout1,dataout2,PCout,PCPlusOne,Instr_Out,Instr2_Out,PC_Out,PC_Pl_Out,INPORTIN_IF_ID,INPORTOUT_IF_ID);


--fetch done--

opCode <= Instr_Out(15 downto 11);
Rsrc1<= Instr_Out(10 downto 8);
Rsrc2<= Instr_Out(7 downto 5);
ImmShift<=Instr_Out (7 downto 3);
imm<=Instr2_Out when opCode = "10010" else
(others=>'0');

EA<=(Instr_Out(3 downto 0))&(Instr2_Out) when opCode = "10011"  or opCode ="10100" else
(others=>'0');


controlUnit:CUnit PORT MAP (Clk,opCode,Reset,resetSignal,Mux_PcP1_Call_Jump,Mux_Mux1_Mem,Mux_MemAdressValue,Mem_Write1_1address,Mem_write2_2addresses,Mem_Read,Mem_Read2,Mux_MemData,Reg_File_Read,Multiply_Sig,Stack_Write,Mux_Stack,ALU_OP,Flag_Write,Jump_Signal,Call_Sig,WB_DeMux,WB_Mux,WB_Sig,one_op,IN_OP,LDM_OP);


RegFile :Reg_file PORT MAP(Clk,Reset,Rsrc1,Rsrc2,W_reg2,W_reg1,W_data1,W_data2,MultSig,wbSig,R_data1,R_data2,one_op_MEMWB );
stackpointer : SP PORT MAP(Clk,Reset,Stack_Write,Mux_Stack,SP_OUT);
HazardDetectionUnit :HDU PORT MAP(Reset,opCode,Mem_Read_Out,Mem_Read_Out_EXME,Mem_Write1_1address_Out_EXME,Mem_write2_2addresses_Out_EXME,Rsrc1,Rsrc2,RSrc_Address_Out,PCWrite,fitch_decode_W,stall);

stalling: Mux2x1bit PORT MAP (stall,'0','1',stallout);---std_logic_vector
id_EXRESET <=Reset or stallout;
IDEXBUFF :  ID_EX PORT MAP(Clk,id_EXRESET,Mux_MemAdressValue,Mem_Write1_1address,Mem_write2_2addresses,Mem_Read,Mem_Read2,Mux_MemData,Reg_File_Read,Multiply_Sig,ALU_OP,Flag_Write,Jump_Signal,Call_Sig,WB_DeMux,WB_Mux,WB_Sig,R_data1,R_data2,Rsrc1,Rsrc2,imm,EA,SP_OUT,
Mux_MemAdressValue_Out,Mem_Write1_1address_Out,Mem_write2_2addresses_Out,Mem_Read_Out,Mem_read2_ID_EX, Mux_MemData_Out,Reg_File_Read_Out,Multiply_Sig_Out,ALU_OP_Out
,Flag_Write_Out,Jump_Signal_Out,Call_Sig_Out,WB_DeMux_Out,WB_Mux_Out,WB_Sig_Out,RSrc_Out,RDest_Out,RSrc_Address_Out,RDest_Address_Out,Imm_Val_Out,Eff_Addr_Out,Stack_Ptr_Out,
PC_Out,PC_Pl_Out,PC_DE,PC_Pl_DE,immShiftin,ImmShift,INPORTOUT_IF_ID,INPORTOUT_ID_IE,one_op,one_op_IDEX,IN_OP,IN_OP_OUT,LDM_OP,LDM_OP_OUT);


ExcuitUnit1: EXUnit PORT MAP (MUXF0OUT,MUXF1OUT,ImmShift,ALU_OP_Out,'0',Clk,Flag_Write_Out,Reset,ALuOutput1,ALuOutput2,N,Z,Cout);


forwardingunit :FU  PORT MAP (Reset,WB_Sig_Out_EXME,wbSig,Multiply_Sig_Out_EXME,MultSig,one_op_EXMEM,one_op_MEMWB,IN_EXMEM,IN_MEMWB,LDM_EXMEM,LDM_MEMWB,'0',RSrc_Address_Out,RDest_Address_Out,Rsource_out_EXME,Rdest_out_EXME,
W_reg1,W_reg2,F01,F02,F11,F12,F0,F1);

MUXF01:Mux4x2 GENERIC MAP(n=>16) PORT MAP(F01,ALU1_out_EXME,ALU2_out_EXME,INPORTOUT_IE_IM,Imm_Val_Out_EXME,MUXF01OUT);
MUXF11:Mux4x2 GENERIC MAP(n=>16) PORT MAP(F11,ALU1_out_EXME,ALU2_out_EXME,INPORTOUT_IE_IM,Imm_Val_Out_EXME,MUXF11OUT);
MUXF02:Mux8x3 GENERIC MAP(n=>16) PORT MAP(F02,ALU1_out_mem,W_data2,INPORT_OUT_mem,Memout_memwbbuff,Imm_Val_Out_EXME,(others => '0'),(others => '0'),(others => '0'),MUXF02OUT);
MUXF12:Mux8x3 GENERIC MAP(n=>16) PORT MAP(F12,ALU1_out_mem,W_data2,INPORT_OUT_mem,Memout_memwbbuff,Imm_Val_Out_EXME,(others => '0'),(others => '0'),(others => '0'),MUXF12OUT);
MUXF0:Mux4x2 GENERIC MAP(n=>16) PORT MAP(F0,RSrc_Out,MUXF01OUT,MUXF02OUT,(others =>'0'),MUXF0OUT);
MUXF1:Mux4x2 GENERIC MAP(n=>16) PORT MAP(F1,RDest_Out,MUXF11OUT,MUXF12OUT,(others =>'0'),MUXF1OUT);

with ALU_OP_Out select 
js<=(Jump_Signal_Out and Z) when "10101",
(Jump_Signal_Out and N) when "10110",
(Jump_Signal_Out and Cout) when "10111",
(Jump_Signal_Out and '1') when "11000",
'0' when others;

callorjump :Mux2x1  Generic map(n=>16) PORT MAP (js,R_data1,RSrc_Out,FetchIn1(15 downto 0));
		      
  		     

Mux1Selector<=(js or Call_Sig_Out);
ExcuitMemBuff :  Ex_Mem PORT MAP (Clk,Reset,ALuOutput1,ALuOutput2,RSrc_Address_Out,RDest_Address_Out,Mux_MemAdressValue_Out,Mem_Write1_1address_Out,Mem_write2_2addresses_Out,Mem_Read_Out,Mem_read2_ID_EX, Mux_MemData_Out,Multiply_Sig_Out,WB_DeMux_Out,WB_Mux_Out,WB_Sig_Out,Imm_Val_Out,Eff_Addr_Out,Stack_Ptr_Out,
Mux_MemAdressValue_Out_EXME,Mem_Write1_1address_Out_EXME,Mem_write2_2addresses_Out_EXME,Mem_Read_Out_EXME,Mem_read2_EX_Mem,Mux_MemData_Out_EXME,Multiply_Sig_Out_EXME,WB_DeMux_Out_EXME
,WB_Mux_Out_EXME,WB_Sig_Out_EXME,Imm_Val_Out_EXME,Eff_Addr_Out_EXME,Stack_Ptr_Out_EXME,ALU1_out_EXME,ALU2_out_EXME,Rsource_out_EXME,Rdest_out_EXME
,PC_DE,PC_Pl_DE,PC_Out_EXME,PC_Pl_Out_EXME,INPORTOUT_ID_IE,INPORTOUT_IE_IM,one_op_IDEX,one_op_EXMEM,IN_OP_OUT,IN_EXMEM,LDM_OP_OUT,LDM_EXMEM);


memwbbuffer :Mem_Wb  PORT MAP(Clk,Reset,ALU1_out_EXME,ALU2_out_EXME,dataout1,Rsource_out_EXME,Rdest_out_EXME,Multiply_Sig_Out_EXME
     	  ,WB_DeMux_Out_EXME,WB_Mux_Out_EXME,WB_Sig_Out_EXME
,Imm_Val_Out_EXME,MultSig,WB_DeMux_Out_mem,WB_Mux_Out_mem,wbSig,
Imm_Val_Out_mem,ALU1_out_mem,W_data2,W_reg1,W_reg2,Memout_memwbbuff ,INPORTOUT_IE_IM,INPORT_OUT_mem,one_op_EXMEM,one_op_MEMWB,IN_EXMEM,IN_MEMWB,LDM_EXMEM,LDM_MEMWB);


writeback: Wb_unit PORT MAP (ALU1_out_mem, Memout_memwbbuff,Imm_Val_Out_mem,INPORT_OUT_mem,WB_DeMux_Out_mem,WB_Mux_Out_mem
,W_data1,Out1);
OutPort <= Out1;
end architecture;