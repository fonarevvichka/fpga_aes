/* code based on that found at 
https://web.csulb.edu/projects/npu/Rijndael_AES/AES_FULL/s_box_4.vhd
*/

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity sbox_4 is
port(
    s_box_4_in    :	in  std_logic_vector(31 downto 0);
    s_box_4_out   :	out std_logic_vector(31 downto 0)
    );
end s_box_4;

architecture synth of sbox_4 is
--component instantiation
component sbox 
port(
    fs_box_in    :	in  std_logic_vector(7 downto 0);
    fs_box_out   :	out std_logic_vector(7 downto 0)
    );
end component;

begin
--generating 4 s-boxes 
sbox_4: for i in 3 downto 0 generate
    sbox_map:	sbox
    port map(
	    fs_box_in => s_box_4_in(8*i+7 downto 8*i),
	    fs_box_out => s_box_4_out(8*i+7 downto 8*i)
	    );
end generate sbox_4;	    
end synth;