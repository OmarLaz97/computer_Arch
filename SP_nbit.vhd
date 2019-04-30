library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
Entity SP_ndff is 
  Generic ( n : integer := 32); 
  port( Clk,En,Rst : in std_logic; 
        d : in std_logic_vector(n-1 downto 0); 
        q : out std_logic_vector(n-1 downto 0)); 
end SP_ndff;

Architecture a_SP_ndff of SP_ndff is
  begin 
  Process (Clk,En,Rst) 
  variable count : integer;
    begin
    if Rst = '1'
then
     count := 1048575; 
     q <= std_logic_vector(to_unsigned(count,32)); 
    elsif rising_edge(Clk) and En='1' 
      then q <= d; 
    end if; 
  end process; 
end a_SP_ndff;
