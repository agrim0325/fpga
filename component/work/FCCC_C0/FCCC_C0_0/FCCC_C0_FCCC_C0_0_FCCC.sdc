set_component FCCC_C0_FCCC_C0_0_FCCC
# Microchip Technology Inc.
# Date: 2026-Jun-16 13:59:31
#

create_clock -period 10 [ get_pins { CCC_INST/CLK0_PAD } ]
create_generated_clock -multiply_by 4 -divide_by 4 -source [ get_pins { CCC_INST/CLK0_PAD } ] -phase 0 [ get_pins { CCC_INST/GL0 } ]
