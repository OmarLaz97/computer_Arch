Library ieee; 
Use ieee.std_logic_1164.all;

Entity Ex_Mem is 
  	port(   Clk,Rst 		: in std_logic; 
        	ALU1_in, ALU2_in 	: in std_logic_vector(15 downto 0);
		Rsource_in, Rdest_in 	: in std_logic_vector(2 downto 0);
		Cunit_in 		: in std_logic_vector(15 downto 0);
		EA_in	 		: in std_logic_vector(31 downto 0);
        	ALU1_out, ALU2_out 	: out std_logic_vector(15 downto 0);
		Rsource_out, Rdest_out 	: out std_logic_vector(2 downto 0);
		Cunit_out 		: out std_logic_vector(15 downto 0);
		EA_out	 		: out std_logic_vector(31 downto 0)); 
end Ex_Mem;

Architecture My_Ex_Mem of Ex_Mem is
component my_nDFF is 
  Generic ( n : integer := 16); 
  port( Clk,En,Rst : in std_logic; 
        d : in std_logic_vector(n-1 downto 0); 
        q : out std_logic_vector(n-1 downto 0)); 
end component;
signal regEn : std_logic;
  begin 
  regEn <= '1';
  ALU1 :my_nDFF generic map (n=>16)port map (Clk,regEn,Rst,ALU1_in,ALU1_out);
  ALU2 :my_nDFF generic map (n=>16)port map (Clk,regEn,Rst,ALU2_in,ALU2_out);
  RSource :my_nDFF generic map (n=>3)port map (Clk,regEn,Rst,Rsource_in,Rsource_out);
  RDest :my_nDFF generic map (n=>3)port map (Clk,regEn,Rst,Rdest_in,Rdest_out);
  CU :my_nDFF generic map (n=>16) port map (Clk,regEn,Rst,Cunit_in,Cunit_out);
  EffAddress :my_nDFF generic map (n=>32) port map (Clk,regEn,Rst,EA_in,EA_out);
 
end My_Ex_Mem;
