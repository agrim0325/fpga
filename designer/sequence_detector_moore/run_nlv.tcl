# Netlist Viewer TCL File
set_family -name SmartFusion2
top_module -name sequence_detector_moore
addfile -view RTL -lib work -type VLOG -mode system_verilog -name {E:/Projects/DRDO/drdo/hdl/sequence_detector_moore.v}
addfile -view HIER -lib work -type VLOG -mode system_verilog -name {E:/Projects/DRDO/drdo/synthesis/sequence_detector_moore.vm}
addfile -view FLAT -lib work -type AFL -mode NONE -name {E:/Projects/DRDO/drdo/designer/sequence_detector_moore/sequence_detector_moore.afl}