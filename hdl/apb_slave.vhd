library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity apb_slave is
    Port (
        -- APB Bus Interface
        PCLK     : in  STD_LOGIC;
        PRESETn  : in  STD_LOGIC; -- Active-low reset standard for AMBA
        PADDR    : in  STD_LOGIC_VECTOR(15 downto 2); -- Matches Libero Subsystem
        PSEL     : in  STD_LOGIC;
        PENABLE  : in  STD_LOGIC;
        PWRITE   : in  STD_LOGIC;
        PWDATA   : in  STD_LOGIC_VECTOR(31 downto 0);
        PRDATA   : out STD_LOGIC_VECTOR(31 downto 0);
        PREADY   : out STD_LOGIC;
        
        -- Parallel Hardware Outputs
        reg_out0 : out STD_LOGIC_VECTOR(31 downto 0);
        reg_out1 : out STD_LOGIC_VECTOR(31 downto 0)
    );
end apb_slave;

architecture Behavioral of apb_slave is

    -- Define 4 internal 32-bit registers
    type reg_array is array (0 to 3) of STD_LOGIC_VECTOR(31 downto 0);
    signal reg_bank : reg_array := (others => (others => '0'));
    
    signal addr_idx : integer range 0 to 3;

begin

    -- Decode using bits 3 and 2 directly from our 14-bit bus
    addr_idx <= to_integer(unsigned(PADDR(3 downto 2)));

    -- APB Write and Read Process
    process(PCLK, PRESETn)
    begin
        if PRESETn = '0' then
            reg_bank <= (others => (others => '0'));
            PRDATA   <= (others => '0');
        elsif rising_edge(PCLK) then
            
            -- Default read output
            if PSEL = '1' and PWRITE = '0' then
                PRDATA <= reg_bank(addr_idx);
            else
                PRDATA <= (others => '0');
            end if;

            -- Write Operation
            if PSEL = '1' and PENABLE = '1' and PWRITE = '1' then
                reg_bank(addr_idx) <= PWDATA;
            end if;
            
        end if;
    end process;

    -- APB Ready Signal
    PREADY <= '1';

    -- Drive parallel hardware outputs
    reg_out0 <= reg_bank(0);
    reg_out1 <= reg_bank(1);

end Behavioral;