library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mix_cols is
  port (
    cipher  : in  std_logic_vector(127 downto 0);
    plain : out std_logic_vector(127 downto 0)
  );
end mix_cols;

architecture synth of mix_cols is

component r_row_0 is
  port(
    B0  : in  unsigned(7 downto 0);
    B1  : in  unsigned(7 downto 0);
    B2  : in  unsigned(7 downto 0);
    B3  : in  unsigned(7 downto 0);
    new_B0 : out unsigned(7 downto 0)
  );
end component;

component r_row_1 is
  port(
    B0  : in  unsigned(7 downto 0);
    B1  : in  unsigned(7 downto 0);
    B2  : in  unsigned(7 downto 0);
    B3  : in  unsigned(7 downto 0);
    new_B1 : out unsigned(7 downto 0)
  );
end component;

component r_row_2 is
  port(
    B0  : in  unsigned(7 downto 0);
    B1  : in  unsigned(7 downto 0);
    B2  : in  unsigned(7 downto 0);
    B3  : in  unsigned(7 downto 0);
    new_B2 : out unsigned(7 downto 0)
  );
 end component;

component r_row_3 is
  port(
    B0  : in  unsigned(7 downto 0);
    B1  : in  unsigned(7 downto 0);
    B2  : in  unsigned(7 downto 0);
    B3  : in  unsigned(7 downto 0);
    new_B3 : out unsigned(7 downto 0)
  );
end component;

signal new_B0 : unsigned(7 downto 0) := "00000000";
signal new_B1 : unsigned(7 downto 0) := "00000000";
signal new_B2 : unsigned(7 downto 0) := "00000000";
signal new_B3 : unsigned(7 downto 0) := "00000000";

begin

    B0 <= unsigned(cipher((to_integer(7  + counter)) downto (to_integer(0 + counter))));
    B1 <= unsigned(cipher((to_integer(15 + counter)) downto (to_integer(8 + counter))));
    B2 <= unsigned(cipher((to_integer(23 + counter)) downto (to_integer(16 + counter))));
    B3 <= unsigned(cipher((to_integer(31 + counter)) downto (to_integer(24 + counter))));

   r0 : r_row_0 port map(B0 => B0,
                         B1 => B1,
                         B2 => B2,
                         B3 => B3,
                         new_B0 => new_B0);

   r1 : r_row_1 port map(B0 => B0,
                         B1 => B1,
                         B2 => B2,
                         B3 => B3,
                         new_B1 => new_B1);

   r2 : r_row_2 port map(B0 => B0,
                         B1 => B1,
                         B2 => B2,
                         B3 => B3,
                         new_B2 => new_B2);

   r3 : r_row_3 port map(B0 => B0,
                         B1 => B1,
                         B2 => B2,
                         B3 => B3,
                         new_B3 => new_B3);

    plain((to_integer(7  + counter)) downto (to_integer(0 + counter))) <= std_logic_vector(new_B0);
    plain((to_integer(15 + counter)) downto (to_integer(8 + counter))) <= std_logic_vector(new_B1);
    plain((to_integer(23 + counter)) downto (to_integer(16 + counter))) <= std_logic_vector(new_B2);
    plain((to_integer(31 + counter)) downto (to_integer(24 + counter))) <= std_logic_vector(new_B3);

    process (clk) is
    begin
      if rising_edge(clk) then
            counter <= counter + X"08";
      end if;
    end process;
end;
