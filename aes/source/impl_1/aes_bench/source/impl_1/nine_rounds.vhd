library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity nine_rounds is
  port(
    clk    			: in std_logic;
	plain  			: in std_logic_vector(127 downto 0);
	cipher 			: out std_logic_vector(127 downto 0)
  );
end nine_rounds;

architecture synth of nine_rounds is

component sbox is
  port (
    --address is 1 byte into a lookup table where most significant nibble is the row,
    --least significant nibble is the column
    addr : in  unsigned(7 downto 0);
	sub  : out unsigned(7 downto 0)
  );
end component;

component row_shift is
  port (
    plain  : in  std_logic_vector(127 downto 0);
	cipher : out std_logic_vector(127 downto 0)
  );
end component;

signal curr_0    : std_logic_vector(127 downto 0);

signal curr_byte : unsigned(7 downto 0);
signal subd_byte : unsigned(7 downto 0);

signal counter   : unsigned(15 downto 0) := (others => '0');

begin

  -- sbx
  -- or have counter increment by 8
	curr_byte <= unsigned(plain((to_integer(127 - counter)) downto (to_integer(120 - counter))));
	sbx : sbox port map(addr => curr_byte, sub => subd_byte);

	curr_0(to_integer(127-counter) downto to_integer(120-counter)) <= std_logic_vector(subd_byte);

    shf : row_shift port map(plain => curr_0, cipher => curr_1);


  --data_encrypted <= counter(15);
  -- shf --> updated(state)
  process (clk) is
  begin
      if rising_edge(clk) then
		--if (data_ready = '1') then
			counter <= counter + X"08";
            -- DELAY ALERT
		--end if;
      end if;
  end process;

  -- shf
  --> in place, won't have to access ROM
  --> iterate through flattened array

  --mix columns
  --> ROM module for multiplying degree 8 polynomials

  --add_round_key

end;