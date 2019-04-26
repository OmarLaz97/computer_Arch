Library ieee; 
Use ieee.std_logic_1164.all;

Entity MEM_WB is 
  	port(   
	Clk: in std_logic;
        resetSignal: in std_logic;

        Mul_S1: in std_logic;
        WB_S: in std_logic;
        WB_DeMux: in std_logic;
        WB_Mux: in std_logic_vector(1 downto 0);
        RW1: in std_logic_vector(2 downto 0);
        RW2: in std_logic_vector(2 downto 0);
        ALU1: in std_logic_vector(15 downto 0); 
        ALU2: in std_logic_vector(15 downto 0); 
        Mem: in std_logic_vector(15 downto 0);
        Imm_Val: in std_logic_vector(15 downto 0);
        IN_Port: in std_logic_vector(15 downto 0);
        
        Mul_S2: out std_logic;
        WB_S_Out: out std_logic;
        WB_DeMux_Out: out std_logic;
        WB_Mux_Out: out std_logic_vector(1 downto 0);
        RW1_Out: out std_logic_vector(2 downto 0);
        RW2_Out: out std_logic_vector(2 downto 0);
        ALU1_Out: out std_logic_vector(15 downto 0); 
        ALU2_Out: out std_logic_vector(15 downto 0); 
        Mem_Out: out std_logic_vector(15 downto 0);
        Imm_Val_Out: out std_logic_vector(15 downto 0);
	IN_Port_Out: out std_logic_vector(15 downto 0)
     );
end MEM_WB;

Architecture My_MEM_WB of MEM_WB is
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
  regEn<='1';
    Mul_S_U: bit_dff port map (Clk,regEn,resetSignal,Mul_S1,Mul_S2);
    WB_S_U: bit_dff port map (Clk,regEn,resetSignal,WB_S,WB_S_Out);
    WB_DeMux_U: bit_dff port map (Clk,regEn,resetSignal,WB_DeMux,WB_DeMux_Out);
    WB_Mux_U: my_nDFF generic map (n=>2) port map (Clk,regEn,resetSignal,WB_Mux,WB_Mux_Out);
    RW1_U: my_nDFF generic map (n=>3) port map (Clk,regEn,resetSignal,RW1,RW1_Out);
    RW2_U: my_nDFF generic map (n=>3) port map (Clk,regEn,resetSignal,RW2,RW2_Out);
    ALU1_U: my_nDFF generic map (n=>16) port map (Clk,regEn,resetSignal,ALU1,ALU1_Out);
    ALU2_U: my_nDFF generic map (n=>16) port map (Clk,regEn,resetSignal,ALU2,ALU2_Out);
    Mem_U: my_nDFF generic map (n=>16) port map (Clk,regEn,resetSignal,Mem,Mem_Out);
    Imm_Val_U: my_nDFF generic map (n=>16) port map (Clk,regEn,resetSignal,Imm_Val,Imm_Val_Out);
    IN_Port_U: my_nDFF generic map (n=>16) port map (Clk,regEn,resetSignal,IN_Port,IN_Port_Out);

end My_MEM_WB;