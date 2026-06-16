library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity apb_slave_tb is
end apb_slave_tb;

architecture Behavioral of apb_slave_tb is

    -- COMPONENT DECLARATION UPDATED TO MATCH 15 DOWNTO 2
    component apb_slave
        Port (
            PCLK     : in  STD_LOGIC;
            PRESETn  : in  STD_LOGIC;
            PADDR    : in  STD_LOGIC_VECTOR(15 downto 2);
            PSEL     : in  STD_LOGIC;
            PENABLE  : in  STD_LOGIC;
            PWRITE   : in  STD_LOGIC;
            PWDATA   : in  STD_LOGIC_VECTOR(31 downto 0);
            PRDATA   : out STD_LOGIC_VECTOR(31 downto 0);
            PREADY   : out STD_LOGIC;
            reg_out0 : out STD_LOGIC_VECTOR(31 downto 0);
            reg_out1 : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    signal PCLK     : STD_LOGIC := '0';
    signal PRESETn  : STD_LOGIC := '0';
    -- Signal tracking vector updated to match width
    signal PADDR    : STD_LOGIC_VECTOR(15 downto 2) := (others => '0');
    signal PSEL     : STD_LOGIC := '0';
    signal PENABLE  : STD_LOGIC := '0';
    signal PWRITE   : STD_LOGIC := '0';
    signal PWDATA   : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal PRDATA   : STD_LOGIC_VECTOR(31 downto 0);
    signal PREADY   : STD_LOGIC;
    signal reg_out0 : STD_LOGIC_VECTOR(31 downto 0);
    signal reg_out1 : STD_LOGIC_VECTOR(31 downto 0);

    constant CLK_PERIOD : time := 20 ns;

begin

    uut: apb_slave port map (
        PCLK => PCLK, PRESETn => PRESETn, PADDR => PADDR,
        PSEL => PSEL, PENABLE => PENABLE, PWRITE => PWRITE,
        PWDATA => PWDATA, PRDATA => PRDATA, PREADY => PREADY,
        reg_out0 => reg_out0, reg_out1 => reg_out1
    );

    -- Clock Gen
    PCLK_process : process
    begin
        PCLK <= '0'; wait for CLK_PERIOD/2;
        PCLK <= '1'; wait for CLK_PERIOD/2;
    end process;

    -- Stimulus: Emulating CPU Read/Write Cycles
    stim_proc: process
    begin
        -- System Initialization
        PRESETn <= '0';
        PADDR   <= (others => '0');
        wait for 40 ns;
        PRESETn <= '1';
        wait for 20 ns;

        -- TRANSACTION 1: CPU Writes 0xDEADBEEF to Register 0 (Address 0x00 -> "00" in bits 3 downto 2)
        PADDR   <= "00" & "0000" & "0000" & "00"; -- 14 bits literal value 0x00
        PWDATA  <= x"DEADBEEF";
        PWRITE  <= '1';
        PSEL    <= '1';       -- Phase 1: Setup phase
        wait for CLK_PERIOD;
        PENABLE <= '1';       -- Phase 2: Access phase
        wait for CLK_PERIOD;
        PSEL    <= '0';
        PENABLE <= '0';
        wait for CLK_PERIOD;

        -- TRANSACTION 2: CPU Writes 0xCAFEBABE to Register 1 (Address 0x04 -> "01" in bits 3 downto 2)
        PADDR   <= "00" & "0000" & "0001" & "00"; -- 14 bits literal value pointing to index 1
        PWDATA  <= x"CAFEBABE";
        PWRITE  <= '1';
        PSEL    <= '1';
        wait for CLK_PERIOD;
        PENABLE <= '1';
        wait for CLK_PERIOD;
        PSEL    <= '0';
        PENABLE <= '0';
        wait for CLK_PERIOD;

        -- TRANSACTION 3: CPU Reads back from Register 0 (Address 0x00)
        PADDR   <= "00" & "0000" & "0000" & "00";
        PWRITE  <= '0';       -- Read mode
        PSEL    <= '1';
        wait for CLK_PERIOD;
        PENABLE <= '1';       -- Data appears on PRDATA here
        wait for CLK_PERIOD;
        PSEL    <= '0';
        PENABLE <= '0';

        wait;
    end process;

end Behavioral;