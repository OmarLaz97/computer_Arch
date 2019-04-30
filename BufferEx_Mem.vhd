Library ieee; 
Use ieee.std_logic_1164.all;

Entity Ex_Mem is 
  	port(   Clk,resetSignal		: in std_logic; 
        	ALU1_in, ALU2_in 	: in std_logic_vector(15 downto 0);
		Rsource_in, Rdest_in 	: in std_logic_vector(2 downto 0);
        	Mux_MemAdressValue	: in std_logic_vector (1 downto 0);
        	Mem_Write1_1address	: in std_logic;
        	Mem_write2_2addresses   : in std_logic;
        	Mem_Read		: in std_logic;
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
	        PC_Pl_Out: out std_logic_vector(31 downto 0)

);
end Ex_Mem;

Architecture My_Ex_Mem of Ex_Mem is
component DEbit_dff is 
  port( Clk,En,Rst : in std_logic; 
        d : in std_logic; 
        q : out std_logic); 
end component;

component  my_DEnDFF is 
  Generic ( n : integer := 16); 
  port( Clk,En,Rst : in std_logic; 
        d : in std_logic_vector(n-1 downto 0); 
        q : out std_logic_vector(n-1 downto 0)); 
end component;
signal regEn : std_logic;
  begin 
  regEn <= '1';
  ALU1 :my_DEnDFF generic map (n=>16)port map (Clk,regEn,resetSignal,ALU1_in,ALU1_out);
  ALU2 :my_DEnDFF generic map (n=>16)port map (Clk,regEn,resetSignal,ALU2_in,ALU2_out);
  RSource :my_DEnDFF generic map (n=>3)port map (Clk,regEn,resetSignal,Rsource_in,Rsource_out);
  RDest :my_DEnDFF generic map (n=>3)port map (Clk,regEn,resetSignal,Rdest_in,Rdest_out);
  Mux_MemAdressValue_U: my_DEnDFF generic map (n=>2) port map (Clk,regEn,resetSignal,Mux_MemAdressValue,Mux_MemAdressValue_Out);
  Mem_Write1_1address_U: DEbit_dff port map (Clk,regEn,resetSignal,Mem_Write1_1address,Mem_Write1_1address_Out);
  Mem_write2_2addresses_U: DEbit_dff port map (Clk,regEn,resetSignal,Mem_write2_2addresses,Mem_write2_2addresses_Out);
  Mem_Read_U: DEbit_dff port map (Clk,regEn,resetSignal,Mem_Read,Mem_Read_Out);
  Mux_MemData_U: my_DEnDFF generic map (n=>2) port map (Clk,regEn,resetSignal,Mux_MemData,Mux_MemData_Out);
  Multiply_Sig_U: DEbit_dff port map (Clk,regEn,resetSignal,Multiply_Sig,Multiply_Sig_Out);
  WB_DeMux_U: DEbit_dff port map (Clk,regEn,resetSignal,WB_DeMux,WB_DeMux_Out);
  WB_Mux_U: my_DEnDFF generic map (n=>2) port map (Clk,regEn,resetSignal,WB_Mux,WB_Mux_Out);
  WB_Sig_U: DEbit_dff port map (Clk,regEn,resetSignal,WB_Sig,WB_Sig_Out);
  Imm_Val_U: my_DEnDFF generic map (n=>16) port map (Clk,regEn,resetSignal,Imm_Val,Imm_Val_Out);
  Eff_Addr_U: my_DEnDFF generic map (n=>20) port map (Clk,regEn,resetSignal,Eff_Addr,Eff_Addr_Out);
  Stack_Ptr_U: my_DEnDFF generic map (n=>32) port map (Clk,regEn,resetSignal,Stack_Ptr,Stack_Ptr_Out);
  PC_U: my_DEnDFF generic map (n=>32) port map (Clk,regEn,resetSignal,PC,PC_Out);
  PC_P1_U: my_DEnDFF generic map (n=>32) port map (Clk,regEn,resetSignal,PC_Pl,PC_Pl_Out);
 
end My_Ex_Mem;
