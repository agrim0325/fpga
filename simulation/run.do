quietly set ACTELLIBNAME SmartFusion2
quietly set PROJECT_DIR "E:/Projects/DRDO/drdo"
onerror { quit -f }
onbreak { quit -f }

if {[file exists ../designer/apb_led_slave/simulation/postlayout/_info]} {
   echo "INFO: Simulation library ../designer/apb_led_slave/simulation/postlayout already exists"
} else {
   file delete -force ../designer/apb_led_slave/simulation/postlayout 
   vlib ../designer/apb_led_slave/simulation/postlayout
}
vmap postlayout ../designer/apb_led_slave/simulation/postlayout
vmap SmartFusion2 "E:/Microchip/Libero_SoC_2025.2/Libero_SoC/Designer/lib/modelsimpro/precompiled/vlog/smartfusion2"
if {[file exists COREAPB3_LIB/_info]} {
   echo "INFO: Simulation library COREAPB3_LIB already exists"
} else {
   file delete -force COREAPB3_LIB 
   vlib COREAPB3_LIB
}
vmap COREAPB3_LIB "COREAPB3_LIB"

vcom -2008 -explicit  -work postlayout "${PROJECT_DIR}/designer/apb_led_slave/apb_led_slave_ba.vhd"
vlog "+incdir+${PROJECT_DIR}/stimulus" -sv -work postlayout "${PROJECT_DIR}/stimulus/apb_led_slave_tb.v"

vsim -L SmartFusion2 -L postlayout -L COREAPB3_LIB  -t 1fs -sdfmax /apb_led_slave_0=${PROJECT_DIR}/designer/apb_led_slave/apb_led_slave_ba.sdf +transport_path_delays postlayout.tb_apb_led_slave
add wave /tb_apb_led_slave/*
run 1000ns
log /tb_apb_led_slave/*
exit
