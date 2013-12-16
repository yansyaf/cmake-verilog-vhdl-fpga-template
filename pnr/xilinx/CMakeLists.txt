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

set (DEVICE_FAMILY 			xc4vlx15)

set (SYN_SRC_FILE ${CMAKE_CURRENT_BINARY_DIR}/${TOP_MODULE_NAME}.prj)

file(WRITE ${SYN_SRC_FILE} "\n")

foreach (_src ${VHDL_SYN_SRC_FILES})
  file(APPEND ${SYN_SRC_FILE} "vhdl work \"${VHDL_SRC_DIR}/${_src}\"\n")
  list(APPEND SYN_SRC_ABS ${VHDL_SRC_DIR}/${_src})
endforeach (_src ${VHDL_SYN_SRC_FILES})

foreach (_src ${VERILOG_SYN_SRC_FILES})
  file(APPEND ${SYN_SRC_FILE} "verilog work \"${VERILOG_SRC_DIR}/${_src}\"\n")
  list(APPEND SYN_SRC_ABS ${VERILOG_SRC_DIR}/${_src})
endforeach (_src ${VERILOG_SYN_SRC_FILES})

add_custom_command(
  OUTPUT xflow.log
  COMMAND xflow -p ${DEVICE_FAMILY} -synth xst_mixed.opt -implement high_effort.opt -config bitgen.opt ${TOP_MODULE_NAME}.prj
  DEPENDS ${SYN_SRC_FILE}
)

add_custom_target(syn DEPENDS xflow.log)
