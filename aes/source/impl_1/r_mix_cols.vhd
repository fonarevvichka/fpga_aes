library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity r_mix_cols is
  port (
    cipher  : in  std_logic_vector(127 downto 0);
    plain : out std_logic_vector(127 downto 0)
  );
end r_mix_cols;

architecture synth of r_mix_cols is

-- Multiply bits like they are polynomials in the Galois field
function MULT_DE (a: std_logic_vector(7 downto 0); b: std_logic_vector(7 downto 0))
return std_logic_vector is
    variable temp: std_logic_vector(7 downto 0);
    variable temp1: std_logic_vector(7 downto 0);
    variable temp2: std_logic_vector(7 downto 0);
    variable temp3: std_logic_vector(7 downto 0);
    variable and_mask: std_logic_vector(7 downto 0);
begin
and_mask := b(7) & b(7) & b(7) & b(7) & b(7) & b(7) & b(7) & b(7);
case a(3 downto 0) is
    when "1001"=> temp1 := b(6 downto 0) & '0' xor (("00011011") and and_mask);
                  and_mask := temp1(7) & temp1(7) & temp1(7) & temp1(7) & temp1(7) & temp1(7) & temp1(7) & temp1(7);
                  temp2 := temp1(6 downto 0) & '0' xor (("00011011") and and_mask);
                  and_mask := temp2(7) & temp2(7) & temp2(7) & temp2(7) &
                  temp2(7) & temp2(7) & temp2(7) & temp2(7);
                  temp3 := temp2(6 downto 0) & '0' xor (("00011011") and and_mask);
                  temp := temp3 xor b;
    when "1011"=> temp1 := b(6 downto 0) & '0' xor (("00011011") and and_mask);
                  and_mask := temp1(7) & temp1(7) & temp1(7) & temp1(7) & temp1(7) & temp1(7) & temp1(7) & temp1(7);
                  temp2 := temp1(6 downto 0) & '0' xor (("00011011") and and_mask);
                  and_mask := temp2(7) & temp2(7) & temp2(7) & temp2(7) & temp2(7) & temp2(7) & temp2(7) & temp2(7);
                  temp3 := temp2(6 downto 0) & '0' xor (("00011011") and and_mask);
                  temp := temp1 xor temp3 xor b;
    when "1101" => temp1 := b(6 downto 0) & '0' xor (("00011011") and and_mask);
                   and_mask := temp1(7) & temp1(7) & temp1(7) & temp1(7) & temp1(7) & temp1(7) & temp1(7) & temp1(7);
                   temp2 := temp1(6 downto 0) & '0' xor (("00011011") and and_mask);
                   and_mask := temp2(7) & temp2(7) & temp2(7) & temp2(7) & temp2(7) & temp2(7) & temp2(7) & temp2(7);
                   temp3 := temp2(6 downto 0) & '0' xor (("00011011") and and_mask);
                   temp := temp2 xor temp3 xor b;
    when "1110"=> temp1 := b(6 downto 0) & '0' xor (("00011011") and and_mask);
                  and_mask := temp1(7) & temp1(7) & temp1(7) & temp1(7) & temp1(7) & temp1(7) & temp1(7) & temp1(7);
                  temp2 := temp1(6 downto 0) & '0' xor (("00011011") and and_mask);
                  and_mask := temp2(7) & temp2(7) & temp2(7) & temp2(7) & temp2(7) & temp2(7) & temp2(7) & temp2(7);
                  temp3 := temp2(6 downto 0) & '0' xor (("00011011") and and_mask);
                  temp := temp1 xor temp2 xor temp3;
    when others => temp := (others => '0');

