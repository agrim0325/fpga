library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity led_blink is
    Port (
        clk  : in  STD_LOGIC;   -- 100 MHz board clock
        rst  : in  STD_LOGIC;   -- active-high reset
        led  : out STD_LOGIC    -- to LED pin
    );
end led_blink;


architecture Behavioral of led_blink is

    -- 100MHz / 2 = 50M counts per half period (1Hz blink)
    constant MAX_COUNT : integer := 50;

    signal counter : integer range 0 to MAX_COUNT := 0;
    signal led_reg  : STD_LOGIC := '0';

begin

    -- Single clocked process — the heart of all sequential VHDL
    process(clk, rst)
    begin
        if rst = '1' then            -- async reset
            counter  <= 0;
            led_reg  <= '0';
        elsif rising_edge(clk) then  -- act on clock edge only
            if counter = MAX_COUNT - 1 then
                counter <= 0;
                led_reg <= not led_reg;  -- toggle LED
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;


    led <= led_reg;   -- concurrent signal assignment

end Behavioral;