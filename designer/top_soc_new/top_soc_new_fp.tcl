new_project \
         -name {top_soc_new} \
         -location {E:\Projects\DRDO\drdo\designer\top_soc_new\top_soc_new_fp} \
         -mode {chain} \
         -connect_programmers {FALSE}
add_actel_device \
         -device {M2S010} \
         -name {M2S010}
enable_device \
         -name {M2S010} \
         -enable {TRUE}
save_project
close_project
