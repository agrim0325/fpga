set_device -fam SmartFusion2
read_verilog -top_module_name {sequence_detector_moore} \
    -file {E:\Projects\DRDO\drdo\synthesis\sequence_detector_moore.vm}
write_vhdl -file {E:\Projects\DRDO\drdo\synthesis\sequence_detector_moore.vhd}
