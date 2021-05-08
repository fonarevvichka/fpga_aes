library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Decrypt is
  port(
    cipher  : in  std_logic_vector(127 downto 0);
    plain : out std_logic_vector(127 downto 0)
  );
end Decrypt;

architecture synth of Decrypt is

-- component key_schedule is

-- component initial_key_add is

	component r_nine_rounds is
	  port(
		clk    			: in std_logic;
		cipher  		: in std_logic_vector(127 downto 0);
		plain 			: out std_logic_vector(127 downto 0)
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
	
begin
	
	-- process (clk) begin
	-- 	if rising_edge(clk) then
	-- 		if (data_received = '1') then
	-- 			plaintext <= plaintext_temp;
	-- 		else
	-- 			plaintext <=
    --         end if;
			
		--end if;
	--end process;
	
	nr			: r_nine_rounds	port map (clk => clk, cipher => cipher,
                                          plain => plain);
	
	H			: HSOSC			port map (CLKHFPU => '1', CLKHFEN => '1', CLKHF => clk);
end;
	
