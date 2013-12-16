# Copyright 2013 Yan Syafri Hidayat, PT Fusi Global Teknologi
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

set (SYN_SRC_FILE ${CMAKE_CURRENT_BINARY_DIR}/sources.tcl)

file(WRITE ${SYN_SRC_FILE} "\n#Verilog Source Files for synthesis\n")

foreach (_src ${VERILOG_SYN_SRC_FILES})
  file(APPEND ${SYN_SRC_FILE} "set_global_assignment -name VERILOG_FILE " ${VERILOG_SRC_DIR}/${_src}\n)
  list(APPEND SYN_SRC_ABS ${VERILOG_SRC_DIR}/${_src})
endforeach (_src ${VERILOG_SYN_SRC_FILES})

file(APPEND ${SYN_SRC_FILE} "\n#VHDL Source Files for synthesis\n")

foreach (_src ${VHDL_SYN_SRC_FILES})
  file(APPEND ${SYN_SRC_FILE} "set_global_assignment -name VHDL_FILE " ${VHDL_SRC_DIR}/${_src}\n)
  list(APPEND SYN_SRC_ABS ${VHDL_SRC_DIR}/${_src})
endforeach (_src ${VHDL_SYN_SRC_FILES})

configure_file ("${CMAKE_CURRENT_SOURCE_DIR}/synscript.tcl.in"
                "${CMAKE_CURRENT_BINARY_DIR}/synscript.tcl" )

add_custom_command(
  OUTPUT fmax.log
  COMMAND quartus_sh -t ${CMAKE_CURRENT_BINARY_DIR}/synscript.tcl
  DEPENDS ${SYN_SRC_ABS}
)

add_custom_target(syn DEPENDS fmax.log)
