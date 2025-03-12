set_global_assignment -entity "clockx2_pll" -library "lib_clockx2_pll" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "clockx2_pll" -library "lib_clockx2_pll" -name IP_TOOL_VERSION "17.1"
set_global_assignment -entity "clockx2_pll" -library "lib_clockx2_pll" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_clockx2_pll" -name SPD_FILE [file join $::quartus(sip_path) "clockx2_pll.spd"]

set_global_assignment -library "lib_clockx2_pll" -name MISC_FILE [file join $::quartus(sip_path) "clockx2_pll_sim/clockx2_pll.vho"]
