set_device -family {SmartFusion2} -die {M2S010} -speed {-1}
read_vhdl -mode vhdl_2008 {E:\Projects\DRDO\drdo\hdl\led_blink.vhd}
set_top_level {led_blink}
map_netlist
check_constraints {E:\Projects\DRDO\drdo\constraint\synthesis_sdc_errors.log}
write_fdc {E:\Projects\DRDO\drdo\designer\led_blink\synthesis.fdc}
