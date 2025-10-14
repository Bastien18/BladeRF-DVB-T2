set_global_assignment -entity "T2_clock" -library "lib_T2_clock" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "T2_clock" -library "lib_T2_clock" -name IP_TOOL_VERSION "17.1"
set_global_assignment -entity "T2_clock" -library "lib_T2_clock" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_T2_clock" -name SPD_FILE [file join $::quartus(sip_path) "T2_clock.spd"]

set_global_assignment -library "lib_T2_clock" -name MISC_FILE [file join $::quartus(sip_path) "T2_clock_sim/T2_clock.vho"]
