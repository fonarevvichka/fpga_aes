library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity nine_rounds is
  port(
    clk    			: in std_logic;
	plain  			: in std_logic_vector(127 downto 0);
	cipher 			: out std_logic_vector(127 downto 0);
	data_ready		: in std_logic;
	data_encrypted 	: out std_logic
  );
end nine_rounds;

architecture synth of nine_rounds is

component sbox is
  port (
    --address is 1 byte into a lookup table where most significant nibble is the row,
    --least significant nibble is the column
    addr : in  unsigned(7 downto 0);
	sub  : out std_logic_vector(7 downto 0)
  );
end component;

component row_shift is
   port (
		plain  : in  std_logic_vector(127 downto 0);
		cipher : out std_logic_vector(127 downto 0)
	);
end component;

component mix_cols is
	port (
	    clk    : in std_logic;
		plain  : in  std_logic_vector(127 downto 0);
		cipher : out std_logic_vector(127 downto 0)
	);
end component;

--Signals for sbox
signal addr        	: unsigned(7 downto 0);
signal subd_byte  	: std_logic_vector(7 downto 0);
signal counter		: integer range 0 to 15 := 0;
signal curr_sboxed	: std_logic_vector(127 downto 0);

--Signals for row_shift
 signal curr_shifted : std_logic_vector(127 downto 0);

begin
  -- sbx
	addr <= unsigned(plain(127 - (counter  * 8) downto 120 - (counter * 8)));
	
	sbx : sbox port map(addr => addr, sub => subd_byte);
    
	curr_sboxed(127 - (counter*8) downto 120 - (counter*8)) <= subd_byte;
    
	shf : row_shift port map(plain => curr_sboxed, cipher => curr_shifted);
	
    mxc : mix_cols port map(clk => clk, plain => curr_shifted, cipher => cipher);

	data_encrypted <= '1' when (counter = 15) else '0';

  	process (clk) is
  	begin
		if rising_edge(clk) then
			if (data_ready = '1') then
				counter <= counter + 1;
			end if;
      	end if;
  	end process;

  -- shf
  --> in place, won't have to access ROM
  --> iterate through flattened array

  --mix columns
  --> ROM module for multiplying degree 8 polynomials

  --add_round_key
end;
