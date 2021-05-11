library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mix_cols is
  port (
    clk    : in std_logic;
    plain  : in  std_logic_vector(127 downto 0);
    cipher : out std_logic_vector(127 downto 0);
	data_ready	 : in std_logic;
	data_encrypted_1 : out std_logic
  );
end mix_cols;

architecture synth of mix_cols is

component row_0 is
  port(
    B0  : in  unsigned(7 downto 0);
    B1  : in  unsigned(7 downto 0);
    B2  : in  unsigned(7 downto 0);
    B3  : in  unsigned(7 downto 0);
    new_B0 : out unsigned(7 downto 0)
  );
end component;

component row_1 is
  port(
    B0  : in  unsigned(7 downto 0);
    B1  : in  unsigned(7 downto 0);
    B2  : in  unsigned(7 downto 0);
    B3  : in  unsigned(7 downto 0);
    new_B1 : out unsigned(7 downto 0)
  );
end component;

component row_2 is
  port(
    B0  : in  unsigned(7 downto 0);
    B1  : in  unsigned(7 downto 0);
    B2  : in  unsigned(7 downto 0);
    B3  : in  unsigned(7 downto 0);
    new_B2 : out unsigned(7 downto 0)
  );
 end component;

component row_3 is
  port(
    B0  : in  unsigned(7 downto 0);
    B1  : in  unsigned(7 downto 0);
    B2  : in  unsigned(7 downto 0);
    B3  : in  unsigned(7 downto 0);
    new_B3 : out unsigned(7 downto 0)
  );
end component;

signal counter : integer range 0 to 4 := 0;

signal new_B0 : unsigned(7 downto 0) := 8d"0";
signal new_B1 : unsigned(7 downto 0) := 8d"0";
signal new_B2 : unsigned(7 downto 0) := 8d"0";
signal new_B3 : unsigned(7 downto 0) := 8d"0";

signal B0 : unsigned(7 downto 0);
signal B1 : unsigned(7 downto 0);
signal B2 : unsigned(7 downto 0);
signal B3 : unsigned(7 downto 0);

begin

    --gets one row of bytes from plain text split into 4Byte X 4Byte matrix

    B0 <= unsigned(plain(7 +(counter*8*4) downto 0 +(counter*8*4)));
    B1 <= unsigned(plain(15+(counter*8*4) downto 8 +(counter*8*4)));
    B2 <= unsigned(plain(23+(counter*8*4) downto 16+(counter*8*4)));
    B3 <= unsigned(plain(31+(counter*8*4) downto 24+(counter*8*4)));

	data_encrypted_1 <= '1' when (counter = 4) else '0';

    process (clk) is
    begin
      if rising_edge(clk) then
        if (data_ready = '1') then
            counter <= counter + 1;
			cipher(7 +(counter*8*4) downto 0 +(counter*8*4)) <= std_logic_vector(new_B0);
			cipher(15+(counter*8*4) downto 8 +(counter*8*4)) <= std_logic_vector(new_B1);
			cipher(23+(counter*8*4) downto 16+(counter*8*4)) <= std_logic_vector(new_B2);
			cipher(31+(counter*8*4) downto 24+(counter*8*4)) <= std_logic_vector(new_B3);
        end if;
      end if;
    end process;
end;
