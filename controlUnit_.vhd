Library ieee; 
Use ieee.std_logic_1164.all;

Entity CU is 
  Generic ( n : integer := 16); 
  port( Clk,En,Rst : in std_logic; 
        d : in std_logic_vector(n-1 downto 0); 
        q : out std_logic_vector(n-1 downto 0)); 
end CU;

Architecture a_CU of CU is
  begin 
  Process (Clk,En,Rst) 
    begin
    if Rst = '1' 
      then q <= (others=>'0'); 
    elsif falling_edge(Clk) and En='1' 
      then q <= d; 
    end if; 
  end process; 
end a_CU;
