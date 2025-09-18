set_global_assignment -entity "TS_clock" -library "lib_TS_clock" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "TS_clock" -library "lib_TS_clock" -name IP_TOOL_VERSION "17.1"
set_global_assignment -entity "TS_clock" -library "lib_TS_clock" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_TS_clock" -name SPD_FILE [file join $::quartus(sip_path) "TS_clock.spd"]

set_global_assignment -library "lib_TS_clock" -name MISC_FILE [file join $::quartus(sip_path) "TS_clock_sim/TS_clock.vho"]
