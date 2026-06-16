--
-- Synopsys
-- Vhdl wrapper for top level design, written on Wed Jun 17 00:47:53 2026
--
library ieee;
use ieee.std_logic_1164.all;

entity wrapper_for_top_soc_new is
   port (
      CLK0_PAD : in std_logic;
      MMUART_0_RXD : in std_logic;
      SPI_0_DI : in std_logic;
      USB_ULPI_DIR : in std_logic;
      USB_ULPI_NXT : in std_logic;
      USB_ULPI_XCLK : in std_logic;
      MMUART_0_TXD : out std_logic;
      SPI_0_DO : out std_logic;
      USB_ULPI_STP : out std_logic;
      led : out std_logic_vector(3 downto 0);
      SPI_0_CLK : in std_logic;
      SPI_0_SS0 : in std_logic;
      USB_ULPI_DATA : in std_logic_vector(7 downto 0)
   );
end wrapper_for_top_soc_new;

architecture rtl of wrapper_for_top_soc_new is

component top_soc_new
 port (
   CLK0_PAD : in std_logic;
   MMUART_0_RXD : in std_logic;
   SPI_0_DI : in std_logic;
   USB_ULPI_DIR : in std_logic;
   USB_ULPI_NXT : in std_logic;
   USB_ULPI_XCLK : in std_logic;
   MMUART_0_TXD : out std_logic;
   SPI_0_DO : out std_logic;
   USB_ULPI_STP : out std_logic;
   led : out std_logic_vector (3 downto 0);
   SPI_0_CLK : inout std_logic;
   SPI_0_SS0 : inout std_logic;
   USB_ULPI_DATA : inout std_logic_vector (7 downto 0)
 );
end component;

signal tmp_CLK0_PAD : std_logic;
signal tmp_MMUART_0_RXD : std_logic;
signal tmp_SPI_0_DI : std_logic;
signal tmp_USB_ULPI_DIR : std_logic;
signal tmp_USB_ULPI_NXT : std_logic;
signal tmp_USB_ULPI_XCLK : std_logic;
signal tmp_MMUART_0_TXD : std_logic;
signal tmp_SPI_0_DO : std_logic;
signal tmp_USB_ULPI_STP : std_logic;
signal tmp_led : std_logic_vector (3 downto 0);
signal tmp_SPI_0_CLK : std_logic;
signal tmp_SPI_0_SS0 : std_logic;
signal tmp_USB_ULPI_DATA : std_logic_vector (7 downto 0);

begin

tmp_CLK0_PAD <= CLK0_PAD;

tmp_MMUART_0_RXD <= MMUART_0_RXD;

tmp_SPI_0_DI <= SPI_0_DI;

tmp_USB_ULPI_DIR <= USB_ULPI_DIR;

tmp_USB_ULPI_NXT <= USB_ULPI_NXT;

tmp_USB_ULPI_XCLK <= USB_ULPI_XCLK;

MMUART_0_TXD <= tmp_MMUART_0_TXD;

SPI_0_DO <= tmp_SPI_0_DO;

USB_ULPI_STP <= tmp_USB_ULPI_STP;

led <= tmp_led;

tmp_SPI_0_CLK <= SPI_0_CLK;

tmp_SPI_0_SS0 <= SPI_0_SS0;

tmp_USB_ULPI_DATA <= USB_ULPI_DATA;



u1:   top_soc_new port map (
		CLK0_PAD => tmp_CLK0_PAD,
		MMUART_0_RXD => tmp_MMUART_0_RXD,
		SPI_0_DI => tmp_SPI_0_DI,
		USB_ULPI_DIR => tmp_USB_ULPI_DIR,
		USB_ULPI_NXT => tmp_USB_ULPI_NXT,
		USB_ULPI_XCLK => tmp_USB_ULPI_XCLK,
		MMUART_0_TXD => tmp_MMUART_0_TXD,
		SPI_0_DO => tmp_SPI_0_DO,
		USB_ULPI_STP => tmp_USB_ULPI_STP,
		led => tmp_led,
		SPI_0_CLK => tmp_SPI_0_CLK,
		SPI_0_SS0 => tmp_SPI_0_SS0,
		USB_ULPI_DATA => tmp_USB_ULPI_DATA
       );
end rtl;
