library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity flip_flops_tb is
end flip_flops_tb;

architecture sim of flip_flops_tb is

    component flipflops
        Port (
            clk, rst     : in  STD_LOGIC;
            d, j, k, t   : in  STD_LOGIC;
            s, r         : in  STD_LOGIC;
            q_d, q_jk    : out STD_LOGIC;
            q_t, q_sr    : out STD_LOGIC
        );
    end component;

    signal clk_tb, rst_tb       : STD_LOGIC := '0';
    signal d_tb, j_tb, k_tb     : STD_LOGIC := '0';
    signal t_tb, s_tb, r_tb     : STD_LOGIC := '0';
    signal q_d_tb, q_jk_tb      : STD_LOGIC;
    signal q_t_tb, q_sr_tb      : STD_LOGIC;

    constant CLK_PERIOD : time := 20 ns;

begin

    flipflops_0: flipflops
    port map(
        clk  => clk_tb,
        rst  => rst_tb,
        d    => d_tb,
        j    => j_tb,
        k    => k_tb,
        t    => t_tb,
        s    => s_tb,
        r    => r_tb,
        q_d  => q_d_tb,
        q_jk => q_jk_tb,
        q_t  => q_t_tb,
        q_sr => q_sr_tb
    );

    clk_tb <= not clk_tb after CLK_PERIOD/2;

    stim : process
    begin

        --------------------------------------------------
        -- Reset
        --------------------------------------------------
        rst_tb <= '1';
        wait for 20 ns;
        rst_tb <= '0';

        --------------------------------------------------
        -- D Flip-Flop
        --------------------------------------------------
        d_tb <= '1';
        wait for 20 ns;
        assert q_d_tb = '1'
            report "D FF set failed"
            severity error;

        d_tb <= '0';
        wait for 20 ns;
        assert q_d_tb = '0'
            report "D FF reset failed"
            severity error;

        --------------------------------------------------
        -- JK Flip-Flop
        --------------------------------------------------

        -- Set
        j_tb <= '1';
        k_tb <= '0';

        wait until rising_edge(clk_tb);
        wait for 10 ns;

        assert q_jk_tb = '1'
            report "JK set failed"
            severity error;

        -- Reset
        j_tb <= '0';
        k_tb <= '1';

        wait until rising_edge(clk_tb);
        wait for 10 ns;

        assert q_jk_tb = '0'
            report "JK reset failed"
            severity error;

        -- Toggle
        j_tb <= '1';
        k_tb <= '1';

        wait until rising_edge(clk_tb);
        wait for 10 ns;

        assert q_jk_tb = '1'
            report "JK toggle failed"
            severity error;

        -- Toggle again
        wait until rising_edge(clk_tb);
        wait for 10 ns;

        assert q_jk_tb = '0'
            report "JK toggle 2 failed"
            severity error;

        --------------------------------------------------
        -- T Flip-Flop
        --------------------------------------------------

        t_tb <= '1';

        wait until rising_edge(clk_tb);
        wait for 10 ns;

        assert q_t_tb = '1'
            report "T toggle failed"
            severity error;

        wait until rising_edge(clk_tb);
        wait for 10 ns;

        assert q_t_tb = '0'
            report "T toggle 2 failed"
            severity error;

        t_tb <= '0';

        wait until rising_edge(clk_tb);
        wait for 10 ns;

        assert q_t_tb = '0'
            report "T hold failed"
            severity error;

        --------------------------------------------------
        -- SR Flip-Flop
        --------------------------------------------------

        s_tb <= '1';
        r_tb <= '0';

        wait for 20 ns;

        assert q_sr_tb = '1'
            report "SR set failed"
            severity error;

        s_tb <= '0';
        r_tb <= '1';

        wait for 20 ns;

        assert q_sr_tb = '0'
            report "SR reset failed"
            severity error;

        --------------------------------------------------
        -- End Simulation
        --------------------------------------------------

        report "All flip flop tests passed"
            severity note;

        wait;

    end process;

end sim;