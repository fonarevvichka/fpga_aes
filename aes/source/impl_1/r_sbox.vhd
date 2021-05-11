library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity r_sbox is
  port (
    cipher : in  std_logic_vector(127 downto 0);
    plain  : out std_logic_vector(127 downto 0)
  );
end r_sbox;

architecture synth of r_sbox is

function R_SBOX_FUNC (addr : in std_logic_vector(7 downto 0))
    return std_logic_vector is
    variable sub : std_logic_vector(7 downto 0);
  begin
      case addr is
        when "01100011" => sub := "00000000";
        when "01111100" => sub := "00000001";
        when "01110111" => sub := "00000010";
        when "01111011" => sub := "00000011";
        when "11110010" => sub := "00000100";
        when "01101011" => sub := "00000101";
        when "01101111" => sub := "00000110";
        when "11000101" => sub := "00000111";
        when "00110000" => sub := "00001000";
        when "00000001" => sub := "00001001";
        when "01100111" => sub := "00001010";
        when "00101011" => sub := "00001011";
        when "11111110" => sub := "00001100";
        when "11010111" => sub := "00001101";
        when "10101011" => sub := "00001110";
        when "01110110" => sub := "00001111";
        when "11001010" => sub := "00010000";
        when "10000010" => sub := "00010001";
        when "11001001" => sub := "00010010";
        when "01111101" => sub := "00010011";
        when "11111010" => sub := "00010100";
        when "01011001" => sub := "00010101";
        when "01000111" => sub := "00010110";
        when "11110000" => sub := "00010111";
        when "10101101" => sub := "00011000";
        when "11010100" => sub := "00011001";
        when "10100010" => sub := "00011010";
        when "10101111" => sub := "00011011";
        when "10011100" => sub := "00011100";
        when "10100100" => sub := "00011101";
        when "01110010" => sub := "00011110";
        when "11000000" => sub := "00011111";
        when "10110111" => sub := "00100000";
        when "11111101" => sub := "00100001";
        when "10010011" => sub := "00100010";
        when "00100110" => sub := "00100011";
        when "00110110" => sub := "00100100";
        when "00111111" => sub := "00100101";
        when "11110111" => sub := "00100110";
        when "11001100" => sub := "00100111";
        when "00110100" => sub := "00101000";
        when "10100101" => sub := "00101001";
        when "11100101" => sub := "00101010";
        when "11110001" => sub := "00101011";
        when "01110001" => sub := "00101100";
        when "11011000" => sub := "00101101";
        when "00110001" => sub := "00101110";
        when "00010101" => sub := "00101111";
        when "00000100" => sub := "00110000";
        when "11000111" => sub := "00110001";
        when "00100011" => sub := "00110010";
        when "11000011" => sub := "00110011";
        when "00011000" => sub := "00110100";
        when "10010110" => sub := "00110101";
        when "00000101" => sub := "00110110";
        when "10011010" => sub := "00110111";
        when "00000111" => sub := "00111000";
        when "00010010" => sub := "00111001";
        when "10000000" => sub := "00111010";
        when "11100010" => sub := "00111011";
        when "11101011" => sub := "00111100";
        when "00100111" => sub := "00111101";
        when "10110010" => sub := "00111110";
        when "01110101" => sub := "00111111";
        when "00001001" => sub := "01000000";
        when "10000011" => sub := "01000001";
        when "00101100" => sub := "01000010";
        when "00011010" => sub := "01000011";
        when "00011011" => sub := "01000100";
        when "01101110" => sub := "01000101";
        when "01011010" => sub := "01000110";
        when "10100000" => sub := "01000111";
        when "01010010" => sub := "01001000";
        when "00111011" => sub := "01001001";
        when "11010110" => sub := "01001010";
        when "10110011" => sub := "01001011";
        when "00101001" => sub := "01001100";
        when "11100011" => sub := "01001101";
        when "00101111" => sub := "01001110";
        when "10000100" => sub := "01001111";
        when "01010011" => sub := "01010000";
        when "11010001" => sub := "01010001";
        when "00000000" => sub := "01010010";
        when "11101101" => sub := "01010011";
        when "00100000" => sub := "01010100";
        when "11111100" => sub := "01010101";
        when "10110001" => sub := "01010110";
        when "01011011" => sub := "01010111";
        when "01101010" => sub := "01011000";
        when "11001011" => sub := "01011001";
        when "10111110" => sub := "01011010";
        when "00111001" => sub := "01011011";
        when "01001010" => sub := "01011100";
        when "01001100" => sub := "01011101";
        when "01011000" => sub := "01011110";
        when "11001111" => sub := "01011111";
        when "11010000" => sub := "01100000";
        when "11101111" => sub := "01100001";
        when "10101010" => sub := "01100010";
        when "11111011" => sub := "01100011";
        when "01000011" => sub := "01100100";
        when "01001101" => sub := "01100101";
        when "00110011" => sub := "01100110";
        when "10000101" => sub := "01100111";
        when "01000101" => sub := "01101000";
        when "11111001" => sub := "01101001";
        when "00000010" => sub := "01101010";
        when "01111111" => sub := "01101011";
        when "01010000" => sub := "01101100";
        when "00111100" => sub := "01101101";
        when "10011111" => sub := "01101110";
        when "10101000" => sub := "01101111";
        when "01010001" => sub := "01110000";
        when "10100011" => sub := "01110001";
        when "01000000" => sub := "01110010";
        when "10001111" => sub := "01110011";
        when "10010010" => sub := "01110100";
        when "10011101" => sub := "01110101";
        when "00111000" => sub := "01110110";
        when "11110101" => sub := "01110111";
        when "10111100" => sub := "01111000";
        when "10110110" => sub := "01111001";
        when "11011010" => sub := "01111010";
        when "00100001" => sub := "01111011";
        when "00010000" => sub := "01111100";
        when "11111111" => sub := "01111101";
        when "11110011" => sub := "01111110";
        when "11010010" => sub := "01111111";
        when "11001101" => sub := "10000000";
        when "00001100" => sub := "10000001";
        when "00010011" => sub := "10000010";
        when "11101100" => sub := "10000011";
        when "01011111" => sub := "10000100";
        when "10010111" => sub := "10000101";
        when "01000100" => sub := "10000110";
        when "00010111" => sub := "10000111";
        when "11000100" => sub := "10001000";
        when "10100111" => sub := "10001001";
        when "01111110" => sub := "10001010";
        when "00111101" => sub := "10001011";
        when "01100100" => sub := "10001100";
        when "01011101" => sub := "10001101";
        when "00011001" => sub := "10001110";
        when "01110011" => sub := "10001111";
        when "01100000" => sub := "10010000";
        when "10000001" => sub := "10010001";
        when "01001111" => sub := "10010010";
        when "11011100" => sub := "10010011";
        when "00100010" => sub := "10010100";
        when "00101010" => sub := "10010101";
        when "10010000" => sub := "10010110";
        when "10001000" => sub := "10010111";
        when "01000110" => sub := "10011000";
        when "11101110" => sub := "10011001";
        when "10111000" => sub := "10011010";
        when "00010100" => sub := "10011011";
        when "11011110" => sub := "10011100";
        when "01011110" => sub := "10011101";
        when "00001011" => sub := "10011110";
        when "11011011" => sub := "10011111";
        when "11100000" => sub := "10100000";
        when "00110010" => sub := "10100001";
        when "00111010" => sub := "10100010";
        when "00001010" => sub := "10100011";
        when "01001001" => sub := "10100100";
        when "00000110" => sub := "10100101";
        when "00100100" => sub := "10100110";
        when "01011100" => sub := "10100111";
        when "11000010" => sub := "10101000";
        when "11010011" => sub := "10101001";
        when "10101100" => sub := "10101010";
        when "01100010" => sub := "10101011";
        when "10010001" => sub := "10101100";
        when "10010101" => sub := "10101101";
        when "11100100" => sub := "10101110";
        when "01111001" => sub := "10101111";
        when "11100111" => sub := "10110000";
        when "11001000" => sub := "10110001";
        when "00110111" => sub := "10110010";
        when "01101101" => sub := "10110011";
        when "10001101" => sub := "10110100";
        when "11010101" => sub := "10110101";
        when "01001110" => sub := "10110110";
        when "10101001" => sub := "10110111";
        when "01101100" => sub := "10111000";
        when "01010110" => sub := "10111001";
        when "11110100" => sub := "10111010";
        when "11101010" => sub := "10111011";
        when "01100101" => sub := "10111100";
        when "01111010" => sub := "10111101";
        when "10101110" => sub := "10111110";
        when "00001000" => sub := "10111111";
        when "10111010" => sub := "11000000";
        when "01111000" => sub := "11000001";
        when "00100101" => sub := "11000010";
        when "00101110" => sub := "11000011";
        when "00011100" => sub := "11000100";
        when "10100110" => sub := "11000101";
        when "10110100" => sub := "11000110";
        when "11000110" => sub := "11000111";
        when "11101000" => sub := "11001000";
        when "11011101" => sub := "11001001";
        when "01110100" => sub := "11001010";
        when "00011111" => sub := "11001011";
        when "01001011" => sub := "11001100";
        when "10111101" => sub := "11001101";
        when "10001011" => sub := "11001110";
        when "10001010" => sub := "11001111";
        when "01110000" => sub := "11010000";
        when "00111110" => sub := "11010001";
        when "10110101" => sub := "11010010";
        when "01100110" => sub := "11010011";
        when "01001000" => sub := "11010100";
        when "00000011" => sub := "11010101";
        when "11110110" => sub := "11010110";
        when "00001110" => sub := "11010111";
        when "01100001" => sub := "11011000";
        when "00110101" => sub := "11011001";
        when "01010111" => sub := "11011010";
        when "10111001" => sub := "11011011";
        when "10000110" => sub := "11011100";
        when "11000001" => sub := "11011101";
        when "00011101" => sub := "11011110";
        when "10011110" => sub := "11011111";
        when "11100001" => sub := "11100000";
        when "11111000" => sub := "11100001";
        when "10011000" => sub := "11100010";
        when "00010001" => sub := "11100011";
        when "01101001" => sub := "11100100";
        when "11011001" => sub := "11100101";
        when "10001110" => sub := "11100110";
        when "10010100" => sub := "11100111";
        when "10011011" => sub := "11101000";
        when "00011110" => sub := "11101001";
        when "10000111" => sub := "11101010";
        when "11101001" => sub := "11101011";
        when "11001110" => sub := "11101100";
        when "01010101" => sub := "11101101";
        when "00101000" => sub := "11101110";
        when "11011111" => sub := "11101111";
        when "10001100" => sub := "11110000";
        when "10100001" => sub := "11110001";
        when "10001001" => sub := "11110010";
        when "00001101" => sub := "11110011";
        when "10111111" => sub := "11110100";
        when "11100110" => sub := "11110101";
        when "01000010" => sub := "11110110";
        when "01101000" => sub := "11110111";
        when "01000001" => sub := "11111000";
        when "10011001" => sub := "11111001";
        when "00101101" => sub := "11111010";
        when "00001111" => sub := "11111011";
        when "10110000" => sub := "11111100";
        when "01010100" => sub := "11111101";
        when "10111011" => sub := "11111110";
        when "00010110" => sub := "11111111";
        when others		=> sub := "00000000";
      end case;

    return sub;
     
