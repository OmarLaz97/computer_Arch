Library IEEE;
use ieee.std_logic_1164.all;

Entity Reg_file is
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
end entity;

Architecture a_Reg_file of Reg_file is
component my_nDFF_REG is 
  Generic ( n : integer := 16); 
  port( Clk,En1,En2,Rst : in std_logic; 
        d1 : in std_logic_vector(n-1 downto 0);
	d2 : in std_logic_vector(n-1 downto 0); 
        q : out std_logic_vector(n-1 downto 0)); 
end component;

signal x1,x2,x3,x4,x5,x6,x7,x8: std_logic_vector (15 downto 0);
signal en1,en2: std_logic_vector (7 downto 0);

begin

Reg1: my_nDFF_REG generic map (n=>16) port map (Clk,en1(0),en2(0),Rst,W_data1,W_data2,x1);
Reg2: my_nDFF_REG generic map (n=>16) port map (Clk,en1(1),en2(1),Rst,W_data1,W_data2,x2);
Reg3: my_nDFF_REG generic map (n=>16) port map (Clk,en1(2),en2(2),Rst,W_data1,W_data2,x3);
Reg4: my_nDFF_REG generic map (n=>16) port map (Clk,en1(3),en2(3),Rst,W_data1,W_data2,x4);
Reg5: my_nDFF_REG generic map (n=>16) port map (Clk,en1(4),en2(4),Rst,W_data1,W_data2,x5);
Reg6: my_nDFF_REG generic map (n=>16) port map (Clk,en1(5),en2(5),Rst,W_data1,W_data2,x6);
Reg7: my_nDFF_REG generic map (n=>16) port map (Clk,en1(6),en2(6),Rst,W_data1,W_data2,x7);
Reg8: my_nDFF_REG generic map (n=>16) port map (Clk,en1(7),en2(7),Rst,W_data1,W_data2,x8);

 
en1<="00000001" when W_reg1="000"and wbSig = '1' and on_op = '0' else
    "00000010" when W_reg1="001" and wbSig = '1' and on_op = '0' else
    "00000100" when W_reg1="010" and wbSig = '1' and on_op = '0' else
    "00001000" when W_reg1="011" and wbSig = '1' and on_op = '0' else
    "00010000" when W_reg1="100" and wbSig = '1' and on_op = '0' else
    "00100000" when W_reg1="101" and wbSig = '1' and on_op = '0' else
    "01000000" when W_reg1="110" and wbSig = '1' and on_op = '0' else
    "10000000" when W_reg1="111" and wbSig = '1' and on_op = '0' else

    "00000001" when W_reg2="000" and wbSig = '1' and on_op = '1' else
    "00000010" when W_reg2="001" and wbSig = '1' and on_op = '1' else
    "00000100" when W_reg2="010" and wbSig = '1' and on_op = '1' else
    "00001000" when W_reg2="011" and wbSig = '1' and on_op = '1' else
    "00010000" when W_reg2="100" and wbSig = '1' and on_op = '1' else
    "00100000" when W_reg2="101" and wbSig = '1' and on_op = '1' else
    "01000000" when W_reg2="110" and wbSig = '1' and on_op = '1' else
    "10000000" when W_reg2="111" and wbSig = '1' and on_op = '1' else
    "00000000";

en2<="00000001" when W_reg2="000" and wbSig = '1' and MultSig = '1' else
    "00000010" when W_reg2="001" and wbSig = '1' and MultSig = '1' else
    "00000100" when W_reg2="010" and wbSig = '1' and MultSig = '1' else
    "00001000" when W_reg2="011" and wbSig = '1' and MultSig = '1' else
    "00010000" when W_reg2="100" and wbSig = '1' and MultSig = '1' else
    "00100000" when W_reg2="101" and wbSig = '1' and MultSig = '1' else
    "01000000" when W_reg2="110" and wbSig = '1' and MultSig = '1' else
    "10000000" when W_reg2="111" and wbSig = '1' and MultSig = '1' else
    "00000000";

R_data1 <= x1 when R_src="000" else
	   x2 when R_src="001" else
	   x3 when R_src="010" else
	   x4 when R_src="011" else
	   x5 when R_src="100" else
	   x6 when R_src="101" else
	   x7 when R_src="110" else
	   x8 when R_src="111" else
	   x"0000";


R_data2 <= x1 when R_dst="000" else
	   x2 when R_dst="001" else
	   x3 when R_dst="010" else
	   x4 when R_dst="011" else
	   x5 when R_dst="100" else
	   x6 when R_dst="101" else
	   x7 when R_dst="110" else
	   x8 when R_dst="111" else
	   x"0000";

end Architecture;
