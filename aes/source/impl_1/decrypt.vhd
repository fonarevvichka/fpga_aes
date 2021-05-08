library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Decrypt is
  port(
	reset			: in std_logic;
	controller_clk	: in std_logic;
	COPI			: in std_logic;
	CS				: in std_logic;
	CIPO			: out std_logic;
	led				: out std_logic;
	data_ready		: out std_logic
  );
end Decrypt;

architecture synth of Decrypt is

-- component key_schedule is

-- component initial_key_add is

	component r_nine_rounds is
	  port(
		clk    			: in std_logic;
		cipher  		: in std_logic_vector(127 downto 0);
		plain 			: out std_logic_vector(127 downto 0);
		data_ready		: in std_logic;
		data_decrypted 	: out std_logic
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
            CLKHF_DIV : String := "0b00"
        ); -- Divide 48MHz clock by 2^N (0-3)
        port(
            CLKHFPU : in std_logic	:= 'X'; -- Set to 1 to power up
            CLKHFEN : in std_logic	:= 'X'; -- Set to 1 to enable output
            CLKHF   : out std_logic := 'X' -- Clock output
        ); 
    end component;
  
-- component last_round is

	signal clk				: std_logic;
	
	signal curr				: STD_LOGIC_VECTOR(127 downto 0);
	signal plain			: std_logic_vector(127 downto 0) := 128d"0";
	signal rw_enable		: std_logic;
	
	signal data_received	: std_logic;
	signal data_decrypted	: std_logic := '0';
	
	signal ciphertext			: std_logic_vector(127 downto 0);
	signal decrypted			: std_logic_vector(127 downto 0);
	
	signal ciphertext_temp		: std_logic_vector(127 downto 0);
	signal decrypted_temp		: std_logic_vector(127 downto 0);
begin
	--led <= COPI;
	rw_enable	<= data_decrypted;
	data_ready	<= rw_enable;
	
	-- process (clk) begin
	-- 	if rising_edge(clk) then
	-- 		if (data_received = '1') then
	-- 			plaintext <= plaintext_temp;
	-- 		else
	-- 			plaintext <=
    --         end if;
			
		--end if;
	--end process;
	
	spi_periph	: spi_peripheral port map (	clk				=> clk,
											reset 			=> reset,
											controller_clk	=> controller_clk,
											COPI 			=> COPI,
											CS				=> CS,
											CIPO			=> CIPO,
											data_ready		=> data_received,
											rw_enable		=> rw_enable,
											data_out		=> ciphertext,
											data_in			=> decrypted,
											led             => led
										);					
	nr			: r_nine_rounds	port map (clk => clk, cipher => ciphertext,
                                          plain => decrypted,
                                          data_ready => data_received,
                                          data_decrypted => data_decrypted);
	
	H			: HSOSC			port map (CLKHFPU => '1', CLKHFEN => '1', CLKHF => clk);
end;
	