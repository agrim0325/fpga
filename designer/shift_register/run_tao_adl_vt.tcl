set_device -family {SmartFusion2} -die {M2S010} -speed {-1}
read_adl {E:\Projects\DRDO\drdo\designer\shift_register\shift_register.adl}
read_afl {E:\Projects\DRDO\drdo\designer\shift_register\shift_register.afl}
map_netlist
check_constraints {E:\Projects\DRDO\drdo\constraint\timing_sdc_errors.log}
write_sdc -mode smarttime {E:\Projects\DRDO\drdo\designer\shift_register\timing_analysis.sdc}
