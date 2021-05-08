library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity r_row_shift is
  port (
    plain  : in  std_logic_vector(127 downto 0);
	cipher : out std_logic_vector(127 downto 0)
  );
end r_row_shift;

architecture synth of r_row_shift is

begin

   cipher(7 downto 0)    <= plain(7 downto 0);
   cipher(15 downto 8)   <= plain(111 downto 104);
   cipher(23 downto 16)  <= plain(87 downto 80);
   cipher(31 downto 24)  <= plain(63 downto 56);

   cipher(39 downto 32)  <= plain(39 downto 32);
   cipher(47 downto 40)  <= plain(15 downto 8);
   cipher(55 downto 48)  <= plain(119 downto 112);
   cipher(63 downto 56)  <= plain(95 downto 88);

   cipher(71 downto 64)  <= plain(71 downto 64);
   cipher(79 downto 72)  <= plain(47 downto 40);
   cipher(87 downto 80)  <= plain(23 downto 16);
   cipher(95 downto 88)  <= plain(127 downto 120);

   cipher(103 downto 96)  <= plain(103 downto 96);
   cipher(111 downto 104) <= plain(79 downto 72);
   cipher(119 downto 112) <= plain(55 downto 48);
   cipher(127 downto 120) <= plain(95 downto 88);

end;
