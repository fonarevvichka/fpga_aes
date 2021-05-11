library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mix_cols is
  port (
    plain  : in  std_logic_vector(127 downto 0);
    cipher : out std_logic_vector(127 downto 0)
    --clk    : in std_logic;
    --data_ready	 : in std_logic;
    --data_encrypted_1 : out std_logic
  );
end mix_cols;

architecture synth of mix_cols is

component row_0 is
  port(
    B0  : in  unsigned(7 downto 0);
    B1  : in  unsigned(7 downto 0);
    B2  : in  unsigned(7 downto 0);
    B3  : in  unsigned(7 downto 0);
    new_B0 : out unsigned(7 downto 0)
  );
end component;

component row_1 is
  port(
    B0  : in  unsigned(7 downto 0);
    B1  : in  unsigned(7 downto 0);
    B2  : in  unsigned(7 downto 0);
    B3  : in  unsigned(7 downto 0);
    new_B1 : out unsigned(7 downto 0)
  );
end component;

component row_2 is
  port(
    B0  : in  unsigned(7 downto 0);
    B1  : in  unsigned(7 downto 0);
    B2  : in  unsigned(7 downto 0);
    B3  : in  unsigned(7 downto 0);
    new_B2 : out unsigned(7 downto 0)
  );
 end component;

component row_3 is
  port(
    B0  : in  unsigned(7 downto 0);
    B1  : in  unsigned(7 downto 0);
    B2  : in  unsigned(7 downto 0);
    B3  : in  unsigned(7 downto 0);
    new_B3 : out unsigned(7 downto 0)
  );
end component;

signal counter : integer range 0 to 4 := 0;

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
    B0  <= unsigned(plain(7  downto 0 ));
    B1  <= unsigned(plain(15 downto 8 ));
    B2  <= unsigned(plain(23 downto 16));
    B3  <= unsigned(plain(31 downto 24));
    B4  <= unsigned(plain(39 downto 32));
    B5  <= unsigned(plain(47 downto 40));
    B6  <= unsigned(plain(55 downto 48));
    B7  <= unsigned(plain(63 downto 56));
    B8  <= unsigned(plain(71 downto 64));
    B9  <= unsigned(plain(79 downto 72));
    B10 <= unsigned(plain(87 downto 80));
    B11 <= unsigned(plain(95 downto 88));
    B12 <= unsigned(plain(103 downto 96));
    B13 <= unsigned(plain(111 downto 104));
    B14 <= unsigned(plain(119 downto 112));
    B15 <= unsigned(plain(127 downto 120));

    r0_0 : row_0 port map(B0 => B0, B1 => B1, B2 => B2, B3 => B3, new_B0 => new_B0);
    r1_0 : row_1 port map(B0 => B0, B1 => B1, B2 => B2, B3 => B3, new_B1 => new_B1);
    r2_0 : row_2 port map(B0 => B0, B1 => B1, B2 => B2, B3 => B3, new_B2 => new_B2);
    r3_0 : row_3 port map(B0 => B0, B1 => B1, B2 => B2, B3 => B3, new_B3 => new_B3);

    r0_1 : row_0 port map(B0 => B4, B1 => B5, B2 => B6, B3 => B7, new_B0 => new_B4);
    r1_1 : row_1 port map(B0 => B4, B1 => B5, B2 => B6, B3 => B7, new_B1 => new_B5);
    r2_1 : row_2 port map(B0 => B4, B1 => B5, B2 => B6, B3 => B7, new_B2 => new_B6);
    r3_1 : row_3 port map(B0 => B4, B1 => B5, B2 => B6, B3 => B7, new_B3 => new_B7);

    r0_2 : row_0 port map(B0 => B8, B1 => B9, B2 => B10, B3 => B11, new_B0 => new_B8);
    r1_2 : row_1 port map(B0 => B8, B1 => B9, B2 => B10, B3 => B11, new_B1 => new_B9);
    r2_2 : row_2 port map(B0 => B8, B1 => B9, B2 => B10, B3 => B11, new_B2 => new_B10);
    r3_2 : row_3 port map(B0 => B8, B1 => B9, B2 => B10, B3 => B11, new_B3 => new_B11);

    r0_3 : row_0 port map(B0 => B12, B1 => B13, B2 => B14, B3 => B15, new_B0 => new_B12);
    r1_3 : row_1 port map(B0 => B12, B1 => B13, B2 => B14, B3 => B15, new_B1 => new_B13);
    r2_3 : row_2 port map(B0 => B12, B1 => B13, B2 => B14, B3 => B15, new_B2 => new_B14);
    r3_3 : row_3 port map(B0 => B12, B1 => B13, B2 => B14, B3 => B15, new_B3 => new_B15);

    wait for 10 ns;

    cipher(7 downto 0)     <= MULT2(B0) xor MULT3(B1) xor B2 xor B3;
    cipher(15 downto 8)    <= B0 xor MULT2(B1) xor MULT3(B2) xor B3;
    cipher(23 downto 16)   <= B0 xor B1 xor MULT2(B2) xor MULT3(B3);
    cipher(31 downto 24)   <= MULT3(B0) xor B1 xor B2 xor MULT2(B3);

    cipher(39 downto 32)   <= MULT2(B4) xor MULT3(B5) xor B6 xor B7;
    cipher(47 downto 40)   <= B4 xor MULT2(B5) xor MULT3(B6) xor B7;
    cipher(55 downto 48)   <= B4 xor B5 xor MULT2(B6) xor MULT3(B7);
    cipher(63 downto 56)   <= MULT3(B4) xor B5 xor B6 xor MULT2(B7);

    cipher(71 downto 64)   <= MULT2(B8) xor MULT3(B9) xor B10 xor B11;
    cipher(79 downto 72)   <= B8 xor MULT2(B9) xor MULT3(B10) xor B11;
    cipher(87 downto 80)   <= B8 xor B9 xor MULT2(B10) xor MULT3(B11);
    cipher(95 downto 88)   <= MULT3(B8) xor B9 xor B10 xor MULT2(B11);

    cipher(103 downto 96)  <= MULT2(B12) xor MULT3(B13) xor B14 xor B15;
    cipher(111 downto 104) <= B12 xor MULT2(B13) xor MULT3(B14) xor B15;
    cipher(119 downto 112) <= B12 xor B13 xor MULT2(B14) xor MULT3(B15);
    cipher(127 downto 120) <= MULT3(B12) xor B13 xor B14 xor MULT2(B15);

end;                                                     
                              std_logic_vector(new_B12);
                              std_logic_vector(new_B13);
                              std_logic_vector(new_B14);
                              std_logic_vector(new_B15); 
