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

signal new_B0 : unsigned(7 downto 0);
signal new_B1 : unsigned(7 downto 0);
signal new_B2 : unsigned(7 downto 0);
signal new_B3 : unsigned(7 downto 0);

signal B0 : unsigned(7 downto 0);
signal B1 : unsigned(7 downto 0);
signal B2 : unsigned(7 downto 0);
signal B3 : unsigned(7 downto 0);

begin

    B0 <= unsigned(cipher(7  + (counter*8*4) downto 0 + (counter*8*4)));
    B1 <= unsigned(cipher(15 + (counter*8*4) downto 8 + (counter*8*4)));
    B2 <= unsigned(cipher(23 + (counter*8*4) downto 16 + (counter*8*4)));
    B3 <= unsigned(cipher(31 + (counter*8*4) downto 24 + (counter*8*4)));

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

    plain(7+(counter*8*4)  downto 0 +  (counter*8*4))) <= std_logic_vector(new_B0);
    plain(15+(counter*8*4) downto 8 +  (counter*8*4))) <= std_logic_vector(new_B1);
    plain(23+(counter*8*4) downto 16 + (counter*8*4))) <= std_logic_vector(new_B2);
    plain(31+(counter*8*4) downto 24 + (counter*8*4))) <= std_logic_vector(new_B3);

    process (clk) is
    begin
      if rising_edge(clk) then
            counter <= counter + X"08";
      end if;
    end process;
end;
