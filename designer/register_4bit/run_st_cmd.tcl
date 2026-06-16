read_sdc -scenario "timing_analysis" -netlist "optimized" -pin_separator "/" -ignore_errors {E:/Projects/DRDO/drdo/designer/register_4bit/timing_analysis.sdc}
set_options -analysis_scenario "timing_analysis" 
save
