open_project -project {E:\Projects\DRDO\drdo\designer\top_soc_new\top_soc_new_fp\top_soc_new.pro}\
         -connect_programmers {FALSE}
load_programming_data \
    -name {M2S010} \
    -fpga {E:\Projects\DRDO\drdo\designer\top_soc_new\top_soc_new.map} \
    -header {E:\Projects\DRDO\drdo\designer\top_soc_new\top_soc_new.hdr} \
    -spm {E:\Projects\DRDO\drdo\designer\top_soc_new\top_soc_new.spm} \
    -dca {E:\Projects\DRDO\drdo\designer\top_soc_new\top_soc_new.dca}
export_single_ppd \
    -name {M2S010} \
    -file {E:\Projects\DRDO\drdo\designer\top_soc_new\top_soc_new.ppd}

save_project
close_project
