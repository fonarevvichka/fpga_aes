library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity r_nine_rounds is
  port(
    clk    			: in std_logic;
	cipher 			: in std_logic_vector(127 downto 0);
	plain 			: out std_logic_vector(127 downto 0);
	data_ready		: in std_logic;
	data_decrypted 	: out std_logic
  );
end r_nine_rounds;

architecture synth of r_nine_rounds is

component r_sbox is
  port (
    --address is 1 byte into a lookup table where most significant nibble is the row, 
    --least significant nibble is the column
    addr : in  unsigned(7 downto 0);
	sub  : out std_logic_vector(7 downto 0)
  );
end component;

component r_row_shift is
  port (
	cipher : in std_logic_vector(127 downto 0);
	plain  : out  std_logic_vector(127 downto 0)
  );
end component;

--signals for S Box
signal curr_byte : unsigned(7 downto 0);
signal subd_byte : std_logic_vector(7 downto 0);
signal counter     : unsigned(15 downto 0) := (others => '0');
signal curr_sboxed : std_logic_vector(127 downto 0);

begin

  -- sbx
  -- or have counter increment by 8
	curr_byte <= unsigned(cipher((to_integer(127 - counter)) downto (to_integer(120 - counter))));
	rsbx : r_sbox port map(addr => curr_byte, sub => subd_byte);

	curr_sboxed(to_integer(127-counter) downto to_integer(120-counter)) <= subd_byte;

	rshf : r_row_shift port map(cipher => curr_sboxed, plain => plain);

	data_decrypted <= counter(15);

    process (clk) is 
    begin
        if rising_edge(clk) then
	    	if (data_ready = '1') then
	    		counter <= counter + X"08"; 
     		end if;
        end if;
    end process;
        
  --mix columns 
  --> ROM module for multiplying degree 8 polynomials
  
  --add_round_key

end;
