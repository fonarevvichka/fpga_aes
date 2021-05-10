library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity r_row_3 is
  port (
    B0  : in  unsigned(7 downto 0);
    B1  : in  unsigned(7 downto 0);
    B2  : in  unsigned(7 downto 0);
    B3  : in  unsigned(7 downto 0);
    new_B3 : out unsigned(7 downto 0)
  );
end r_row_3;

architecture synth of r_row_3 is

component mult_9 is
  port (
    addr : in unsigned(7 downto 0);
    val  : out unsigned(7 downto 0)
  );
end component;

component mult_11 is
  port (
     addr : in unsigned(7 downto 0);
     val  : out unsigned(7 downto 0)
  );
end component;

component mult_13 is
  port (
     addr : in unsigned(7 downto 0);
     val  : out unsigned(7 downto 0)
  );
end component;

component mult_14 is
  port (
     addr : in unsigned(7 downto 0);
     val  : out unsigned(7 downto 0)
  );
end component;

signal result9 : unsigned(7 downto 0);
signal result11 : unsigned(7 downto 0);
signal result13 : unsigned(7 downto 0);
signal result14 : unsigned(7 downto 0);

begin
    mult9 : mult_9 port map(addr => B2, val => result9);
    mult11 : mult_11 port map(addr => B0, val => result11);
    mult13 : mult_13 port map(addr => B1, val => result13);
    mult14 : mult_14 port map(addr => B3, val => result14);

    new_B0 <= result9 xor result11 xor result13 xor result14;
end;
