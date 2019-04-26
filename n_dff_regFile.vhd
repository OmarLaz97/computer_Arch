Library ieee; 
Use ieee.std_logic_1164.all;

Entity my_nDFF_REG is 
  Generic ( n : integer := 16); 
  port( Clk,En1,En2,Rst : in std_logic; 
        d1 : in std_logic_vector(n-1 downto 0);
	d2 : in std_logic_vector(n-1 downto 0); 
        q : out std_logic_vector(n-1 downto 0)); 
end my_nDFF_REG;

Architecture a_my_nDFF_REG of my_nDFF_REG is
  begin 
  Process (Clk,En1,En2,Rst) 
    begin
    if Rst = '1' 
      then q <= (others=>'0'); 
    elsif falling_edge(Clk)
then 
	if En1='1' 
	then q <= d1;
	elsif En2='1'
	then q <= d2;
    	end if;
end if; 
  end process; 
end a_my_nDFF_REG;