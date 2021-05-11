library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Encrypt is
  port(
	reset			: in std_logic;
	controller_clk	: in std_logic;
	COPI			: in std_logic;
	CS				: in std_logic;
	CIPO			: out std_logic;
	led				: out std_logic;
	data_ready		: out std_logic
  );
end Encrypt;

architecture synth of Encrypt is

-- component key_schedule is

	component nine_rounds is
	  port(
		clk    			: in std_logic;
		plain  			: in std_logic_vector(127 downto 0);
		cipher 			: out std_logic_vector(127 downto 0);
		data_ready		: in std_logic;
		data_encrypted 	: out std_logic
	  );
	end component;

	component spi_peripheral is
		port(
			clk				: in std_logic;
			reset			: in std_logic;
			controller_clk	: in std_logic;
			COPI			: in std_logic;
			CS				: in std_logic;
			CIPO			: out std_logic;
			data_ready      : out std_logic;
			rw_enable   	: in std_logic;
			data_out		: out std_logic_vector(127 downto 0);
			data_in			: in std_logic_vector(127 downto 0);
			led             : out std_logic
		);
	end component;

	component HSOSC is
        generic (
            CLKHF_DIV : String := "0b11"
        ); -- Divide 48MHz clock by 2^N (0-3)
        port(
            CLKHFPU : in std_logic	:= 'X'; -- Set to 1 to power up
            CLKHFEN : in std_logic	:= 'X'; -- Set to 1 to enable output
            CLKHF   : out std_logic := 'X'  -- Clock output
        );
    end component;

	signal clk				: std_logic;

	signal rw_enable		: std_logic;

	signal data_received	: std_logic;
	signal data_encrypted	: std_logic;

	signal plaintext		: std_logic_vector(127 downto 0);
	signal encrypted		: std_logic_vector(127 downto 0);

begin
	rw_enable	<= data_encrypted;
	data_ready	<= rw_enable;

	spi_periph	: spi_peripheral port map (	clk				=> clk,
											reset 			=> reset,
											controller_clk	=> controller_clk,
											COPI 			=> COPI,
											CS				=> CS,
											CIPO			=> CIPO,
											data_ready		=> data_received,
											rw_enable		=> rw_enable,
											data_out		=> plaintext,
											data_in			=> encrypted,
											led             => led
										);

    signal key0 : std_logic_vector(127 downto 0);
    signal init_key : std_logic_vector(127 downto 0)
    := "10101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010";
    key : round_key port map(key_in => init_key, key_out => key0,
                             e_or_d => '0', round_num => 0);
    plain <= plain xor key0;

	  nr  : nine_rounds	port map (clk => clk, plain => plaintext,
										  cipher => encrypted, curr_key => key0
										  data_ready => data_received,
										  data_encrypted => data_encrypted);

	H			: HSOSC			port map (CLKHFPU => '1', CLKHFEN => '1', CLKHF => clk);
end;
