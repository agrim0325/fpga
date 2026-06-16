set_device -fam SmartFusion2
read_verilog -top_module_name {apb_led_slave} \
    -file {E:\Projects\DRDO\drdo\synthesis\apb_led_slave.vm}
write_vhdl -file {E:\Projects\DRDO\drdo\synthesis\apb_led_slave.vhd}
