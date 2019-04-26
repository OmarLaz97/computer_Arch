Library ieee; 
Use ieee.std_logic_1164.all;

Entity ID_EX is 
  	port(   
	Clk: in std_logic;
        resetSignal: in std_logic;

        Mux_PcP1_Call_Jump: in std_logic;
        Mux_Mux1_Mem: in std_logic;
        Mux_MemAdressValue: in std_logic_vector (1 downto 0);
        Mem_Write1_1address: in std_logic;
        Mem_write2_2addresses: in std_logic;
        Mem_Read: in std_logic;
        Mux_MemData: in std_logic_vector(1 downto 0);
        Reg_File_Read: in std_logic;
        Reg_File_Write: in std_logic;
        Multiply_Sig: in std_logic;
        Stack_Write: in std_logic;
        Mux_Stack: in std_logic_vector(1 downto 0);
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
        Eff_Addr: in std_logic_vector(31 downto 0);
        Stack_Ptr: in std_logic_vector(31 downto 0);

        Mux_PcP1_Call_Jump_Out: out std_logic;
        Mux_Mux1_Mem_Out: out std_logic;
        Mux_MemAdressValue_Out: out std_logic_vector (1 downto 0);
        Mem_Write1_1address_Out: out std_logic;
        Mem_write2_2addresses_Out: out std_logic;
        Mem_Read_Out: out std_logic;
        Mux_MemData_Out: out std_logic_vector(1 downto 0);
        Reg_File_Read_Out: out std_logic;
        Reg_File_Write_Out: out std_logic;
        Multiply_Sig_Out: out std_logic;
        Stack_Write_Out: out std_logic;
        Mux_Stack_Out: out std_logic_vector(1 downto 0);
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
        Eff_Addr_Out: out std_logic_vector(31 downto 0);
        Stack_Ptr_Out: out std_logic_vector(31 downto 0)
     );
end ID_EX;

Architecture My_ID_EX of ID_EX is
Component bit_dff is 
Port ( Clk,En,Rst : in std_logic; 
        d : in std_logic; 
        q : out std_logic
     ); 
End Component bit_dff;
component my_nDFF is 
  Generic ( n : integer := 16); 
  port( Clk,En,Rst : in std_logic; 
        d : in std_logic_vector(n-1 downto 0); 
        q : out std_logic_vector(n-1 downto 0)); 
end component;
signal regEn : std_logic;
  begin 
  regEn <= '1';
  Mux_PcP1_Call_Jump_U: bit_dff port map (Clk,regEn,resetSignal,Mux_PcP1_Call_Jump,Mux_PcP1_Call_Jump_Out);
    Mux_Mux1_Mem_U: bit_dff port map (Clk,regEn,resetSignal,Mux_Mux1_Mem,Mux_Mux1_Mem_Out);
    Mux_MemAdressValue_U: my_nDFF generic map (n=>2) port map (Clk,regEn,resetSignal,Mux_MemAdressValue,Mux_MemAdressValue_Out);
    Mem_Write1_1address_U: bit_dff port map (Clk,regEn,resetSignal,Mem_Write1_1address,Mem_Write1_1address_Out);
    Mem_write2_2addresses_U: bit_dff port map (Clk,regEn,resetSignal,Mem_write2_2addresses,Mem_write2_2addresses_Out);
    Mem_Read_U: bit_dff port map (Clk,regEn,resetSignal,Mem_Read,Mem_Read_Out);
    Mux_MemData_U: my_nDFF generic map (n=>2) port map (Clk,regEn,resetSignal,Mux_MemData,Mux_MemData_Out);
    Reg_File_Read_U: bit_dff port map (Clk,regEn,resetSignal,Reg_File_Read,Reg_File_Read_Out);
    Reg_File_Write_U: bit_dff port map (Clk,regEn,resetSignal,Reg_File_Write,Reg_File_Write_Out);
    Multiply_Sig_U: bit_dff port map (Clk,regEn,resetSignal,Multiply_Sig,Multiply_Sig_Out);
    Stack_Write_U: bit_dff port map (Clk,regEn,resetSignal,Stack_Write,Stack_Write_Out);
    Mux_Stack_U: my_nDFF generic map (n=>2) port map (Clk,regEn,resetSignal,Mux_Stack,Mux_Stack_Out);
    ALU_OP_U: my_nDFF generic map (n=>5) port map (Clk,regEn,resetSignal,ALU_OP,ALU_OP_Out);
    Flag_Write_U: bit_dff port map (Clk,regEn,resetSignal,Flag_Write,Flag_Write_Out);
    Jump_Signal_U: bit_dff port map (Clk,regEn,resetSignal,Jump_Signal,Jump_Signal_Out);
    Call_Sig_U: bit_dff port map (Clk,regEn,resetSignal,Call_Sig,Call_Sig_Out);
    WB_DeMux_U: bit_dff port map (Clk,regEn,resetSignal,WB_DeMux,WB_DeMux_Out);
    WB_Mux_U: my_nDFF generic map (n=>2) port map (Clk,regEn,resetSignal,WB_Mux,WB_Mux_Out);
    WB_Sig_U: bit_dff port map (Clk,regEn,resetSignal,WB_Sig,WB_Sig_Out);
    RSrc_U: my_nDFF generic map (n=>16) port map (Clk,regEn,resetSignal,RSrc,RSrc_Out);
    RDest_U: my_nDFF generic map (n=>16) port map (Clk,regEn,resetSignal,RDest,RDest_Out);
    RSrc_Address_U: my_nDFF generic map (n=>3) port map (Clk,regEn,resetSignal,RSrc_Address,RSrc_Address_Out);
    RDest_Address_U: my_nDFF generic map (n=>3) port map (Clk,regEn,resetSignal,RDest_Address,RDest_Address_Out);
    Imm_Val_U: my_nDFF generic map (n=>16) port map (Clk,regEn,resetSignal,Imm_Val,Imm_Val_Out);
    Eff_Addr_U: my_nDFF generic map (n=>32) port map (Clk,regEn,resetSignal,Eff_Addr,Eff_Addr_Out);
    Stack_Ptr_U: my_nDFF generic map (n=>32) port map (Clk,regEn,resetSignal,Stack_Ptr,Stack_Ptr_Out);
end My_ID_EX;
