set_device -family {SmartFusion2} -die {M2S010} -speed {-1}
read_vhdl -mode vhdl_2008 {E:\Projects\DRDO\drdo\hdl\alu_4bit.vhd}
set_top_level {alu_4bit}
map_netlist
check_constraints {E:\Projects\DRDO\drdo\constraint\synthesis_sdc_errors.log}
write_fdc {E:\Projects\DRDO\drdo\designer\alu_4bit\synthesis.fdc}
