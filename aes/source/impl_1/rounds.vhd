library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity rounds is
  port(
    clk    			: in std_logic;
	plain  			: in std_logic_vector(127 downto 0);
	cipher 			: out std_logic_vector(127 downto 0);
	data_ready		: in std_logic;
	data_encrypted 	: out std_logic
  );
end rounds;

architecture synth of rounds is

function SBOX (addr : in std_logic_vector(7 downto 0))
    return std_logic_vector is
    variable sub : std_logic_vector(7 downto 0);
  begin
      case addr is
        when "00000000" => sub := "01100011";
        when "00000001" => sub := "01111100";
        when "00000010" => sub := "01110111";
        when "00000011" => sub := "01111011";
        when "00000100" => sub := "11110010";
        when "00000101" => sub := "01101011";
        when "00000110" => sub := "01101111";
        when "00000111" => sub := "11000101";
        when "00001000" => sub := "00110000";
        when "00001001" => sub := "00000001";
        when "00001010" => sub := "01100111";
        when "00001011" => sub := "00101011";
        when "00001100" => sub := "11111110";
        when "00001101" => sub := "11010111";
        when "00001110" => sub := "10101011";
        when "00001111" => sub := "01110110";
        when "00010000" => sub := "11001010";
        when "00010001" => sub := "10000010";
        when "00010010" => sub := "11001001";
        when "00010011" => sub := "01111101";
        when "00010100" => sub := "11111010";
        when "00010101" => sub := "01011001";
        when "00010110" => sub := "01000111";
        when "00010111" => sub := "11110000";
        when "00011000" => sub := "10101101";
        when "00011001" => sub := "11010100";
        when "00011010" => sub := "10100010";
        when "00011011" => sub := "10101111";
        when "00011100" => sub := "10011100";
        when "00011101" => sub := "10100100";
        when "00011110" => sub := "01110010";
        when "00011111" => sub := "11000000";
        when "00100000" => sub := "10110111";
        when "00100001" => sub := "11111101";
        when "00100010" => sub := "10010011";
        when "00100011" => sub := "00100110";
        when "00100100" => sub := "00110110";
        when "00100101" => sub := "00111111";
        when "00100110" => sub := "11110111";
        when "00100111" => sub := "11001100";
        when "00101000" => sub := "00110100";
        when "00101001" => sub := "10100101";
        when "00101010" => sub := "11100101";
        when "00101011" => sub := "11110001";
        when "00101100" => sub := "01110001";
        when "00101101" => sub := "11011000";
        when "00101110" => sub := "00110001";
        when "00101111" => sub := "00010101";
        when "00110000" => sub := "00000100";
        when "00110001" => sub := "11000111";
        when "00110010" => sub := "00100011";
        when "00110011" => sub := "11000011";
        when "00110100" => sub := "00011000";
        when "00110101" => sub := "10010110";
        when "00110110" => sub := "00000101";
        when "00110111" => sub := "10011010";
        when "00111000" => sub := "00000111";
        when "00111001" => sub := "00010010";
        when "00111010" => sub := "10000000";
        when "00111011" => sub := "11100010";
        when "00111100" => sub := "11101011";
        when "00111101" => sub := "00100111";
        when "00111110" => sub := "10110010";
        when "00111111" => sub := "01110101";
        when "01000000" => sub := "00001001";
        when "01000001" => sub := "10000011";
        when "01000010" => sub := "00101100";
        when "01000011" => sub := "00011010";
        when "01000100" => sub := "00011011";
        when "01000101" => sub := "01101110";
        when "01000110" => sub := "01011010";
        when "01000111" => sub := "10100000";
        when "01001000" => sub := "01010010";
        when "01001001" => sub := "00111011";
        when "01001010" => sub := "11010110";
        when "01001011" => sub := "10110011";
        when "01001100" => sub := "00101001";
        when "01001101" => sub := "11100011";
        when "01001110" => sub := "00101111";
        when "01001111" => sub := "10000100";
        when "01010000" => sub := "01010011";
        when "01010001" => sub := "11010001";
        when "01010010" => sub := "00000000";
        when "01010011" => sub := "11101101";
        when "01010100" => sub := "00100000";
        when "01010101" => sub := "11111100";
        when "01010110" => sub := "10110001";
        when "01010111" => sub := "01011011";
        when "01011000" => sub := "01101010";
        when "01011001" => sub := "11001011";
        when "01011010" => sub := "10111110";
        when "01011011" => sub := "00111001";
        when "01011100" => sub := "01001010";
        when "01011101" => sub := "01001100";
        when "01011110" => sub := "01011000";
        when "01011111" => sub := "11001111";
        when "01100000" => sub := "11010000";
        when "01100001" => sub := "11101111";
        when "01100010" => sub := "10101010";
        when "01100011" => sub := "11111011";
        when "01100100" => sub := "01000011";
        when "01100101" => sub := "01001101";
        when "01100110" => sub := "00110011";
        when "01100111" => sub := "10000101";
        when "01101000" => sub := "01000101";
        when "01101001" => sub := "11111001";
        when "01101010" => sub := "00000010";
        when "01101011" => sub := "01111111";
        when "01101100" => sub := "01010000";
        when "01101101" => sub := "00111100";
        when "01101110" => sub := "10011111";
        when "01101111" => sub := "10101000";
        when "01110000" => sub := "01010001";
        when "01110001" => sub := "10100011";
        when "01110010" => sub := "01000000";
        when "01110011" => sub := "10001111";
        when "01110100" => sub := "10010010";
        when "01110101" => sub := "10011101";
        when "01110110" => sub := "00111000";
        when "01110111" => sub := "11110101";
        when "01111000" => sub := "10111100";
        when "01111001" => sub := "10110110";
        when "01111010" => sub := "11011010";
        when "01111011" => sub := "00100001";
        when "01111100" => sub := "00010000";
        when "01111101" => sub := "11111111";
        when "01111110" => sub := "11110011";
        when "01111111" => sub := "11010010";
        when "10000000" => sub := "11001101";
        when "10000001" => sub := "00001100";
        when "10000010" => sub := "00010011";
        when "10000011" => sub := "11101100";
        when "10000100" => sub := "01011111";
        when "10000101" => sub := "10010111";
        when "10000110" => sub := "01000100";
        when "10000111" => sub := "00010111";
        when "10001000" => sub := "11000100";
        when "10001001" => sub := "10100111";
        when "10001010" => sub := "01111110";
        when "10001011" => sub := "00111101";
        when "10001100" => sub := "01100100";
        when "10001101" => sub := "01011101";
        when "10001110" => sub := "00011001";
        when "10001111" => sub := "01110011";
        when "10010000" => sub := "01100000";
        when "10010001" => sub := "10000001";
        when "10010010" => sub := "01001111";
        when "10010011" => sub := "11011100";
        when "10010100" => sub := "00100010";
        when "10010101" => sub := "00101010";
        when "10010110" => sub := "10010000";
        when "10010111" => sub := "10001000";
        when "10011000" => sub := "01000110";
        when "10011001" => sub := "11101110";
        when "10011010" => sub := "10111000";
        when "10011011" => sub := "00010100";
        when "10011100" => sub := "11011110";
        when "10011101" => sub := "01011110";
        when "10011110" => sub := "00001011";
        when "10011111" => sub := "11011011";
        when "10100000" => sub := "11100000";
        when "10100001" => sub := "00110010";
        when "10100010" => sub := "00111010";
        when "10100011" => sub := "00001010";
        when "10100100" => sub := "01001001";
        when "10100101" => sub := "00000110";
        when "10100110" => sub := "00100100";
        when "10100111" => sub := "01011100";
        when "10101000" => sub := "11000010";
        when "10101001" => sub := "11010011";
        when "10101010" => sub := "10101100";
        when "10101011" => sub := "01100010";
        when "10101100" => sub := "10010001";
        when "10101101" => sub := "10010101";
        when "10101110" => sub := "11100100";
        when "10101111" => sub := "01111001";
        when "10110000" => sub := "11100111";
        when "10110001" => sub := "11001000";
        when "10110010" => sub := "00110111";
        when "10110011" => sub := "01101101";
        when "10110100" => sub := "10001101";
        when "10110101" => sub := "11010101";
        when "10110110" => sub := "01001110";
        when "10110111" => sub := "10101001";
        when "10111000" => sub := "01101100";
        when "10111001" => sub := "01010110";
        when "10111010" => sub := "11110100";
        when "10111011" => sub := "11101010";
        when "10111100" => sub := "01100101";
        when "10111101" => sub := "01111010";
        when "10111110" => sub := "10101110";
        when "10111111" => sub := "00001000";
        when "11000000" => sub := "10111010";
        when "11000001" => sub := "01111000";
        when "11000010" => sub := "00100101";
        when "11000011" => sub := "00101110";
        when "11000100" => sub := "00011100";
        when "11000101" => sub := "10100110";
        when "11000110" => sub := "10110100";
        when "11000111" => sub := "11000110";
        when "11001000" => sub := "11101000";
        when "11001001" => sub := "11011101";
        when "11001010" => sub := "01110100";
        when "11001011" => sub := "00011111";
        when "11001100" => sub := "01001011";
        when "11001101" => sub := "10111101";
        when "11001110" => sub := "10001011";
        when "11001111" => sub := "10001010";
        when "11010000" => sub := "01110000";
        when "11010001" => sub := "00111110";
        when "11010010" => sub := "10110101";
        when "11010011" => sub := "01100110";
        when "11010100" => sub := "01001000";
        when "11010101" => sub := "00000011";
        when "11010110" => sub := "11110110";
        when "11010111" => sub := "00001110";
        when "11011000" => sub := "01100001";
        when "11011001" => sub := "00110101";
        when "11011010" => sub := "01010111";
        when "11011011" => sub := "10111001";
        when "11011100" => sub := "10000110";
        when "11011101" => sub := "11000001";
        when "11011110" => sub := "00011101";
        when "11011111" => sub := "10011110";
        when "11100000" => sub := "11100001";
        when "11100001" => sub := "11111000";
        when "11100010" => sub := "10011000";
        when "11100011" => sub := "00010001";
        when "11100100" => sub := "01101001";
        when "11100101" => sub := "11011001";
        when "11100110" => sub := "10001110";
        when "11100111" => sub := "10010100";
        when "11101000" => sub := "10011011";
        when "11101001" => sub := "00011110";
        when "11101010" => sub := "10000111";
        when "11101011" => sub := "11101001";
        when "11101100" => sub := "11001110";
        when "11101101" => sub := "01010101";
        when "11101110" => sub := "00101000";
        when "11101111" => sub := "11011111";
        when "11110000" => sub := "10001100";
        when "11110001" => sub := "10100001";
        when "11110010" => sub := "10001001";
        when "11110011" => sub := "00001101";
        when "11110100" => sub := "10111111";
        when "11110101" => sub := "11100110";
        when "11110110" => sub := "01000010";
        when "11110111" => sub := "01101000";
        when "11111000" => sub := "01000001";
        when "11111001" => sub := "10011001";
        when "11111010" => sub := "00101101";
        when "11111011" => sub := "00001111";
        when "11111100" => sub := "10110000";
        when "11111101" => sub := "01010100";
        when "11111110" => sub := "10111011";
        when "11111111" => sub := "00010110";
        when others		=> sub := "00000000";
      end case;

    return sub;
     
