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

function MULT_EN
(a: std_logic_vector(7 downto 0); b : std_logic_vector(7 downto 0) )
return std_logic_vector is

    variable curr    : std_logic_vector(7 downto 0);
    variable and_mask : std_logic_vector(7 downto 0);

begin

    and_mask := b(7) & b(7) & b(7) & b(7) & b(7) & b(7) & b(7) & b(7);

    case a(3 downto 0) is
        when "0001" => curr := b;
        when "0010" => curr := b(6 downto 0) & '0' xor (("00011011") and and_mask);
        when "0011" => curr := b(6 downto 0) & '0' xor (("00011011") and and_mask) xor b;
        when others => curr := (others => '0');
    end case;

return curr;

end function MULT_EN; 

signal B0  : std_logic_vector(7 downto 0);
signal B1  : std_logic_vector(7 downto 0);
signal B2  : std_logic_vector(7 downto 0);
signal B3  : std_logic_vector(7 downto 0);
signal B4  : std_logic_vector(7 downto 0);
signal B5  : std_logic_vector(7 downto 0);
signal B6  : std_logic_vector(7 downto 0);
signal B7  : std_logic_vector(7 downto 0);
signal B8  : std_logic_vector(7 downto 0);
signal B9  : std_logic_vector(7 downto 0);
signal B10 : std_logic_vector(7 downto 0);
signal B11 : std_logic_vector(7 downto 0);
signal B12 : std_logic_vector(7 downto 0);
signal B13 : std_logic_vector(7 downto 0);
signal B14 : std_logic_vector(7 downto 0);
signal B15 : std_logic_vector(7 downto 0);

begin

    B15 <= plain(7  downto 0 );
    B14 <= plain(15 downto 8 );
    B13 <= plain(23 downto 16);
    B12 <= plain(31 downto 24);
    B11 <= plain(39 downto 32);
    B10 <= plain(47 downto 40);
    B9  <= plain(55 downto 48);
    B8  <= plain(63 downto 56);
    B7  <= plain(71 downto 64);
    B6  <= plain(79 downto 72);
    B5 <= plain(87 downto 80);
    B4 <= plain(95 downto 88);
    B3 <= plain(103 downto 96);
    B2 <= plain(111 downto 104);
    B1 <= plain(119 downto 112);
    B0 <= plain(127 downto 120);

    cipher(127 downto 120) <= MULT_EN("00000010", B0) xor
                               MULT_EN("00000011", B1) xor
                               B2 xor B3;
    cipher(119 downto 112) <= B0 xor MULT_EN("00000010", B1)
                               xor MULT_EN("00000011", B2)
                               xor B3;
    cipher(111 downto 104) <= MULT_EN("00000010" , B2) xor
                               MULT_EN("00000011", B3) xor
                               B0 xor B1;
    cipher(103 downto 96) <= MULT_EN("00000011" , B0) xor
                               MULT_EN("00000010", B3) xor
                               B1 xor B2;
    cipher(95 downto 88) <= MULT_EN("00000010" , B4) xor
                               MULT_EN("00000011", B5) xor
                               B6 xor B7;
    cipher(87 downto 80) <= MULT_EN("00000010" , B5) xor
                               MULT_EN("00000011" , B6) xor
                               B4 xor B7;
    cipher(79 downto 72) <= MULT_EN("00000010" , B6) xor
                               MULT_EN("00000011", B7) xor
                               B4 xor B5;
    cipher(71 downto 64) <= MULT_EN("00000011" , B4) xor
                               MULT_EN("00000010", B7) xor
                               B5 xor B6;
    cipher(63 downto 56) <= MULT_EN("00000010", B8) xor
                               MULT_EN("00000011", B9) xor
                               B10 xor B11;
    cipher(55 downto 48) <= MULT_EN("00000010", B9) xor
                               MULT_EN("00000011", B10) xor
                               B8 xor B11;
    cipher(47 downto 40) <= MULT_EN("00000010", B10) xor
                               MULT_EN("00000011", B11) xor
                               B8 xor B9;
    cipher(39 downto 32) <= MULT_EN("00000011", B8) xor
                               MULT_EN("00000010", B11) xor
                               B9 xor B10;
    cipher(31 downto 24) <= MULT_EN("00000010", B12) xor
                               MULT_EN("00000011", B13) xor
                               B14 xor B15;
    cipher(23 downto 16) <= MULT_EN("00000010",B13) xor
                               MULT_EN("00000011",B14) xor
                               B12 xor B15;
    cipher(15 downto 8)  <= MULT_EN("00000010", B14) xor
                             MULT_EN("00000011", B15) xor
                             B12 xor B13;
    cipher(7 downto 0)   <= MULT_EN("00000011", B12) xor
                             MULT_EN("00000010", B15) xor
                             B13 xor B14;
end;                                                     