end case;
return temp;
end function MULT_DE;

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
    --gets one row of bytes from plain text split into 4Byte X 4Byte matrix
    B15 <= cipher(7  downto 0 );
    B14 <= cipher(15 downto 8 );
    B13 <= cipher(23 downto 16);
    B12 <= cipher(31 downto 24);
    B11 <= cipher(39 downto 32);
    B10 <= cipher(47 downto 40);
    B9  <= cipher(55 downto 48);
    B8  <= cipher(63 downto 56);
    B7  <= cipher(71 downto 64);
    B6  <= cipher(79 downto 72);
    B5  <= cipher(87 downto 80);
    B4  <= cipher(95 downto 88);
    B3  <= cipher(103 downto 96);
    B2  <= cipher(111 downto 104);
    B1  <= cipher(119 downto 112);
    B0  <= cipher(127 downto 120);

    plain(127 downto 120) <= MULT_DE("00001110", B0) xor
                             MULT_DE("00001011", B1) xor
                             MULT_DE("00001101", B2) xor
                             MULT_DE("00001001", B3);
    plain(119 downto 112) <= MULT_DE("00001001", B0) xor
                             MULT_DE("00001110", B1) xor
                             MULT_DE("00001011", B2) xor
                             MULT_DE("00001101", B3);
    plain(111 downto 104) <= MULT_DE("00001101", B0) xor
                             MULT_DE("00001001", B1) xor
                             MULT_DE("00001110", B2) xor
                            MULT_DE("00001011", B3);
    plain(103 downto 96) <= MULT_DE("00001011", B0) xor
                            MULT_DE("00001101", B1) xor
                            MULT_DE("00001001", B2) xor
                            MULT_DE("00001110", B3);
    plain(95 downto 88) <= MULT_DE("00001110", B4) xor
                           MULT_DE("00001011", B5) xor
                           MULT_DE("00001101", B6) xor
                           MULT_DE("00001001", B7) ;
    plain(87 downto 80) <= MULT_DE("00001001", B4) xor
                           MULT_DE("00001110", B5) xor
                           MULT_DE("00001011", B6) xor
                           MULT_DE("00001101", B7);
    plain(79 downto 72) <= MULT_DE("00001101", B4) xor
                           MULT_DE("00001001", B5) xor
                           MULT_DE("00001110", B6) xor
                           MULT_DE("00001011", B7);
    plain(71 downto 64) <= MULT_DE("00001011", B4) xor
                           MULT_DE("00001101", B5) xor
                           MULT_DE("00001001", B6) xor
                           MULT_DE("00001110", B7); 
    plain(63 downto 56) <= MULT_DE("00001110", B8) xor
                           MULT_DE("00001011", B9) xor
                           MULT_DE("00001101", B10) xor
                           MULT_DE("00001001", B11) ;
    plain(55 downto 48) <= MULT_DE("00001001", B8) xor
                           MULT_DE("00001110", B9) xor
                           MULT_DE("00001011", B10) xor
                           MULT_DE("00001101", B11);
    plain(47 downto 40) <= MULT_DE("00001101", B8) xor
                           MULT_DE("00001001", B9) xor
                           MULT_DE("00001110", B10) xor
                           MULT_DE("00001011", B11);
    plain(39 downto 32) <= MULT_DE("00001011", B8) xor
                           MULT_DE("00001101", B9) xor
                           MULT_DE("00001001", B10) xor
                           MULT_DE("00001110", B11);
    plain(31 downto 24) <= MULT_DE("00001110", B12) xor
                           MULT_DE("00001011", B13) xor
                           MULT_DE("00001101", B14) xor
                           MULT_DE("00001001", B15);
    plain(23 downto 16) <= MULT_DE("00001001", B12) xor
                           MULT_DE("00001110", B13) xor
                           MULT_DE("00001011", B14) xor
                           MULT_DE("00001101", B15);
    plain(15 downto 8) <= MULT_DE("00001101", B12) xor
                          MULT_DE("00001001", B13) xor
                          MULT_DE("00001110", B14) xor
                          MULT_DE("00001011", B15);
    plain(7 downto 0) <= MULT_DE("00001011", B12) xor
                         MULT_DE("00001101", B13) xor
                         MULT_DE("00001001", B14) xor
                         MULT_DE("00001110", B15);
end;
