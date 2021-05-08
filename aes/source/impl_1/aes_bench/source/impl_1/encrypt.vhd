library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Encrypt is
  port(
    plain  : in  std_logic_vector(127 downto 0);
    cipher : out std_logic_vector(127 downto 0)
  );
end Encrypt;

architecture synth of Encrypt is

-- component key_schedule is

-- component initial_key_add is

	component nine_rounds is
	  port(
		clk    			: in std_logic;
		plain  			: in std_logic_vector(127 downto 0);
		cipher 			: out std_logic_vector(127 downto 0)
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
	
	--signal curr				: STD_LOGIC_VECTOR(127 downto 0);

--	signal plaintext_temp	: std_logic_vector(127 downto 0);
--	signal encrypted_temp	: std_logic_vector(127 downto 0);
begin
	
	nr : nine_rounds port map (clk => clk,
                               plain => plain,
                               cipher => cipher);
	
	H  : HSOSC		 port map (CLKHFPU => '1', CLKHFEN => '1', CLKHF => clk);
end;
