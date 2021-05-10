library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity r_sbox is
  port (
    clk    : in std_logic;
    cipher : in  std_logic_vector(127 downto 0);
    plain  : out std_logic_vector(127 downto 0);

	data_ready	 : in std_logic;
	data_decrypted_0 : out std_logic
  );
end r_sbox;

architecture synth of r_sbox is

component r_sbox_rom is
  port (
    addr : in  unsigned(7 downto 0);
	sub  : out std_logic_vector(7 downto 0)
  );
end component;

signal addr        	: unsigned(7 downto 0);
signal subd_byte  	: std_logic_vector(7 downto 0);
signal counter		: integer range 0 to 15 := 0;

begin
	addr <= unsigned(cipher(127 - (counter * 8) downto 120 - (counter * 8)));
	
	rsbx : r_sbox_rom port map(addr => addr, sub => subd_byte);
    
	plain(127 - (counter*8) downto 120 - (counter*8)) <= subd_byte;

	data_encrypted_0 <= '1' when (counter = 15) else '0';

  	process (clk) is
  	begin
		if rising_edge(clk) then
			if (data_ready = '1') then
				counter <= counter + 1;
			end if;
      	end if;
  	end process;
end;
