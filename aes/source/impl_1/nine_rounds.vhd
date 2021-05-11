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
    --clk    : in std_logic;
    plain  : in  std_logic_vector(127 downto 0);
    cipher : out std_logic_vector(127 downto 0)

	--data_ready	 : in std_logic;
	--data_encrypted_0 : out std_logic
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
		plain  : in  std_logic_vector(127 downto 0);
		cipher : out std_logic_vector(127 downto 0)

		--clk    : in std_logic;
        --data_ready	 : in std_logic;
        --data_encrypted_1 : out std_logic
	);
end component;

signal curr_sboxed	: std_logic_vector(127 downto 0);
signal curr_shifted : std_logic_vector(127 downto 0);

begin
    --sbx : sbox port map(plain => plain,
						--cipher => curr_sboxed);
						
	shf : row_shift port map(plain => plain, cipher => curr_shifted);
	
    mxc : mix_cols port map(plain => curr_shifted,
                           cipher => cipher);
	data_encrypted <= '1';
end;
