----------------------------------------------------------------------
-- Created by Microsemi SmartDesign Sun Jun  7 16:36:43 2026
-- Testbench Template
-- This is a basic testbench that instantiates your design with basic 
-- clock and reset pins connected.  If your design has special
-- clock/reset or testbench driver requirements then you should 
-- copy this file and modify it. 
----------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: sequence_detector_moore_tb.vhd
-- File history:
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--
-- Description: 
--
-- <Description here>
--
-- Targeted device: <Family::SmartFusion2> <Die::M2S010> <Package::256 VF>
-- Author: <Name>
--
--------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;

entity sequence_detector_moore_tb is
end sequence_detector_moore_tb;

architecture behavioral of sequence_detector_moore_tb is

    constant SYSCLK_PERIOD : time := 100 ns; -- 10MHZ

    signal SYSCLK : std_logic := '0';
    signal NSYSRESET : std_logic := '0';

    component traffic_light_fsm
        -- ports
        port( 
            -- Inputs
            clk : in std_logic;
            rst : in std_logic;

            -- Outputs
            roadA : out std_logic_vector(1 downto 0);
            roadB : out std_logic_vector(1 downto 0)

            -- Inouts

        );
    end component;

begin

    process
        variable vhdl_initial : BOOLEAN := TRUE;

    begin
        if ( vhdl_initial ) then
            -- Assert Reset
            NSYSRESET <= '0';
            wait for ( SYSCLK_PERIOD * 10 );
            
            NSYSRESET <= '1';
            wait;
        end if;
    end process;

    -- Clock Driver
    SYSCLK <= not SYSCLK after (SYSCLK_PERIOD / 2.0 );

    -- Instantiate Unit Under Test:  traffic_light_fsm
    traffic_light_fsm_0 : traffic_light_fsm
        -- port map
        port map( 
            -- Inputs
            clk => SYSCLK,
            rst => NSYSRESET,

            -- Outputs
            roadA => open,
            roadB => open

            -- Inouts

        );

end behavioral;

