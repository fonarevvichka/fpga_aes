library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity r_mix_cols is
  port (
    plain  : in  std_logic_vector(127 downto 0);
    cipher : out std_logic_vector(127 downto 0);
    --clk    : in std_logic;
	--data_ready	 : in std_logic;
	--data_encrypted_1 : out std_logic
  );
end r_mix_cols;

architecture synth of r_mix_cols is

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

signal new_B0  : unsigned(7 downto 0);
signal new_B1  : unsigned(7 downto 0);
signal new_B2  : unsigned(7 downto 0);
signal new_B3  : unsigned(7 downto 0);
signal new_B4  : unsigned(7 downto 0);
signal new_B5  : unsigned(7 downto 0);
signal new_B6  : unsigned(7 downto 0);
signal new_B7  : unsigned(7 downto 0);
signal new_B8  : unsigned(7 downto 0);
signal new_B9  : unsigned(7 downto 0);
signal new_B10 : unsigned(7 downto 0);
signal new_B11 : unsigned(7 downto 0);
signal new_B12 : unsigned(7 downto 0);
signal new_B13 : unsigned(7 downto 0);
signal new_B14 : unsigned(7 downto 0);
signal new_B15 : unsigned(7 downto 0);

signal B0  : unsigned(7 downto 0);
signal B1  : unsigned(7 downto 0);
signal B2  : unsigned(7 downto 0);
signal B3  : unsigned(7 downto 0);
signal B4  : unsigned(7 downto 0);
signal B5  : unsigned(7 downto 0);
signal B6  : unsigned(7 downto 0);
signal B7  : unsigned(7 downto 0);
signal B8  : unsigned(7 downto 0);
signal B9  : unsigned(7 downto 0);
signal B10 : unsigned(7 downto 0);
signal B11 : unsigned(7 downto 0);
signal B12 : unsigned(7 downto 0);
signal B13 : unsigned(7 downto 0);
signal B14 : unsigned(7 downto 0);
signal B15 : unsigned(7 downto 0);

begin

    --gets one row of bytes from plain text split into 4Byte X 4Byte matrix
    B0  <= unsigned(cipher(7  downto 0 ));
    B1  <= unsigned(cipher(15 downto 8 ));
    B2  <= unsigned(cipher(23 downto 16));
    B3  <= unsigned(cipher(31 downto 24));
    B4  <= unsigned(cipher(39 downto 32));
    B5  <= unsigned(cipher(47 downto 40));
    B6  <= unsigned(cipher(55 downto 48));
    B7  <= unsigned(cipher(63 downto 56));
    B8  <= unsigned(cipher(71 downto 64));
    B9  <= unsigned(cipher(79 downto 72));
    B10 <= unsigned(cipher(87 downto 80));
    B11 <= unsigned(cipher(95 downto 88));
    B12 <= unsigned(cipher(103 downto 96));
    B13 <= unsigned(cipher(111 downto 104));
    B14 <= unsigned(cipher(119 downto 112));
    B15 <= unsigned(cipher(127 downto 120));

    r0_0 : r_row_0 port map(B0 => B0, B1 => B1, B2 => B2, B3 => B3, new_B0 => new_B0);
    r1_0 : r_row_1 port map(B0 => B0, B1 => B1, B2 => B2, B3 => B3, new_B1 => new_B1);
    r2_0 : r_row_2 port map(B0 => B0, B1 => B1, B2 => B2, B3 => B3, new_B2 => new_B2);
    r3_0 : r_row_3 port map(B0 => B0, B1 => B1, B2 => B2, B3 => B3, new_B3 => new_B3);

    r0_1 : r_row_0 port map(B0 => B4, B1 => B5, B2 => B6, B3 => B7, new_B0 => new_B4);
    r1_1 : r_row_1 port map(B0 => B4, B1 => B5, B2 => B6, B3 => B7, new_B1 => new_B5);
    r2_1 : r_row_2 port map(B0 => B4, B1 => B5, B2 => B6, B3 => B7, new_B2 => new_B6);
    r3_1 : r_row_3 port map(B0 => B4, B1 => B5, B2 => B6, B3 => B7, new_B3 => new_B7);

    r0_2 : r_row_0 port map(B0 => B8, B1 => B9, B2 => B10, B3 => B11, new_B0 => new_B8);
    r1_2 : r_row_1 port map(B0 => B8, B1 => B9, B2 => B10, B3 => B11, new_B1 => new_B9);
    r2_2 : r_row_2 port map(B0 => B8, B1 => B9, B2 => B10, B3 => B11, new_B2 => new_B10);
    r3_2 : r_row_3 port map(B0 => B8, B1 => B9, B2 => B10, B3 => B11, new_B3 => new_B11);

    r0_3 : r_row_0 port map(B0 => B12, B1 => B13, B2 => B14, B3 => B15, new_B0 => new_B12);
    r1_3 : r_row_1 port map(B0 => B12, B1 => B13, B2 => B14, B3 => B15, new_B1 => new_B13);
    r2_3 : r_row_2 port map(B0 => B12, B1 => B13, B2 => B14, B3 => B15, new_B2 => new_B14);
    r3_3 : r_row_3 port map(B0 => B12, B1 => B13, B2 => B14, B3 => B15, new_B3 => new_B15);

    plain(7 downto 0)   <= std_logic_vector(new_B0);
    plain(15 downto 8)  <= std_logic_vector(new_B1);
    plain(23 downto 16) <= std_logic_vector(new_B2);
    plain(31 downto 24) <= std_logic_vector(new_B3);

    plain(39 downto 32) <= std_logic_vector(new_B4);
    plain(47 downto 40) <= std_logic_vector(new_B5);
    plain(55 downto 48) <= std_logic_vector(new_B6);
    plain(63 downto 56) <= std_logic_vector(new_B7);

    plain(71 downto 64) <= std_logic_vector(new_B8);
    plain(79 downto 72) <= std_logic_vector(new_B9);
    plain(87 downto 80) <= std_logic_vector(new_B11);
    plain(95 downto 88) <= std_logic_vector(new_B12);

    plain(103 downto 96)  <= std_logic_vector(new_B12);
    plain(111 downto 104) <= std_logic_vector(new_B13);
    plain(119 downto 112) <= std_logic_vector(new_B14);
    plain(127 downto 120) <= std_logic_vector(new_B15); 
end;
