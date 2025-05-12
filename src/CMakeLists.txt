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

#############################################################################

# add_subdirectory(altera)
# add_subdirectory(xilinx)
# add_subdirectory(model)

set(TOP_MODULE_NAME 		buffer 		PARENT_SCOPE)
set(TESTBENCH_MODULE_NAME 	buffer_tb 	PARENT_SCOPE)

# All Verilog & VHDL files which go to synthesis
set(VERILOG_SYN_SRC_FILES 
	buffer.v
)

set(VHDL_SYN_SRC_FILES 
	adder.vhd
)

set(VERILOG_TB_SRC_FILE
	buffer_tb.v
)

set(VHDL_TB_SRC_FILE
)

if( ${TARGET} MATCHES "xilinx" )

	foreach (_src ${XILINX_VERILOG_SYN_SRC_FILES_ABS})
		list(APPEND VERILOG_SYN_SRC_FILES ${_src})
	endforeach (_src ${XILINX_VERILOG_SYN_SRC_FILES_ABS})
		
	foreach (_src ${XILINX_VHDL_SYN_SRC_FILES_ABS})
		list(APPEND VHDL_SYN_SRC_FILES ${_src})
	endforeach (_src ${XILINX_VHDL_SYN_SRC_FILES_ABS})

	message( STATUS "Using Xilinx Library" )

elseif(${TARGET} MATCHES "altera")

	foreach (_src ${ALTERA_VERILOG_SYN_SRC_FILES_ABS})
		list(APPEND VERILOG_SYN_SRC_FILES ${_src})
	endforeach (_src ${ALTERA_VERILOG_SYN_SRC_FILES_ABS})
	
	foreach (_src ${ALTERA_VHDL_SYN_SRC_FILES_ABS})
		list(APPEND VHDL_SYN_SRC_FILES ${_src})
	endforeach (_src ${ALTERA_VHDL_SYN_SRC_FILES_ABS})

	message( STATUS "Using Altera Library")

else()

	foreach (_src ${MODEL_VERILOG_SYN_SRC_FILES_ABS})
		list(APPEND VERILOG_SYN_SRC_FILES ${_src})
	endforeach (_src ${MODEL_VERILOG_SYN_SRC_FILES_ABS})
	
	foreach (_src ${MODEL_VHDL_SYN_SRC_FILES_ABS})
		list(APPEND VHDL_SYN_SRC_FILES ${_src})
	endforeach (_src ${MODEL_VHDL_SYN_SRC_FILES_ABS})

	message( STATUS "Using Behavioral Model Library")

endif()

set(VERILOG_SYN_SRC_FILES 	${VERILOG_SYN_SRC_FILES} 	PARENT_SCOPE)
set(VHDL_SYN_SRC_FILES 		${VHDL_SYN_SRC_FILES} 		PARENT_SCOPE)
set(VERILOG_SRC_DIR 		${CMAKE_CURRENT_SOURCE_DIR} PARENT_SCOPE)
set(VHDL_SRC_DIR 			${CMAKE_CURRENT_SOURCE_DIR} PARENT_SCOPE)

# Verilog & VHDL files for synthesis plus testbench files
set(VERILOG_SRC_FILES 
	${VERILOG_SYN_SRC_FILES}
	${VERILOG_TB_SRC_FILE}
	PARENT_SCOPE)

set(VHDL_SRC_FILES 
	${VHDL_SYN_SRC_FILES}
	${VHDL_TB_SRC_FILE}
	PARENT_SCOPE)
