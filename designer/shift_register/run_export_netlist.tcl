set_device -fam SmartFusion2
read_verilog -top_module_name {shift_register} \
    -file {E:\Projects\DRDO\drdo\synthesis\shift_register.vm}
write_vhdl -file {E:\Projects\DRDO\drdo\synthesis\shift_register.vhd}
