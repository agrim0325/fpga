set_device -family {SmartFusion2} -die {M2S010} -speed {-1}
read_verilog -mode system_verilog {E:\Projects\DRDO\drdo\hdl\vending_machine_fsm.v}
set_top_level {vending_machine_fsm}
map_netlist
check_constraints {E:\Projects\DRDO\drdo\constraint\synthesis_sdc_errors.log}
write_fdc {E:\Projects\DRDO\drdo\designer\vending_machine_fsm\synthesis.fdc}
