set_device -fam SmartFusion2
read_verilog -top_module_name {register_4bit} \
    -file {E:\Projects\DRDO\drdo\synthesis\register_4bit.vm}
write_vhdl -file {E:\Projects\DRDO\drdo\synthesis\register_4bit.vhd}
