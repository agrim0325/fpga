set_device -family {SmartFusion2} -die {M2S010} -speed {-1}
read_verilog -mode system_verilog {E:\Projects\DRDO\drdo\hdl\register_4bit.v}
set_top_level {register_4bit}
map_netlist
check_constraints {E:\Projects\DRDO\drdo\constraint\synthesis_sdc_errors.log}
write_fdc {E:\Projects\DRDO\drdo\designer\register_4bit\synthesis.fdc}
