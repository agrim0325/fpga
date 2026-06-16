set_device -family {SmartFusion2} -die {M2S010} -speed {-1}
read_vhdl -mode vhdl_2008 {E:\Projects\DRDO\drdo\hdl\flipflops.vhd}
set_top_level {flipflops}
map_netlist
check_constraints {E:\Projects\DRDO\drdo\constraint\synthesis_sdc_errors.log}
write_fdc {E:\Projects\DRDO\drdo\designer\flipflops\synthesis.fdc}
