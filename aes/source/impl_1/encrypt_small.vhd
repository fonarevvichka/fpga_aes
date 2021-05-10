library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Encrypt_sm is
  port(
    plain : in std_logic_vector(127 downto 0);
	cipher : out std_logic_vector(127 downto 0)
  );
end Encrypt_sm;

architecture synth of Encrypt_sm is

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
	
	signal r0 : std_logic_vector(127 downto 0);
	signal r1 : std_logic_vector(127 downto 0);
	signal r2 : std_logic_vector(127 downto 0);
	signal r3 : std_logic_vector(127 downto 0);
	signal r4 : std_logic_vector(127 downto 0);
	signal r5 : std_logic_vector(127 downto 0);
	signal r6 : std_logic_vector(127 downto 0);
	signal r7 : std_logic_vector(127 downto 0);

	--signal encrypted : std_logic_vector(127 downto 0);
	
	signal data_encrypted : std_logic;
	
begin
	nr0 : nine_rounds	port map (clk => clk,
                               	  plain => plain,
								  cipher => r0,
								  data_ready => '1',
								  data_encrypted => data_encrypted);
	--nr1 : nine_rounds	port map (clk => clk,
                               	  --plain => r0,
								  --cipher => r1,
								  --data_ready => '1',
								  --data_encrypted => data_encrypted);
	--nr2 : nine_rounds	port map (clk => clk,
                               	  --plain => r1,
								  --cipher => r2,
								  --data_ready => '1',
								  --data_encrypted => data_encrypted);
	--nr3 : nine_rounds	port map (clk => clk,
                               	  --plain => r2,
								  --cipher => r3,
								  --data_ready => '1',
								  --data_encrypted => data_encrypted);
	--nr4 : nine_rounds	port map (clk => clk,
                               	  --plain => r3,
								  --cipher => r4,
								  --data_ready => '1',
								  --data_encrypted => data_encrypted);								  
	--nr5 : nine_rounds	port map (clk => clk,
                               	  --plain => r4,
								  --cipher => r5,
								  --data_ready => '1',
								  --data_encrypted => data_encrypted);
	--nr6 : nine_rounds	port map (clk => clk,
                               	  --plain => r5,
								  --cipher => r6,
								  --data_ready => '1',
								  --data_encrypted => data_encrypted);
	--nr7 : nine_rounds	port map (clk => clk,
                               	  --plain => r6,
								  --cipher => cipher,
								  --data_ready => '1',
								  --data_encrypted => data_encrypted);
	--nr8 : nine_rounds	port map (clk => clk,
								  --plain => r7,
								  --cipher => cipher,
								  --data_ready => '1',
								  --data_encrypted => data_encrypted);
								  
	H : HSOSC			port map (CLKHFPU => '1', CLKHFEN => '1', CLKHF => clk);
end;
	
