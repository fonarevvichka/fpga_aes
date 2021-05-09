library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mult_3 is
  port (
    addr : in  unsigned(7 downto 0);
    val  : out unsigned(7 downto 0)
  );
end mult_3;

architecture synth of mult_3 is
begin
  process (addr) is
  begin
    case addr is
        when "00000000" => val <= "00000000";
        when "00000001" => val <= "00000010";
        when "00000010" => val <= "00000100";
        when "00000011" => val <= "00000110";
        when "00000100" => val <= "00001000";
        when "00000101" => val <= "00001010";
        when "00000110" => val <= "00001100";
        when "00000111" => val <= "00001110";
        when "00001000" => val <= "00010000";
        when "00001001" => val <= "00010010";
        when "00001010" => val <= "00010100";
        when "00001011" => val <= "00010110";
        when "00001100" => val <= "00011000";
        when "00001101" => val <= "00011010";
        when "00001110" => val <= "00011100";
        when "00001111" => val <= "00011110";
        when "00010000" => val <= "00100000";
        when "00010001" => val <= "00100010";
        when "00010010" => val <= "00100100";
        when "00010011" => val <= "00100110";
        when "00010100" => val <= "00101000";
        when "00010101" => val <= "00101010";
        when "00010110" => val <= "00101100";
        when "00010111" => val <= "00101110";
        when "00011000" => val <= "00110000";
        when "00011001" => val <= "00110010";
        when "00011010" => val <= "00110100";
        when "00011011" => val <= "00110110";
        when "00011100" => val <= "00111000";
        when "00011101" => val <= "00111010";
        when "00011110" => val <= "00111100";
        when "00011111" => val <= "00111110";
        when "00100000" => val <= "01000000";
        when "00100001" => val <= "01000010";
        when "00100010" => val <= "01000100";
        when "00100011" => val <= "01000110";
        when "00100100" => val <= "01001000";
        when "00100101" => val <= "01001010";
        when "00100110" => val <= "01001100";
        when "00100111" => val <= "01001110";
        when "00101000" => val <= "01010000";
        when "00101001" => val <= "01010010";
        when "00101010" => val <= "01010100";
        when "00101011" => val <= "01010110";
        when "00101100" => val <= "01011000";
        when "00101101" => val <= "01011010";
        when "00101110" => val <= "01011100";
        when "00101111" => val <= "01011110";
        when "00110000" => val <= "01100000";
        when "00110001" => val <= "01100010";
        when "00110010" => val <= "01100100";
        when "00110011" => val <= "01100110";
        when "00110100" => val <= "01101000";
        when "00110101" => val <= "01101010";
        when "00110110" => val <= "01101100";
        when "00110111" => val <= "01101110";
        when "00111000" => val <= "01110000";
        when "00111001" => val <= "01110010";
        when "00111010" => val <= "01110100";
        when "00111011" => val <= "01110110";
        when "00111100" => val <= "01111000";
        when "00111101" => val <= "01111010";
        when "00111110" => val <= "01111100";
        when "00111111" => val <= "01111110";
        when "01000000" => val <= "10000000";
        when "01000001" => val <= "10000010";
        when "01000010" => val <= "10000100";
        when "01000011" => val <= "10000110";
        when "01000100" => val <= "10001000";
        when "01000101" => val <= "10001010";
        when "01000110" => val <= "10001100";
        when "01000111" => val <= "10001110";
        when "01001000" => val <= "10010000";
        when "01001001" => val <= "10010010";
        when "01001010" => val <= "10010100";
        when "01001011" => val <= "10010110";
        when "01001100" => val <= "10011000";
        when "01001101" => val <= "10011010";
        when "01001110" => val <= "10011100";
        when "01001111" => val <= "10011110";
        when "01010000" => val <= "10100000";
        when "01010001" => val <= "10100010";
        when "01010010" => val <= "10100100";
        when "01010011" => val <= "10100110";
        when "01010100" => val <= "10101000";
        when "01010101" => val <= "10101010";
        when "01010110" => val <= "10101100";
        when "01010111" => val <= "10101110";
        when "01011000" => val <= "10110000";
        when "01011001" => val <= "10110010";
        when "01011010" => val <= "10110100";
        when "01011011" => val <= "10110110";
        when "01011100" => val <= "10111000";
        when "01011101" => val <= "10111010";
        when "01011110" => val <= "10111100";
        when "01011111" => val <= "10111110";
        when "01100000" => val <= "11000000";
        when "01100001" => val <= "11000010";
        when "01100010" => val <= "11000100";
        when "01100011" => val <= "11000110";
        when "01100100" => val <= "11001000";
        when "01100101" => val <= "11001010";
        when "01100110" => val <= "11001100";
        when "01100111" => val <= "11001110";
        when "01101000" => val <= "11010000";
        when "01101001" => val <= "11010010";
        when "01101010" => val <= "11010100";
        when "01101011" => val <= "11010110";
        when "01101100" => val <= "11011000";
        when "01101101" => val <= "11011010";
        when "01101110" => val <= "11011100";
        when "01101111" => val <= "11011110";
        when "01110000" => val <= "11100000";
        when "01110001" => val <= "11100010";
        when "01110010" => val <= "11100100";
        when "01110011" => val <= "11100110";
        when "01110100" => val <= "11101000";
        when "01110101" => val <= "11101010";
        when "01110110" => val <= "11101100";
        when "01110111" => val <= "11101110";
        when "01111000" => val <= "11110000";
        when "01111001" => val <= "11110010";
        when "01111010" => val <= "11110100";
        when "01111011" => val <= "11110110";
        when "01111100" => val <= "11111000";
        when "01111101" => val <= "11111010";
        when "01111110" => val <= "11111100";
        when "01111111" => val <= "11111110";
        when "10000000" => val <= "00011011";
        when "10000001" => val <= "00011001";
        when "10000010" => val <= "00011111";
        when "10000011" => val <= "00011101";
        when "10000100" => val <= "00010011";
        when "10000101" => val <= "00010001";
        when "10000110" => val <= "00010111";
        when "10000111" => val <= "00010101";
        when "10001000" => val <= "00001011";
        when "10001001" => val <= "00001001";
        when "10001010" => val <= "00001111";
        when "10001011" => val <= "00001101";
        when "10001100" => val <= "00000011";
        when "10001101" => val <= "00000001";
        when "10001110" => val <= "00000111";
        when "10001111" => val <= "00000101";
        when "10010000" => val <= "00111011";
        when "10010001" => val <= "00111001";
        when "10010010" => val <= "00111111";
        when "10010011" => val <= "00111101";
        when "10010100" => val <= "00110011";
        when "10010101" => val <= "00110001";
        when "10010110" => val <= "00110111";
        when "10010111" => val <= "00110101";
        when "10011000" => val <= "00101011";
        when "10011001" => val <= "00101001";
        when "10011010" => val <= "00101111";
        when "10011011" => val <= "00101101";
        when "10011100" => val <= "00100011";
        when "10011101" => val <= "00100001";
        when "10011110" => val <= "00100111";
        when "10011111" => val <= "00100101";
        when "10100000" => val <= "01011011";
        when "10100001" => val <= "01011001";
        when "10100010" => val <= "01011111";
        when "10100011" => val <= "01011101";
        when "10100100" => val <= "01010011";
        when "10100101" => val <= "01010001";
        when "10100110" => val <= "01010111";
        when "10100111" => val <= "01010101";
        when "10101000" => val <= "01001011";
        when "10101001" => val <= "01001001";
        when "10101010" => val <= "01001111";
        when "10101011" => val <= "01001101";
        when "10101100" => val <= "01000011";
        when "10101101" => val <= "01000001";
        when "10101110" => val <= "01000111";
        when "10101111" => val <= "01000101";
        when "10110000" => val <= "01111011";
        when "10110001" => val <= "01111001";
        when "10110010" => val <= "01111111";
        when "10110011" => val <= "01111101";
        when "10110100" => val <= "01110011";
        when "10110101" => val <= "01110001";
        when "10110110" => val <= "01110111";
        when "10110111" => val <= "01110101";
        when "10111000" => val <= "01101011";
        when "10111001" => val <= "01101001";
        when "10111010" => val <= "01101111";
        when "10111011" => val <= "01101101";
        when "10111100" => val <= "01100011";
        when "10111101" => val <= "01100001";
        when "10111110" => val <= "01100111";
        when "10111111" => val <= "01100101";
        when "11000000" => val <= "10011011";
        when "11000001" => val <= "10011001";
        when "11000010" => val <= "10011111";
        when "11000011" => val <= "10011101";
        when "11000100" => val <= "10010011";
        when "11000101" => val <= "10010001";
        when "11000110" => val <= "10010111";
        when "11000111" => val <= "10010101";
        when "11001000" => val <= "10001011";
        when "11001001" => val <= "10001001";
        when "11001010" => val <= "10001111";
        when "11001011" => val <= "10001101";
        when "11001100" => val <= "10000011";
        when "11001101" => val <= "10000001";
        when "11001110" => val <= "10000111";
        when "11001111" => val <= "10000101";
        when "11010000" => val <= "10111011";
        when "11010001" => val <= "10111001";
        when "11010010" => val <= "10111111";
        when "11010011" => val <= "10111101";
        when "11010100" => val <= "10110011";
        when "11010101" => val <= "10110001";
        when "11010110" => val <= "10110111";
        when "11010111" => val <= "10110101";
        when "11011000" => val <= "10101011";
        when "11011001" => val <= "10101001";
        when "11011010" => val <= "10101111";
        when "11011011" => val <= "10101101";
        when "11011100" => val <= "10100011";
        when "11011101" => val <= "10100001";
        when "11011110" => val <= "10100111";
        when "11011111" => val <= "10100101";
        when "11100000" => val <= "11011011";
        when "11100001" => val <= "11011001";
        when "11100010" => val <= "11011111";
        when "11100011" => val <= "11011101";
        when "11100100" => val <= "11010011";
        when "11100101" => val <= "11010001";
        when "11100110" => val <= "11010111";
        when "11100111" => val <= "11010101";
        when "11101000" => val <= "11001011";
        when "11101001" => val <= "11001001";
        when "11101010" => val <= "11001111";
        when "11101011" => val <= "11001101";
        when "11101100" => val <= "11000011";
        when "11101101" => val <= "11000001";
        when "11101110" => val <= "11000111";
        when "11101111" => val <= "11000101";
        when "11110000" => val <= "11111011";
        when "11110001" => val <= "11111001";
        when "11110010" => val <= "11111111";
        when "11110011" => val <= "11111101";
        when "11110100" => val <= "11110011";
        when "11110101" => val <= "11110001";
        when "11110110" => val <= "11110111";
        when "11110111" => val <= "11110101";
        when "11111000" => val <= "11101011";
        when "11111001" => val <= "11101001";
        when "11111010" => val <= "11101111";
        when "11111011" => val <= "11101101";
        when "11111100" => val <= "11100011";
        when "11111101" => val <= "11100001";
        when "11111110" => val <= "11100111";
        when "11111111" => val <= "11100101";
  end case;
    end process;
end;