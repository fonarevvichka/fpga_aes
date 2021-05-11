/* code based on that found at 
https://web.csulb.edu/projects/npu/Rijndael_AES/AES_FULL/key_schedule.vhd
*/

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity round_key is
port(
    key_in	    :   in  std_logic_vector(127 downto 0);
    key_out	    :   out std_logic_vector(127 downto 0);
    e_or_d          :   in  std_logic;       --encrypt is 0 decrypt is 1
    round_num  :	in  std_logic_vector(7 downto 0);
    );
end round_key;

architecture synth of round_key is

component s_box_4 
port(
    s_box_4_in    :	in  std_logic_vector(31 downto 0);
    s_box_4_out   :	out std_logic_vector(31 downto 0)
    );
end component;

component rcon_e
port(
    round_num  : in  unsigned(7 downto 0);
    val   : out std_logic_vector(7 downto 0)
    );
end component;

component rcon_d
port(
    round_num  : in  unsigned(7 downto 0);
    val   : out std_logic_vector(7 downto 0)
    );
end component;

signal U          : std_logic_vector(31 downto 0);
signal left_shift : std_logic_vector(31 downto 0);
signal sbox       : std_logic_vector(31 downto 0);

signal next_key    : std_logic_vector(127 downto 0);
signal key_reg_out : std_logic_vector(127 downto 0);
signal upperbyte   : std_logic_vector(7 downto 0);
signal round_constant_e : std_logic_vector(7 downto 0);
signal round_constant_d : std_logic_vector(7 downto 0);

type word_array is array (3 downto 0) of std_logic_vector(31 downto 0); 
signal key_word, next_key_word : word_array;

begin

r_constant_e : rcon_e port map(addr => round_num, val => round_constant_e);
r_constant_d : rcon_d port map(addr => round_num, val => round_constant_d);
round_constant <= round_constant_e when e_or_d = '0' else 
                  round_constant_d;

key_reg_out <= key_in when round_num = "00000000" else --1st round
	      next_key;

key_word(0) <= key_reg_out(127 downto 96);
key_word(1) <= key_reg_out(95 downto 64);
key_word(2) <= key_reg_out(63 downto 32);
key_word(3) <= key_reg_out(31 downto 0);

--calculating the next key words

 next_key_word(3) <= key_word(3) xor key_word(2) when e_or_d='1' else
                     key_word(3) xor key_word(2) xor key_word(1) xor key_word(0)
 xor U;
 next_key_word(2) <= key_word(2) xor key_word(1) when e_or_d='1' else
                      key_word(2) xor key_word(1) xor key_word(0) xor U;
 next_key_word(1) <= key_word(1) xor key_word(0) when e_or_d='1' else
                       key_word(1) xor key_word(0) xor U;
 next_key_word(0) <= key_word(0) xor U when e_or_d='1' else
                       key_word(0) xor U;

 next_key <= next_key_word(0) & next_key_word(1) & next_key_word(2) & next_key_word(3);

 -- calculation of U

 left_shift <= (next_key_word(3)(23 downto 16) &
               next_key_word(3)(15 downto 8) &
               next_key_word(3)(7 downto 0) &
               next_key_word(3)(31 downto 24)) when e_or_d ='1' else
               (key_word(3)(23 downto 16) &
               key_word(3)(15 downto 8) &
               key_word(3)(7 downto 0) &
               key_word(3)(31 downto 24));

 --key subbyte transformation

 sbox_q: s_box_4
 port map(
        s_box_4_in   => left_shift,
        s_box_4_out  => sbox
        );

 upperbyte <= sbox(31 downto 24) xor round_constant;

 U <= upperbyte & sbox(23 downto 0);
 
key_out <= key_reg_out;
end synth;