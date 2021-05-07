library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity test_bench is
    port(
        encr : out std_logic_vector(7 downto 0)
    );
end test_bench;

architecture synth of test_bench is

    component encrypt is
	  port(
	    plain : in std_logic_vector(127 downto 0);
		cipher : out std_logic_vector(127 downto 0)
		);
	end component;
	
    signal plain  : STD_LOGIC_VECTOR(127 downto 0) := (others => '0');
    signal cipher : STD_LOGIC_VECTOR(127 downto 0) := (others => '0');

begin

    enc : Encrypt port map(plain => plain, cipher => cipher);
    
    encr <= cipher(127 downto 120);

end;
