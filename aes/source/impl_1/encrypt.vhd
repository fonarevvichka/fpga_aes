library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Encrypt is
  port(
    clk    : in std_logic;
	plain  : in std_logic_vector(127 downto 0);
	cipher : out std_logic_vector(127 downto 0)
  );
end Encrypt;

architecture synth of Encrypt is

-- component key_schedule is

-- component initial_key_add is

	component nine_rounds is
	  port(
		clk    : in std_logic;
		plain  : in std_logic_vector(127 downto 0);
		cipher : out std_logic_vector(127 downto 0)
	  );
	end component;
  
-- component last_round is

	signal curr : STD_LOGIC_VECTOR(127 downto 0);

begin

	process (clk) begin
		if rising_edge(clk) then
			
		end if;
	end process;
	
	nr : nine_rounds port map (clk => clk, plain => plain, cipher => curr);
end;
	
