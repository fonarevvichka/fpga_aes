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
        clk    : in std_logic;
        cipher  : in  std_logic_vector(127 downto 0);
        plain : out std_logic_vector(127 downto 0);

    	data_ready	 : in std_logic;
    	data_decrypted_0 : out std_logic
    );
end component;

component r_row_shift is
	port (
		cipher : in std_logic_vector(127 downto 0);
		plain  : out  std_logic_vector(127 downto 0)
	);
end component;

component r_mix_cols is
	port (
        clk    : in std_logic;
		cipher : in std_logic_vector(127 downto 0);
		plain  : out  std_logic_vector(127 downto 0);

        data_ready	 : in std_logic;
        data_decrypted_1 : out std_logic
	);
end component;

signal curr_sboxed	: std_logic_vector(127 downto 0);

signal curr_shifted	: std_logic_vector(127 downto 0);

signal data_decrypted_0 : std_logic;signal data_decrypted_1 : std_logic;

begin
    rsbx : r_sbox port map(clk => clk,
                           cipher => cipher,
                           plain => curr_sboxed,
                           data_ready => data_ready,
                           data_decrypted_0 => data_decrypted_0);

    rshf : r_row_shift port map(cipher => curr_sboxed, plain => curr_shifted);

    rmxc : r_mix_cols port map(clk => clk,
                               cipher => curr_shifted,
                               plain => plain,
                               data_ready => data_ready,
                               data_decrypted_1 => data_decrypted_1);

	data_decrypted <= data_decrypted_1 and data_decrypted_0;

  --add_round_key
end;
