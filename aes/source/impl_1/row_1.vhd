library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity row_1 is
  port (
    B0  : in  unsigned(7 downto 0);
    B1  : in  unsigned(7 downto 0);
    B2  : in  unsigned(7 downto 0);
    B3  : in  unsigned(7 downto 0);
    new_B1 : out unsigned(7 downto 0)
  );
end row_1;

architecture synth of row_1 is

component mult_2 is
  port (
    addr : in unsigned(7 downto 0);
    val  : out unsigned(7 downto 0)
  );
end component;

component mult_3 is
  port (
     addr : in unsigned(7 downto 0);
     val  : out unsigned(7 downto 0)
  );
end component;

signal result2 : unsigned(7 downto 0);
signal result3 : unsigned(7 downto 0);

begin

    mult2 : mult_2 port map(addr => B1, val => result2);
    mult3 : mult_3 port map(addr => B2, val => result3);

    new_B1 <= B0 xor result2 xor result3 xor B3;
end;
