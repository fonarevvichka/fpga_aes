library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity rcon is
  port (
    addr  : in  unsigned(7 downto 0);
    val   : out std_logic_vector(7 downto 0)
  );
end rcon;

architecture synth of rcon is
begin  
    process (all) begin
                case addr is
                        when "00000000" => sub <= "10001110";
                        when "00000001" => sub <= "00000001";
                        when "00000010" => sub <= "00000010";
                        when "00000011" => sub <= "00000100";
                        when "00000100" => sub <= "00001000";
                        when "00000101" => sub <= "00010000";
                        when "00000110" => sub <= "00100000";
                        when "00000111" => sub <= "01000000";
                        when "00001000" => sub <= "10000000";
                        when "00001001" => sub <= "00010001";
                        when "00001010" => sub <= "00110110";
                        when others     => sub <= "00000000";
                end case;
        end process;
end;