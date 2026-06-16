# Netlist Viewer TCL File
set_family -name SmartFusion2
top_module -name flipflops
addfile -view RTL -lib work -type VHDL -mode vhdl_2008 -name {E:/Projects/DRDO/drdo/hdl/flipflops.vhd}
addfile -view HIER -lib work -type VLOG -mode system_verilog -name {E:/Projects/DRDO/drdo/synthesis/flipflops.vm}
addfile -view FLAT -lib work -type AFL -mode NONE -name {E:/Projects/DRDO/drdo/designer/flipflops/flipflops.afl}