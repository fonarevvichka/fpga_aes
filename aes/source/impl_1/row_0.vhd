library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity row_0 is
  port (
    B0  : in  unsigned(7 downto 0);
    B1  : in  unsigned(7 downto 0);
    B2  : in  unsigned(7 downto 0);
    B3  : in  unsigned(7 downto 0);
    new_B0 : out unsigned(7 downto 0)
  );
end row_0;

architecture synth of row_0 is

component mult_2 is
  port (
    addr : in unsigned(7 downto 0);
    val  : out unsigned(7 downto 0);
  );
end component;

component mult_3 is
  port (
     addr : in unsigned(7 downto 0);
     val  : out unsigned(7 downto 0);
  );
end component;

signal result2 : unsigned(7 downto 0) := "00000000";
signal result3 : unsigned(7 downto 0) := "00000000";

begin

    mult2 : mult_2 port map(addr => B0, val => result2);
    mult3 : mult_3 port map(addr => B1, val => result3);

    new_B0 <= result2 xor result3 xor B2 xor B3;
end;
