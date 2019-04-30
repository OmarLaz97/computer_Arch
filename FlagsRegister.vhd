Library ieee; 
Use ieee.std_logic_1164.all;

Entity my_FR is 
  port( Clk,En,Rst : in std_logic; 
        Z,C,N : in std_logic;
        ZF,Nf,CF : out std_logic); 
end my_FR;

Architecture a_my_FR of my_FR is
component bit_dff is 
  port( Clk,En,Rst : in std_logic; 
        d : in std_logic; 
        q : out std_logic); 
end component;
  begin 
  ZeroFlag :bit_dff generic map (n=>1)port map (Clk,En,Rst,Z,ZF);
  NegativeFlag :bit_dff generic map (n=>1)port map (Clk,En,Rst,N,NF);
  Cout :bit_dff generic map (n=>1) port map (Clk,En,Rst,C,CF);
 
end a_my_FR;