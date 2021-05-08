library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity spi_peripheral is
    port (
		clk				: in std_logic;
        reset			: in std_logic;
        controller_clk	: in std_logic;
        COPI			: in std_logic;
        CS				: in std_logic;
        CIPO			: out std_logic;
        data_ready      : out std_logic;
		rw_enable   	: in std_logic;
		data_out		: out std_logic_vector(127 downto 0);
		data_in			: in std_logic_vector(127 downto 0);
        led             : out std_logic
    );
end spi_peripheral;

architecture synth of spi_peripheral is
    signal controller_clk_last 		: std_logic := '0';
    signal controller_clk_last_last	: std_logic := '0';
    signal read_spi					: std_logic;
    
    -- signal shiftreg			        : std_logic_vector(127 downto 0) := 128d"0";
    signal bit_counter				: unsigned (3 downto 0) := 4d"0";
    signal byte_counter				: unsigned (4 downto 0) := 5d"0";
    
    type State is (READ, WRITE, IDLE);
    signal s : State := IDLE;

begin
    read_spi	<= controller_clk_last and (not controller_clk_last_last); -- clock crossing SPI edge detection
    -- led_array	<= shiftreg(127 downto 120);
	led			<= '1' when (s = WRITE) else '0';
	--data_out	<= shiftreg; 
    process (clk) begin
        if (reset = '1') then
            data_out        <= 128d"0";
            bit_counter		<= 4d"0";
            byte_counter	<= 5d"0";
        elsif rising_edge(clk) then
            controller_clk_last <= controller_clk;
            controller_clk_last_last <= controller_clk_last;

            if (cs = '0') then
                if (read_spi = '1') then
                    bit_counter						<= bit_counter + 1;                 

                    case s is
                        when READ =>
							data_out(126 downto 0)		<= data_out(127 downto 1);
							data_out(127)            	<= COPI;
							
                            if (bit_counter = "0111") then -- read 8 bits
                                byte_counter	<= byte_counter + 1;
                            end if;

							CIPO <= COPI; -- 1 is recieved. i guess
						when WRITE =>
                            if (bit_counter = "0111") then -- wrote 8 bits
                                byte_counter	<= byte_counter - 1;
                            end if;
							
							CIPO	<= data_in((128 - (8 * (to_integer(byte_counter)))) + to_integer(bit_counter));
                            --CIPO <= '1';
						when others =>
							CIPO <= '1';
                    end case;
                end if;
            else
                bit_counter <= 4d"0";
            end if;

            case s is
                when IDLE =>
                    data_ready <= '0';
                    s <= READ;
                when READ =>
                    if (byte_counter = "10000") then
                        data_ready <= '1';
                    end if;

                    if (data_ready = '1' and rw_enable = '1') then
                        s <= WRITE;
                    end if;
                when WRITE =>
                    if (byte_counter = 5d"0") then -- transmitted all data back
                        s	<= IDLE;
                    end if;
            end case;
        end if;
    end process;
end;