Library ieee; 
Use ieee.std_logic_1164.all;

Entity my_FR is 
  port( Clk,En,Rst : in std_logic; 
        Z,C,N : in std_logic_vector(0 downto 0);
        ZF,Nf,CF : out std_logic_vector(0 downto 0)); 
end my_FR;

Architecture a_my_FR of my_FR is
component my_nDFF is 
  Generic ( n : integer := 16); 
  port( Clk,En,Rst : in std_logic; 
        d : in std_logic_vector(n-1 downto 0); 
        q : out std_logic_vector(n-1 downto 0)); 
end component;
  begin 
  ZeroFlag :my_nDFF generic map (n=>1)port map (Clk,En,Rst,Z,ZF);
  NegativeFlag :my_nDFF generic map (n=>1)port map (Clk,En,Rst,N,NF);
  Cout :my_nDFF generic map (n=>1) port map (Clk,En,Rst,C,CF);
 
end a_my_FR;