end function SBOX;

function MULT_EN
(a: std_logic_vector(7 downto 0); b : std_logic_vector(7 downto 0) )
return std_logic_vector is
    variable temp     : std_logic_vector(7 downto 0);
    variable temp1    : std_logic_vector(7 downto 0);
    variable temp2    : std_logic_vector(7 downto 0);
    variable temp3    : std_logic_vector(7 downto 0);
    variable and_mask : std_logic_vector(7 downto 0);
begin

    and_mask := b(7) & b(7) & b(7) & b(7) & b(7) & b(7) & b(7) & b(7);

    case a(3 downto 0) is
        when "0001" => temp := b;
        when "0010" =>temp := b(6 downto 0) & '0' xor (("00011011") and and_mask);
        when "0011"=> temp := b(6 downto 0) & '0' xor (("00011011") and and_mask) xor b;
        when others => temp := (others => '0');
    end case;

return temp;
end function MULT_EN; 

signal curr_sboxed	: std_logic_vector(127 downto 0);
signal curr_shifted : std_logic_vector(127 downto 0);
signal curr_mixed   : std_logic_vector(127 downto 0);

signal B0			: std_logic_vector(7 downto 0);
signal B1			: std_logic_vector(7 downto 0);
signal B2			: std_logic_vector(7 downto 0);
signal B3			: std_logic_vector(7 downto 0);
signal B4			: std_logic_vector(7 downto 0);
signal B5			: std_logic_vector(7 downto 0);
signal B6			: std_logic_vector(7 downto 0);
signal B7			: std_logic_vector(7 downto 0);
signal B8			: std_logic_vector(7 downto 0);
signal B9			: std_logic_vector(7 downto 0);
signal B10			: std_logic_vector(7 downto 0);
signal B11			: std_logic_vector(7 downto 0);
signal B12			: std_logic_vector(7 downto 0);
signal B13			: std_logic_vector(7 downto 0);
signal B14			: std_logic_vector(7 downto 0);
signal B15			: std_logic_vector(7 downto 0);

