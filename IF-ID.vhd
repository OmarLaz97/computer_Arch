Library ieee;
Use ieee.std_logic_1164.all;

Entity IF_ID is 
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
End IF_ID;

Architecture a_IF_ID of IF_ID is

Component my_nDFF is 
Generic ( n : integer := 16); 
Port (
        Clk, En, Rst: in std_logic; 
        d: in std_logic_vector(n-1 downto 0); 
        q: out std_logic_vector(n-1 downto 0)
     ); 
End Component my_nDFF;

Begin
    Instr_U: my_nDFF generic map (n=>16) port map (Clk,regEn,resetSignal,Instr,Instr_Out);
    PC_U: my_nDFF generic map (n=>32) port map (Clk,regEn,resetSignal,PC,PC_Out);
    PC_P1_U: my_nDFF generic map (n=>32) port map (Clk,regEn,resetSignal,PC_Pl,PC_Pl_Out);

End a_IF_ID;
