library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity led_blink_tb is
end led_blink_tb;

architecture sim of led_blink_tb is

    signal clk : STD_LOGIC := '0';
    signal rst : STD_LOGIC := '1';
    signal led : STD_LOGIC;

begin

    uut : entity work.led_blink
    port map (
        clk => clk,
        rst => rst,
        led => led
    );

    -- 100 MHz clock (10 ns period)
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
    end process;

    -- Reset
    stim_proc : process
    begin
        wait for 20 ns;
        rst <= '0';

        wait for 1 sec;
        wait;
    end process;

end sim;