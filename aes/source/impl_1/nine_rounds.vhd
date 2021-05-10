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
    clk    : in std_logic;
    plain  : in  std_logic_vector(127 downto 0);
    cipher : out std_logic_vector(127 downto 0);

	data_ready	 : in std_logic;
	data_encrypted_0 : out std_logic
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
		cipher : out std_logic_vector(127 downto 0);

        data_ready	 : in std_logic;
        data_encrypted_1 : out std_logic
	);
end component;

signal curr_sboxed	: std_logic_vector(127 downto 0);

signal curr_shifted : std_logic_vector(127 downto 0);

signal data_encrypted_0 : std_logic;
signal data_encrypted_1 : std_logic;

begin

    -- plain text xord 1st
    sbx : sbox port map(clk => clk,
                        plain => plain,
                        cipher => curr_sboxed,
                        data_ready => data_ready,
                        data_encrypted_0 => data_encrypted_0);

	shf : row_shift port map(plain => curr_sboxed, cipher => cipher);
	data_encrypted_1 <= '1';
	-- shf : row_shift port map(plain => curr_sboxed, cipher => curr_shifted);
    --mxc : mix_cols port map(clk => clk,
    --                       plain => curr_shifted,
    --                        cipher => cipher,
    --                        data_ready => data_ready,
    --                        data_encrypted_1 => data_encrypted_1);

    -- state ciph xord

    data_encrypted <= data_encrypted_0 and data_encrypted_1;

  --add_round_key
end;
