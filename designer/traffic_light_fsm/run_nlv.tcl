# Netlist Viewer TCL File
set_family -name SmartFusion2
top_module -name traffic_light_fsm
addfile -view RTL -lib work -type VLOG -mode system_verilog -name {E:/Projects/DRDO/drdo/hdl/traffic_light_fsm.v}
addfile -view HIER -lib work -type VLOG -mode system_verilog -name {E:/Projects/DRDO/drdo/synthesis/traffic_light_fsm.vm}
addfile -view FLAT -lib work -type AFL -mode NONE -name {E:/Projects/DRDO/drdo/designer/traffic_light_fsm/traffic_light_fsm.afl}