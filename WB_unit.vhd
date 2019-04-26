Library ieee; 
Use ieee.std_logic_1164.all;

Entity Wb_unit is 
  	port(   ALU1_in, ALU2_in, Mem_in, ImmVal 	: in std_logic_vector(15 downto 0);
		Rw1_in, Rw2_in 				: in std_logic_vector(2 downto 0);
		Mul_in, Wb_in 				: in std_logic;
		In_port					: in std_logic_vector (15 downto 0);

		Sel_1					: in std_logic;
		Sel_2					: in std_logic_vector (1 downto 0); 
		
        	ALU2_out, RWr1 				: out std_logic_vector(15 downto 0);
		Out1	 				: out std_logic_vector(15 downto 0);
		Rw1_out, Rw2_out 			: out std_logic_vector(2 downto 0);
		Mul_out, Wb_out 			: out std_logic);
end Wb_unit;

Architecture My_Ex_Mem of Wb_unit is
Component Demux2x1 IS  
		Generic ( n : integer := 16); 
		PORT (SEl		:  IN  std_logic;
		      IN1		:  IN  std_logic_vector (n-1 downto 0);
  		      OUT1, OUT2	:  OUT std_logic_vector (n-1 downto 0));    
END Component Demux2x1;

Component Mux4x2 IS  
		Generic ( n : integer := 16); 
		PORT (SEl	:  IN  std_logic_vector (1 downto 0);
		      IN1,IN2, IN3, IN4	:  IN  std_logic_vector (n-1 downto 0);
  		      OUT1      :  OUT std_logic_vector (n-1 downto 0));    
END Component Mux4x2;
	Signal DemuxOut1, DemuxOut2 : std_logic_vector (15 downto 0);
  begin 

	ALU_Demux: Demux2x1 generic map (n=>16)port map (Sel_1, Alu1_in, DemuxOut1, DemuxOut2);
	Mux1: Mux4x2 generic map (n=>16) port map (Sel_2, Mem_in, ImmVal, DemuxOut1, In_port, Rwr1);
	

	ALU2_out <= ALU2_in;
	Out1 <= DemuxOut2;
	Rw1_out <= Rw1_in;
	Rw2_out <= Rw2_in;
	Mul_out <= Mul_in;
	Wb_out  <= wb_in;	

 end architecture;
