library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity flipflops is
    Port (
        clk  : in  STD_LOGIC;
        rst  : in  STD_LOGIC;
        d    : in  STD_LOGIC;
        j    : in  STD_LOGIC;
        k    : in  STD_LOGIC;
        t    : in  STD_LOGIC;
        q_d  : out STD_LOGIC;
        q_jk : out STD_LOGIC;
        q_t  : out STD_LOGIC;
        q_sr : out STD_LOGIC;
        s    : in  STD_LOGIC;
        r    : in  STD_LOGIC -- Removed the trailing comma here
    );
end flipflops;

architecture Behavioral of flipflops is

    signal q_d_reg  : STD_LOGIC := '0';
    signal q_jk_reg : STD_LOGIC := '0';
    signal q_t_reg  : STD_LOGIC := '0';
    signal q_sr_reg : STD_LOGIC := '0';

begin

    -- D Flip Flop
    -- Output follows D on rising edge
    process(clk, rst)
    begin
        if rst = '1' then
            q_d_reg <= '0';
        elsif rising_edge(clk) then
            q_d_reg <= d;
        end if;
    end process;

    -- JK Flip Flop
    -- J=0 K=0 hold
    -- J=0 K=1 reset
    -- J=1 K=0 set
    -- J=1 K=1 toggle
    process(clk, rst)
    begin
        if rst = '1' then
            q_jk_reg <= '0';
        elsif rising_edge(clk) then
            -- Fixed: Added std_logic_vector' type qualification
            case std_logic_vector'(j & k) is
                when "00" => q_jk_reg <= q_jk_reg;
                when "01" => q_jk_reg <= '0';
                when "10" => q_jk_reg <= '1';
                when "11" => q_jk_reg <= not q_jk_reg;
                when others => null;
            end case;
        end if;
    end process;

    -- T Flip Flop
    -- T=0 hold
    -- T=1 toggle
    process(clk, rst)
    begin
        if rst = '1' then
            q_t_reg <= '0';
        elsif rising_edge(clk) then
            if t = '1' then
                q_t_reg <= not q_t_reg;
            end if;
        end if;
    end process;

    -- SR Flip Flop
    -- S=0 R=0 hold
    -- S=0 R=1 reset
    -- S=1 R=0 set
    -- S=1 R=1 invalid
    process(clk, rst)
    begin
        if rst = '1' then
            q_sr_reg <= '0';
        elsif rising_edge(clk) then
            -- Fixed: Added std_logic_vector' type qualification
            case std_logic_vector'(s & r) is
                when "00" => q_sr_reg <= q_sr_reg;
                when "01" => q_sr_reg <= '0';
                when "10" => q_sr_reg <= '1';
                when "11" => q_sr_reg <= 'X';
                when others => null;
            end case;
        end if;
    end process;

    q_d  <= q_d_reg;
    q_jk <= q_jk_reg;
    q_t  <= q_t_reg;
    q_sr <= q_sr_reg;

end Behavioral;