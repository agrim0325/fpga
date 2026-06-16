----------------------------------------------------------------------
-- Created by SmartDesign Tue Jun 16 14:07:31 2026
-- Version: 2025.2 2025.2.0.14
----------------------------------------------------------------------

----------------------------------------------------------------------
-- Libraries
----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

library smartfusion2;
use smartfusion2.all;
----------------------------------------------------------------------
-- top_soc_new entity declaration
----------------------------------------------------------------------
entity top_soc_new is
    -- Port list
    port(
        -- Inputs
        CLK0_PAD      : in    std_logic;
        MMUART_0_RXD  : in    std_logic;
        SPI_0_DI      : in    std_logic;
        USB_ULPI_DIR  : in    std_logic;
        USB_ULPI_NXT  : in    std_logic;
        USB_ULPI_XCLK : in    std_logic;
        -- Outputs
        MMUART_0_TXD  : out   std_logic;
        SPI_0_DO      : out   std_logic;
        USB_ULPI_STP  : out   std_logic;
        led           : out   std_logic_vector(3 downto 0);
        -- Inouts
        SPI_0_CLK     : inout std_logic;
        SPI_0_SS0     : inout std_logic;
        USB_ULPI_DATA : inout std_logic_vector(7 downto 0)
        );
end top_soc_new;
----------------------------------------------------------------------
-- top_soc_new architecture body
----------------------------------------------------------------------
architecture RTL of top_soc_new is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- apb_led_slave
component apb_led_slave
    -- Port list
    port(
        -- Inputs
        PADDR   : in  std_logic_vector(7 downto 0);
        PCLK    : in  std_logic;
        PENABLE : in  std_logic;
        PRESETN : in  std_logic;
        PSEL    : in  std_logic;
        PWDATA  : in  std_logic_vector(31 downto 0);
        PWRITE  : in  std_logic;
        -- Outputs
        PRDATA  : out std_logic_vector(31 downto 0);
        PREADY  : out std_logic;
        led     : out std_logic_vector(3 downto 0)
        );
end component;
-- CoreAPB3_C0
component CoreAPB3_C0
    -- Port list
    port(
        -- Inputs
        PADDR     : in  std_logic_vector(31 downto 0);
        PENABLE   : in  std_logic;
        PRDATAS0  : in  std_logic_vector(31 downto 0);
        PREADYS0  : in  std_logic;
        PSEL      : in  std_logic;
        PSLVERRS0 : in  std_logic;
        PWDATA    : in  std_logic_vector(31 downto 0);
        PWRITE    : in  std_logic;
        -- Outputs
        PADDRS    : out std_logic_vector(31 downto 0);
        PENABLES  : out std_logic;
        PRDATA    : out std_logic_vector(31 downto 0);
        PREADY    : out std_logic;
        PSELS0    : out std_logic;
        PSLVERR   : out std_logic;
        PWDATAS   : out std_logic_vector(31 downto 0);
        PWRITES   : out std_logic
        );
end component;
-- FCCC_C0
component FCCC_C0
    -- Port list
    port(
        -- Inputs
        CLK0_PAD : in  std_logic;
        -- Outputs
        GL0      : out std_logic;
        LOCK     : out std_logic
        );
end component;
-- MSS_C0_MSS
component MSS_C0_MSS
    -- Port list
    port(
        -- Inputs
        FIC_0_APB_M_PRDATA  : in    std_logic_vector(31 downto 0);
        FIC_0_APB_M_PREADY  : in    std_logic;
        FIC_0_APB_M_PSLVERR : in    std_logic;
        MCCC_CLK_BASE       : in    std_logic;
        MMUART_0_RXD        : in    std_logic;
        SPI_0_DI            : in    std_logic;
        USB_ULPI_DIR        : in    std_logic;
        USB_ULPI_NXT        : in    std_logic;
        USB_ULPI_XCLK       : in    std_logic;
        -- Outputs
        FIC_0_APB_M_PADDR   : out   std_logic_vector(31 downto 0);
        FIC_0_APB_M_PENABLE : out   std_logic;
        FIC_0_APB_M_PSEL    : out   std_logic;
        FIC_0_APB_M_PWDATA  : out   std_logic_vector(31 downto 0);
        FIC_0_APB_M_PWRITE  : out   std_logic;
        MMUART_0_TXD        : out   std_logic;
        MSS_RESET_N_M2F     : out   std_logic;
        SPI_0_DO            : out   std_logic;
        USB_ULPI_STP        : out   std_logic;
        -- Inouts
        SPI_0_CLK           : inout std_logic;
        SPI_0_SS0           : inout std_logic;
        USB_ULPI_DATA       : inout std_logic_vector(7 downto 0)
        );
