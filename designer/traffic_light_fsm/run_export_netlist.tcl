set_device -fam SmartFusion2
read_verilog -top_module_name {traffic_light_fsm} \
    -file {E:\Projects\DRDO\drdo\synthesis\traffic_light_fsm.vm}
write_vhdl -file {E:\Projects\DRDO\drdo\synthesis\traffic_light_fsm.vhd}
