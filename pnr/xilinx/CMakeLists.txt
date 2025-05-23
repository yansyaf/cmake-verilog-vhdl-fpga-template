#Copyright 2013 Friedrich Beckmann, Hochschule Augsburg
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
# CMAKE File

#############################################################################

foreach (_src ${VHDL_SYN_SRC_FILES})
  string(APPEND VHDL_SYN_SRC_ABS "${VHDL_SRC_DIR}/${_src} ")
endforeach (_src ${VHDL_SYN_SRC_FILES})

foreach (_src ${VERILOG_SYN_SRC_FILES})
  string(APPEND VERILOG_SYN_SRC_ABS "${VERILOG_SRC_DIR}/${_src} ")
endforeach (_src ${VERILOG_SYN_SRC_FILES})

file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/vivado.tcl "create_project \"${CMAKE_PROJECT_NAME}\" -part ${DEVICE_FAMILY} -force\n")
# file(APPEND ${CMAKE_CURRENT_BINARY_DIR}/vivado.tcl "set_property top ${TOP_MODULE_NAME} [current_fileset]\n")

if(DEFINED VHDL_SYN_SRC_ABS)
  file(APPEND ${CMAKE_CURRENT_BINARY_DIR}/vivado.tcl "read_vhdl \{${VHDL_SYN_SRC_ABS}\}\n")
endif()

if(DEFINED VERILOG_SYN_SRC_FILES)
  file(APPEND ${CMAKE_CURRENT_BINARY_DIR}/vivado.tcl "read_verilog \{${VERILOG_SYN_SRC_ABS}\}\n")
endif()

# write vivado tcl script
file(APPEND ${CMAKE_CURRENT_BINARY_DIR}/vivado.tcl "
read_xdc ${CMAKE_CURRENT_SOURCE_DIR}/constraints.xdc
synth_design -top ${TOP_MODULE_NAME} -part ${DEVICE_FAMILY}
write_checkpoint -force post_synth.dcp
report_utilization -file utilization.rpt
report_timing -file timing.rpt
opt_design
power_opt_design
place_design
phys_opt_design
route_design
write_checkpoint -force post_synth.dcp
write_bitstream -force ${TOP_MODULE_NAME}.bit
exit")

# add custom target to run vivado
add_custom_target(syn 
  COMMAND vivado -nojournal -nolog -mode batch -source ${CMAKE_CURRENT_BINARY_DIR}/vivado.tcl
  WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
  COMMENT "Running Vivado synthesis"
)

# Add custom target to program the FPGA
add_custom_target(program
  COMMAND vivado -nojournal -nolog -mode tcl -source ${CMAKE_CURRENT_BINARY_DIR}/program_device.tcl
  DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/${TOP_MODULE_NAME}.bit
  WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
  COMMENT "Programming the FPGA with the bitstream"
)

# Generate the TCL script for programming the FPGA
file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/program_device.tcl "
open_hw_manager
connect_hw_server
open_hw_target
current_hw_device [lindex [get_hw_devices] 0]
refresh_hw_device [current_hw_device]
set_property PROGRAM.FILE {${CMAKE_CURRENT_BINARY_DIR}/${TOP_MODULE_NAME}.bit} [current_hw_device]
program_hw_devices [current_hw_device]
close_hw_target
disconnect_hw_server
exit
")