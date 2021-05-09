library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Encrypt is
  port(
	led : out std_logic_vector(7 downto 0);
  );
end Encrypt;

architecture synth of Encrypt is

	component nine_rounds is
	  port(
		clk    			: in std_logic;
		plain  			: in std_logic_vector(127 downto 0);
		cipher 			: out std_logic_vector(127 downto 0);
		data_ready		: in std_logic;
		data_encrypted 	: out std_logic
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

	signal clk : std_logic;
	
	signal plaintext : std_logic_vector(127 downto 0);
	signal encrypted : std_logic_vector(127 downto 0);
	
begin

	nr : nine_rounds	port map (clk => clk, plain => plaintext,
										  cipher => encrypted,
										  data_ready => data_received,
										  data_encrypted => data_encrypted);
	
	H : HSOSC			port map (CLKHFPU => '1', CLKHFEN => '1', CLKHF => clk);
end;
	