signal data_encrypted_setter : std_logic := '0';

begin
	data_encrypted <= data_encrypted_setter;
	
    process
	begin
        if data_ready = '1' then
            --SBOX
            curr_sboxed(7   downto 0 )  <= SBOX(cipher(7   downto 0 ));
            curr_sboxed(15  downto 8 )  <= SBOX(cipher(15  downto 8 ));
            curr_sboxed(23  downto 16)  <= SBOX(cipher(23  downto 16));
            curr_sboxed(31  downto 24)  <= SBOX(cipher(31  downto 24));

            curr_sboxed(39  downto 32)  <= SBOX(cipher(39  downto 32));
            curr_sboxed(47  downto 40)  <= SBOX(cipher(47  downto 40));
            curr_sboxed(55  downto 48)  <= SBOX(cipher(55  downto 48));
            curr_sboxed(63  downto 56)  <= SBOX(cipher(63  downto 56));

            curr_sboxed(71  downto 64)  <= SBOX(cipher(71  downto 64));
            curr_sboxed(79  downto 72)  <= SBOX(cipher(79  downto 72));
            curr_sboxed(87  downto 80)  <= SBOX(cipher(87  downto 80));
            curr_sboxed(95  downto 88)  <= SBOX(cipher(95  downto 88));

            curr_sboxed(103 downto 96)  <= SBOX(cipher(103 downto 96));
            curr_sboxed(111 downto 104) <= SBOX(cipher(111 downto 104));
            curr_sboxed(119 downto 112) <= SBOX(cipher(119 downto 112));
            curr_sboxed(127 downto 120) <= SBOX(cipher(127 downto 120));

            wait for 100 ns;

            --ROW SHIFT
            curr_shifted(7 downto 0)     <= curr_sboxed(7 downto 0);
            curr_shifted(15 downto 8)    <= curr_sboxed(47 downto 40);
            curr_shifted(23 downto 16)   <= curr_sboxed(87 downto 80);
            curr_shifted(31 downto 24)   <= curr_sboxed(127 downto 120);

            curr_shifted(39 downto 32)   <= curr_sboxed(39 downto 32);
            curr_shifted(47 downto 40)   <= curr_sboxed(79 downto 72);
            curr_shifted(55 downto 48)   <= curr_sboxed(119 downto 112);
            curr_shifted(63 downto 56)   <= curr_sboxed(31 downto 24);

            curr_shifted(71 downto 64)   <= curr_sboxed(71 downto 64);
            curr_shifted(79 downto 72)   <= curr_sboxed(111 downto 104);
            curr_shifted(87 downto 80)   <= curr_sboxed(23 downto 16);
            curr_shifted(95 downto 88)   <= curr_sboxed(63 downto 56);

            curr_shifted(103 downto 96)  <= curr_sboxed(103 downto 96);
            curr_shifted(111 downto 104) <= curr_sboxed(15 downto 8);
            curr_shifted(119 downto 112) <= curr_sboxed(55 downto 48);
            curr_shifted(127 downto 120) <= curr_sboxed(95 downto 88);
            
            wait for 100 ns;

            --MULT COLS
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

            curr_mixed(127 downto 120) <= MULT_EN("00000010", B0) xor
                                       MULT_EN("00000011", B1) xor
                                       B2 xor B3;
            curr_mixed(119 downto 112) <= B0 xor MULT_EN("00000010", B1)
                                       xor MULT_EN("00000011", B2)
                                       xor B3;
            curr_mixed(111 downto 104) <= MULT_EN("00000010" , B2) xor
                                       MULT_EN("00000011", B3) xor
                                       B0 xor B1;
            curr_mixed(103 downto 96) <= MULT_EN("00000011" , B0) xor
                                       MULT_EN("00000010", B3) xor
                                       B1 xor B2;
            curr_mixed(95 downto 88) <= MULT_EN("00000010" , B4) xor
                                       MULT_EN("00000011", B5) xor
                                       B6 xor B7;
            curr_mixed(87 downto 80) <= MULT_EN("00000010" , B5) xor
                                       MULT_EN("00000011" , B6) xor
                                       B4 xor B7;
            curr_mixed(79 downto 72) <= MULT_EN("00000010" , B6) xor
                                       MULT_EN("00000011", B7) xor
                                       B4 xor B5;
            curr_mixed(71 downto 64) <= MULT_EN("00000011" , B4) xor
                                       MULT_EN("00000010", B7) xor
                                       B5 xor B6;
            curr_mixed(63 downto 56) <= MULT_EN("00000010", B8) xor
                                       MULT_EN("00000011", B9) xor
                                       B10 xor B11;
            curr_mixed(55 downto 48) <= MULT_EN("00000010", B9) xor
                                       MULT_EN("00000011", B10) xor
                                       B8 xor B11;
            curr_mixed(47 downto 40) <= MULT_EN("00000010", B10) xor
                                       MULT_EN("00000011", B11) xor
                                       B8 xor B9;
            curr_mixed(39 downto 32) <= MULT_EN("00000011", B8) xor
                                       MULT_EN("00000010", B11) xor
                                       B9 xor B10;
            curr_mixed(31 downto 24) <= MULT_EN("00000010", B12) xor
                                       MULT_EN("00000011", B13) xor
                                       B14 xor B15;
            curr_mixed(23 downto 16) <= MULT_EN("00000010",B13) xor
                                       MULT_EN("00000011",B14) xor
                                       B12 xor B15;
            curr_mixed(15 downto 8)  <= MULT_EN("00000010", B14) xor
                                     MULT_EN("00000011", B15) xor
                                     B12 xor B13;
            curr_mixed(7 downto 0)   <= MULT_EN("00000011", B12) xor
                                     MULT_EN("00000010", B15) xor
                                     B13 xor B14;
            wait for 100 ns;

            cipher <= curr_mixed;

           data_encrypted_setter <= '1';
        end if;
    end process;
end;
