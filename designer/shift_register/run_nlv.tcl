# Netlist Viewer TCL File
set_family -name SmartFusion2
top_module -name shift_register
addfile -view RTL -lib work -type VLOG -mode system_verilog -name {E:/Projects/DRDO/drdo/hdl/shift_register.v}
addfile -view HIER -lib work -type VLOG -mode system_verilog -name {E:/Projects/DRDO/drdo/synthesis/shift_register.vm}
addfile -view FLAT -lib work -type AFL -mode NONE -name {E:/Projects/DRDO/drdo/designer/shift_register/shift_register.afl}