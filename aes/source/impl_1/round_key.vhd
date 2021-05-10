library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity round_key is
  port (
    prev_key    : in  std_logic_vector(127 downto 0);
    round       : in integer;
    round_key   : out std_logic_vector(127 downto 0)
  );
end round_key;

architecture synth of round_key is 

  component rcon is 
    port(
      addr : unsigned(7 downto 0);
      val  : std_logic_vector(7 downto 0)
    );
  end component;

  component sbox is 
    port(
      addr : unsigned(7 downto 0);
      val  : std_logic_vector(7 downto 0)
    );
  end component;
  
  signal val  : std_logic_vector(7 downto 0);
  signal rot_temp : std_logic_vector(31 downto 0);
  signal sub_temp : std_logic_vector(31 downto 0);

begin
 
  rcon : rcon port map(addr => "00000001", val => val);
  s1 : sbox port map(addr => rot_temp(7 downto 0), val => sub_temp(7 downto 0));
  s2 : sbox port map(addr => rot_temp(15 downto 8), val => sub_temp(15 downto 8));
  s3 : sbox port map(addr => rot_temp(23 downto 16), val => sub_temp(23 downto 16));
  s4 : sbox port map(addr => rot_temp(31 downto 24), val => sub_temp(31 downto 24));
  
  
  process (all)
  begin
  
    if round < 4 then
      round_key <= prev_key
    elsif round = 4 then
      -- RotWord(), shift each 32-bit word of previous key once to the left
      rot_temp <= prev_key(63 downto 32) & prev_key(95 downto 64) & prev_key(127 downto 96) & prev_key(31 downto 0);
  
      --SubWord(), use each 32-bit word in temp to lookup in S-Box and make a new 128 bit key
      temp <= 
      
    end if;
  
  end process;
end;



  