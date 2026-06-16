set_device \
    -family  SmartFusion2 \
    -die     PA4M1000_N \
    -package vf256 \
    -speed   -1 \
    -tempr   {COM} \
    -voltr   {COM}
set_def {VOLTAGE} {1.2}
set_def {VCCI_1.2_VOLTR} {COM}
set_def {VCCI_1.5_VOLTR} {COM}
set_def {VCCI_1.8_VOLTR} {COM}
set_def {VCCI_2.5_VOLTR} {COM}
set_def {VCCI_3.3_VOLTR} {COM}
set_name apb_led_slave
set_workdir {E:\Projects\DRDO\drdo\designer\apb_led_slave}
set_filename    {E:\Projects\DRDO\drdo\designer\apb_led_slave\apb_led_slave_ba}
set_design_state post_layout
set_language vhdl
