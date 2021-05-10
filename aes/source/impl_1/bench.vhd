library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity test_bench is
    port(
        encr : out std_logic_vector(7 downto 0)
    );
end test_bench;

architecture synth of test_bench is

    component Encrypt_sm is
	  port(
	    plain : in std_logic_vector(127 downto 0);
	    cipher : out std_logic_vector(127 downto 0)
		);
	end component;

	--signal plain : std_logic_vector(127 downto 0) := "01010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101";
    signal plain  : std_logic_vector(127 downto 0) := 128d"0";
    signal cipher : std_logic_vector(127 downto 0);
begin

    enc : Encrypt_sm port map(plain => plain, cipher => cipher);

    encr <= cipher(119 downto 112);

end;