end function R_SBOX_FUNC;

begin

    plain(7   downto 0 )  <= R_SBOX_FUNC(cipher(7   downto 0 ));
    plain(15  downto 8 )  <= R_SBOX_FUNC(cipher(15  downto 8 ));
    plain(23  downto 16)  <= R_SBOX_FUNC(cipher(23  downto 16));
    plain(31  downto 24)  <= R_SBOX_FUNC(cipher(31  downto 24));

    plain(39  downto 32)  <= R_SBOX_FUNC(cipher(39  downto 32));
    plain(47  downto 40)  <= R_SBOX_FUNC(cipher(47  downto 40));
    plain(55  downto 48)  <= R_SBOX_FUNC(cipher(55  downto 48));
    plain(63  downto 56)  <= R_SBOX_FUNC(cipher(63  downto 56));

    plain(71  downto 64)  <= R_SBOX_FUNC(cipher(71  downto 64));
    plain(79  downto 72)  <= R_SBOX_FUNC(cipher(79  downto 72));
    plain(87  downto 80)  <= R_SBOX_FUNC(cipher(87  downto 80));
    plain(95  downto 88)  <= R_SBOX_FUNC(cipher(95  downto 88));

    plain(103 downto 96)  <= R_SBOX_FUNC(cipher(103 downto 96));
    plain(111 downto 104) <= R_SBOX_FUNC(cipher(111 downto 104));
    plain(119 downto 112) <= R_SBOX_FUNC(cipher(119 downto 112));
    plain(127 downto 120) <= R_SBOX_FUNC(cipher(127 downto 120));

end;
