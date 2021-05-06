library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity nine_rounds is
  port(
    clk    : in std_logic;
	plain  : in std_logic_vector(127 downto 0);
	cipher : out std_logic_vector(127 downto 0)
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

signal input     : STD_LOGIC_VECTOR(127 downto 0) := (others => '0');

signal curr_0    : unsigned(127 downto 0) := (others => '0');

signal curr_byte : unsigned(7 downto 0);

signal subd_byte : unsigned(7 downto 0);

signal counter   : unsigned(15 downto 0) := (others => '0');

begin

  -- sbx
  -- or have counter increment by 8
  curr_byte <= unsigned(input((to_integer(127 - counter)) downto (to_integer(120 - counter))));

  sbx : sbox port map(addr => curr_byte, sub => subd_byte);

  curr_0(to_integer(127-counter) downto to_integer(120-counter)) <= subd_byte;

  -- shf --> updated(state)
  process (clk) is 
  begin
      if rising_edge(clk) then
        counter <= counter + X"08"; 
      end if;
  end process;
    
  -- shf
  --> in place, won't have to access ROM
  --> iterate through flattened array

  --mix columns 
  --> ROM module for multiplying degree 8 polynomials
  
  --add_round_key

end;
