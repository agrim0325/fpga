set_device -family {SmartFusion2} -die {M2S010} -speed {-1}
read_vhdl -mode vhdl_2008 -lib COREAPB3_LIB {E:\Projects\DRDO\drdo\component\Actel\DirectCore\CoreAPB3\4.2.100\rtl\vhdl\core\coreapb3_muxptob3.vhd}
read_vhdl -mode vhdl_2008 -lib COREAPB3_LIB {E:\Projects\DRDO\drdo\component\Actel\DirectCore\CoreAPB3\4.2.100\rtl\vhdl\core\coreapb3_iaddr_reg.vhd}
read_vhdl -mode vhdl_2008 -lib COREAPB3_LIB {E:\Projects\DRDO\drdo\component\Actel\DirectCore\CoreAPB3\4.2.100\rtl\vhdl\core\coreapb3.vhd}
read_vhdl -mode vhdl_2008 -lib COREAPB3_LIB {E:\Projects\DRDO\drdo\component\Actel\DirectCore\CoreAPB3\4.2.100\rtl\vhdl\core\components.vhd}
read_vhdl -mode vhdl_2008 {E:\Projects\DRDO\drdo\component\work\CoreAPB3_C0\CoreAPB3_C0.vhd}
read_vhdl -mode vhdl_2008 {E:\Projects\DRDO\drdo\component\work\FCCC_C0\FCCC_C0_0\FCCC_C0_FCCC_C0_0_FCCC.vhd}
read_vhdl -mode vhdl_2008 {E:\Projects\DRDO\drdo\component\work\FCCC_C0\FCCC_C0.vhd}
read_vhdl -mode vhdl_2008 {E:\Projects\DRDO\drdo\component\work\MSS_C0_MSS\MSS_C0_MSS.vhd}
read_verilog -mode system_verilog {E:\Projects\DRDO\drdo\hdl\apb_led_slave.v}
read_vhdl -mode vhdl_2008 {E:\Projects\DRDO\drdo\component\work\top_soc_new\top_soc_new.vhd}
set_top_level {top_soc_new}
map_netlist
check_constraints {E:\Projects\DRDO\drdo\constraint\synthesis_sdc_errors.log}
write_fdc {E:\Projects\DRDO\drdo\designer\top_soc_new\synthesis.fdc}
