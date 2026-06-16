set_device -family {SmartFusion2} -die {M2S010} -speed {-1}
read_verilog -mode system_verilog {E:\Projects\DRDO\drdo\hdl\sequence_detector_moore.v}
set_top_level {sequence_detector_moore}
map_netlist
check_constraints {E:\Projects\DRDO\drdo\constraint\synthesis_sdc_errors.log}
write_fdc {E:\Projects\DRDO\drdo\designer\sequence_detector_moore\synthesis.fdc}
