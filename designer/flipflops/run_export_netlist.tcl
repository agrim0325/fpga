set_device -fam SmartFusion2
read_verilog -top_module_name {flipflops} \
    -file {E:\Projects\DRDO\drdo\synthesis\flipflops.vm}
write_vhdl -file {E:\Projects\DRDO\drdo\synthesis\flipflops.vhd}
