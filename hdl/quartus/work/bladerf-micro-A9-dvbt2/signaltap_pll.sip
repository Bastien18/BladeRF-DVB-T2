set_global_assignment -entity "signaltap_pll" -library "lib_signaltap_pll" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "signaltap_pll" -library "lib_signaltap_pll" -name IP_TOOL_VERSION "17.1"
set_global_assignment -entity "signaltap_pll" -library "lib_signaltap_pll" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_signaltap_pll" -name SPD_FILE [file join $::quartus(sip_path) "signaltap_pll.spd"]

set_global_assignment -library "lib_signaltap_pll" -name MISC_FILE [file join $::quartus(sip_path) "signaltap_pll_sim/signaltap_pll.vho"]