end component;
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal apb_led_slave_0_PRDATA           : std_logic_vector(31 downto 0);
signal apb_led_slave_0_PREADY           : std_logic;
signal CoreAPB3_C0_0_PADDRS7to0         : std_logic_vector(7 downto 0);
signal CoreAPB3_C0_0_PENABLES           : std_logic;
signal CoreAPB3_C0_0_PRDATA             : std_logic_vector(31 downto 0);
signal CoreAPB3_C0_0_PREADY             : std_logic;
signal CoreAPB3_C0_0_PSELS0             : std_logic;
signal CoreAPB3_C0_0_PSLVERR            : std_logic;
signal CoreAPB3_C0_0_PWDATAS            : std_logic_vector(31 downto 0);
signal CoreAPB3_C0_0_PWRITES            : std_logic;
signal FCCC_C0_0_GL0                    : std_logic;
signal led_net_0                        : std_logic_vector(3 downto 0);
signal MMUART_0_TXD_net_0               : std_logic;
signal MSS_C0_MSS_0_FIC_0_APB_M_PADDR   : std_logic_vector(31 downto 0);
signal MSS_C0_MSS_0_FIC_0_APB_M_PENABLE : std_logic;
signal MSS_C0_MSS_0_FIC_0_APB_M_PSEL    : std_logic;
signal MSS_C0_MSS_0_FIC_0_APB_M_PWDATA  : std_logic_vector(31 downto 0);
signal MSS_C0_MSS_0_FIC_0_APB_M_PWRITE  : std_logic;
signal MSS_C0_MSS_0_MSS_RESET_N_M2F     : std_logic;
signal SPI_0_DO_net_0                   : std_logic;
signal USB_ULPI_STP_net_0               : std_logic;
signal SPI_0_DO_net_1                   : std_logic;
signal MMUART_0_TXD_net_1               : std_logic;
signal USB_ULPI_STP_net_1               : std_logic;
signal led_net_1                        : std_logic_vector(3 downto 0);
signal PADDRS_slice_0                   : std_logic_vector(15 downto 8);
signal PADDRS_slice_1                   : std_logic_vector(23 downto 16);
signal PADDRS_slice_2                   : std_logic_vector(31 downto 24);
signal FIC_0_APB_M_PADDR_slice_0        : std_logic_vector(15 downto 8);
signal FIC_0_APB_M_PADDR_slice_1        : std_logic_vector(23 downto 16);
signal FIC_0_APB_M_PADDR_slice_2        : std_logic_vector(31 downto 24);
signal FIC_0_APB_M_PADDR_slice_3        : std_logic_vector(7 downto 0);
signal PADDRS_net_0                     : std_logic_vector(31 downto 0);
----------------------------------------------------------------------
-- TiedOff Signals
----------------------------------------------------------------------
signal GND_net                          : std_logic;

begin
----------------------------------------------------------------------
-- Constant assignments
----------------------------------------------------------------------
 GND_net <= '0';
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 SPI_0_DO_net_1     <= SPI_0_DO_net_0;
 SPI_0_DO           <= SPI_0_DO_net_1;
 MMUART_0_TXD_net_1 <= MMUART_0_TXD_net_0;
 MMUART_0_TXD       <= MMUART_0_TXD_net_1;
 USB_ULPI_STP_net_1 <= USB_ULPI_STP_net_0;
 USB_ULPI_STP       <= USB_ULPI_STP_net_1;
 led_net_1          <= led_net_0;
 led(3 downto 0)    <= led_net_1;
