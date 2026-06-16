# Netlist Viewer TCL File
set_family -name SmartFusion2
top_module -name register_4bit
addfile -view RTL -lib work -type VLOG -mode system_verilog -name {E:/Projects/DRDO/drdo/hdl/register_4bit.v}
addfile -view HIER -lib work -type VLOG -mode system_verilog -name {E:/Projects/DRDO/drdo/synthesis/register_4bit.vm}
addfile -view FLAT -lib work -type AFL -mode NONE -name {E:/Projects/DRDO/drdo/designer/register_4bit/register_4bit.afl}