Library ieee; 
Use ieee.std_logic_1164.all;

Entity Mem_Wb is 
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
 	one_op_out: out std_logic
     );
end Mem_Wb;

Architecture My_Mem_Wb of Mem_Wb is
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
  mem :my_DEnDFF generic map (n=>16)port map (Clk,regEn,resetSignal,Memout,Memout_mem);
  RSource :my_DEnDFF generic map (n=>3)port map (Clk,regEn,resetSignal,Rsource_in,Rsource_out);
  RDest :my_DEnDFF generic map (n=>3)port map (Clk,regEn,resetSignal,Rdest_in,Rdest_out);
  Multiply_Sig_U: DEbit_dff port map (Clk,regEn,resetSignal,Multiply_Sig,Multiply_Sig_Out);
  WB_DeMux_U: DEbit_dff port map (Clk,regEn,resetSignal,WB_DeMux,WB_DeMux_Out);
  WB_Mux_U: my_DEnDFF generic map (n=>2) port map (Clk,regEn,resetSignal,WB_Mux,WB_Mux_Out);
  WB_Sig_U: DEbit_dff port map (Clk,regEn,resetSignal,WB_Sig,WB_Sig_Out);
  Imm_Val_U: my_DEnDFF generic map (n=>16) port map (Clk,regEn,resetSignal,Imm_Val,Imm_Val_Out);
  INPort: my_DEnDFF generic map (n=>16) port map (Clk,regEn,resetSignal,INPORT_IN,INPORT_OUT);
oneop: DEbit_dff port map (Clk,regEn,resetSignal,one_op,one_op_out);
 
end My_Mem_Wb;
