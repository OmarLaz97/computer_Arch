Library ieee; 
Use ieee.std_logic_1164.all;

Entity my_DEnDFF is 
  Generic ( n : integer := 16); 
  port( Clk,En,Rst : in std_logic; 
        d : in std_logic_vector(n-1 downto 0); 
        q : out std_logic_vector(n-1 downto 0)); 
end my_DEnDFF;

Architecture a_my_DEnDFF of my_DEnDFF is
  begin 
  Process (Clk,En,Rst) 
    begin
    if Rst = '1' 
      then q <= (others=>'0'); 
    elsif Rising_edge(Clk) and En='1' 
      then q <= d; 
    end if; 
  end process; 
end a_my_DEnDFF;
