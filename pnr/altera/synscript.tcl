
# Load Quartus II Tcl Project package
package require ::quartus::project
# file cat
package require fileutil


#------ Get Slack from the Report File ------#

proc get_slack_from_report {} {

	load_report arbiter
	set panel "TimeQuest Timing Analyzer||Slow Model||Slow Model Setup Summary"
	set panel_id [get_report_panel_id $panel]
	set slack [get_report_panel_data -col_name Slack -row 1 -id $panel_id]

	unload_report arbiter

	return $slack
}

proc report_slack {} {
	set setup_slack [get_slack_from_report]
	puts ""
	puts "-----------------------------------------------------"
	puts "Setup Slack : $setup_slack"
	puts "-----------------------------------------------------"
}

load_package flow
load_package report

project_new arbiter -overwrite

set_global_assignment -name FAMILY "Cyclone II"
set_global_assignment -name DEVICE EP2C20F484C7
set_global_assignment -name TOP_LEVEL_ENTITY arbiter
set_global_assignment -name MIN_CORE_JUNCTION_TEMP 0
set_global_assignment -name MAX_CORE_JUNCTION_TEMP 85
set_global_assignment -name RESERVE_ALL_UNUSED_PINS "AS INPUT TRI-STATED"

# Add the VHDL files
#set_global_assignment -name VHDL_FILE ../src/comp.vhd
source sources.tcl
set_location_assignment PIN_L1  -to clk
set_location_assignment PIN_G12 -to rst
set_location_assignment PIN_R22 -to req1

execute_flow -compile

# Write Reports
load_report arbiter
write_report_panel -file flowsummary.log "Flow Summary"
write_report_panel -file fmax.log "TimeQuest Timing Analyzer||Slow Model||Slow Model Fmax Summary"
# write_report_panel -file syn_wc_path.log "TimeQuest Timing Analyzer||Slow Model||Slow Model Worst-Case Timing Paths||Slow Model Setup: 'CLOCK_50'"

# Output Reports
puts [fileutil::cat flowsummary.log]
puts [fileutil::cat fmax.log]

#------ Report Slack from report ------#
report_slack
