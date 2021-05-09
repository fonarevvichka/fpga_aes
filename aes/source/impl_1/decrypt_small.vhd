library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Decrypt is
  port(
	leds : out std_logic_vector(7 downto 0);
  );
end Decrypt;

architecture synth of Decrypt is

	component r_nine_rounds is
	  port(
		clk    			: in std_logic;
		cipher  		: in std_logic_vector(127 downto 0);
		plain 			: out std_logic_vector(127 downto 0);
		data_ready		: in std_logic;
		data_decrypted 	: out std_logic
	  );
	end component;
	
	component HSOSC is
        generic (
            CLKHF_DIV : String := "0b11"
        ); -- Divide 48MHz clock by 2^N (0-3)
        port(
            CLKHFPU : in std_logic	:= 'X'; -- Set to 1 to power up
            CLKHFEN : in std_logic	:= 'X'; -- Set to 1 to enable output
            CLKHF   : out std_logic := 'X' -- Clock output
        ); 
    end component;
  
	signal clk : std_logic;
	
	signal encrypted : std_logic_vector(127 downto 0);
	signal plaintext : std_logic_vector(127 downto 0) ;
	
begin
										
	nr			: r_nine_rounds	port map (clk => clk, cipher => encrypted,
                                          plain => plaintext,
                                          data_ready => data_received,
                                          data_decrypted => data_decrypted);
	
	H			: HSOSC			port map (CLKHFPU => '1', CLKHFEN => '1', CLKHF => clk);
end;
	