----------------------------------------------------------------------
-- Slices assignments
----------------------------------------------------------------------
 CoreAPB3_C0_0_PADDRS7to0  <= PADDRS_net_0(7 downto 0);
 PADDRS_slice_0            <= PADDRS_net_0(15 downto 8);
 PADDRS_slice_1            <= PADDRS_net_0(23 downto 16);
 PADDRS_slice_2            <= PADDRS_net_0(31 downto 24);
 FIC_0_APB_M_PADDR_slice_0 <= MSS_C0_MSS_0_FIC_0_APB_M_PADDR(15 downto 8);
 FIC_0_APB_M_PADDR_slice_1 <= MSS_C0_MSS_0_FIC_0_APB_M_PADDR(23 downto 16);
 FIC_0_APB_M_PADDR_slice_2 <= MSS_C0_MSS_0_FIC_0_APB_M_PADDR(31 downto 24);
 FIC_0_APB_M_PADDR_slice_3 <= MSS_C0_MSS_0_FIC_0_APB_M_PADDR(7 downto 0);
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- apb_led_slave_0
apb_led_slave_0 : apb_led_slave
    port map( 
        -- Inputs
        PCLK    => FCCC_C0_0_GL0,
        PRESETN => MSS_C0_MSS_0_MSS_RESET_N_M2F,
        PSEL    => CoreAPB3_C0_0_PSELS0,
        PENABLE => CoreAPB3_C0_0_PENABLES,
        PWRITE  => CoreAPB3_C0_0_PWRITES,
        PADDR   => CoreAPB3_C0_0_PADDRS7to0,
        PWDATA  => CoreAPB3_C0_0_PWDATAS,
        -- Outputs
        PREADY  => apb_led_slave_0_PREADY,
        PRDATA  => apb_led_slave_0_PRDATA,
        led     => led_net_0 
        );
-- CoreAPB3_C0_0
CoreAPB3_C0_0 : CoreAPB3_C0
    port map( 
        -- Inputs
        PSEL      => MSS_C0_MSS_0_FIC_0_APB_M_PSEL,
        PENABLE   => MSS_C0_MSS_0_FIC_0_APB_M_PENABLE,
        PWRITE    => MSS_C0_MSS_0_FIC_0_APB_M_PWRITE,
        PREADYS0  => apb_led_slave_0_PREADY,
        PSLVERRS0 => GND_net,
        PADDR     => MSS_C0_MSS_0_FIC_0_APB_M_PADDR,
        PWDATA    => MSS_C0_MSS_0_FIC_0_APB_M_PWDATA,
        PRDATAS0  => apb_led_slave_0_PRDATA,
        -- Outputs
        PREADY    => CoreAPB3_C0_0_PREADY,
        PSLVERR   => CoreAPB3_C0_0_PSLVERR,
        PSELS0    => CoreAPB3_C0_0_PSELS0,
        PENABLES  => CoreAPB3_C0_0_PENABLES,
        PWRITES   => CoreAPB3_C0_0_PWRITES,
        PRDATA    => CoreAPB3_C0_0_PRDATA,
        PADDRS    => PADDRS_net_0,
        PWDATAS   => CoreAPB3_C0_0_PWDATAS 
        );
-- FCCC_C0_0
FCCC_C0_0 : FCCC_C0
    port map( 
        -- Inputs
        CLK0_PAD => CLK0_PAD,
        -- Outputs
        GL0      => FCCC_C0_0_GL0,
        LOCK     => OPEN 
        );
-- MSS_C0_MSS_0
MSS_C0_MSS_0 : MSS_C0_MSS
    port map( 
        -- Inputs
        SPI_0_DI            => SPI_0_DI,
        MCCC_CLK_BASE       => GND_net,
        MMUART_0_RXD        => MMUART_0_RXD,
        USB_ULPI_DIR        => USB_ULPI_DIR,
        USB_ULPI_NXT        => USB_ULPI_NXT,
        USB_ULPI_XCLK       => USB_ULPI_XCLK,
        FIC_0_APB_M_PREADY  => CoreAPB3_C0_0_PREADY,
        FIC_0_APB_M_PSLVERR => CoreAPB3_C0_0_PSLVERR,
        FIC_0_APB_M_PRDATA  => CoreAPB3_C0_0_PRDATA,
        -- Outputs
        SPI_0_DO            => SPI_0_DO_net_0,
        MMUART_0_TXD        => MMUART_0_TXD_net_0,
        USB_ULPI_STP        => USB_ULPI_STP_net_0,
        FIC_0_APB_M_PSEL    => MSS_C0_MSS_0_FIC_0_APB_M_PSEL,
        FIC_0_APB_M_PWRITE  => MSS_C0_MSS_0_FIC_0_APB_M_PWRITE,
        FIC_0_APB_M_PENABLE => MSS_C0_MSS_0_FIC_0_APB_M_PENABLE,
        MSS_RESET_N_M2F     => MSS_C0_MSS_0_MSS_RESET_N_M2F,
        FIC_0_APB_M_PADDR   => MSS_C0_MSS_0_FIC_0_APB_M_PADDR,
        FIC_0_APB_M_PWDATA  => MSS_C0_MSS_0_FIC_0_APB_M_PWDATA,
        -- Inouts
        SPI_0_CLK           => SPI_0_CLK,
        SPI_0_SS0           => SPI_0_SS0,
        USB_ULPI_DATA       => USB_ULPI_DATA 
        );

end RTL;
