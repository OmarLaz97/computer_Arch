Library ieee; 
Use ieee.std_logic_1164.all;

Entity bit_dff is 
  port( Clk,En,Rst : in std_logic; 
        d : in std_logic; 
        q : out std_logic); 
end bit_dff;

Architecture a_bit_dff of bit_dff is
  begin 
  Process (Clk,En,Rst) 
    begin
    if Rst = '1' 
      then q <= '0'; 
    elsif falling_edge(Clk) and En='1' 
      then q <= d; 
    end if; 
  end process; 
end Architecture;
