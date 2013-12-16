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

# Select one of option bellow to be ON/OFF
set(USING_XILINX 0)
set(USING_ALTERA 1)

set(TOP_MODULE_NAME buffer PARENT_SCOPE)

# All Verilog & VHDL files which go to synthesis
set(VERILOG_SYN_SRC_FILES 
	buffer.v
)

set(VHDL_SYN_SRC_FILES 
    adder.vhd
)

set(XILINX_VERILOG_SYN_SRC_FILES )

set(XILINX_VHDL_SYN_SRC_FILES 
	xilinx/fifo.vhd
)

set(ALTERA_VERILOG_SYN_SRC_FILES 
	altera/fifo.v
)

set(ALTERA_VHDL_SYN_SRC_FILES )

if(USING_XILINX)

	foreach (_src ${XILINX_VERILOG_SYN_SRC_FILES})
		list(APPEND VERILOG_SYN_SRC_FILES ${_src})
	endforeach (_src ${XILINX_VERILOG_SYN_SRC_FILES})
		
	foreach (_src ${XILINX_VHDL_SYN_SRC_FILES})
		list(APPEND VHDL_SYN_SRC_FILES ${_src})
	endforeach (_src $XILINX_VHDL_SYN_SRC_FILES})

	message( STATUS "Using Xilinx Library" )

else(USING_XILINX)
	if(USING_ALTERA)

		foreach (_src ${ALTERA_VERILOG_SYN_SRC_FILES})
			list(APPEND VERILOG_SYN_SRC_FILES ${_src})
		endforeach (_src ${ALTERA_VERILOG_SYN_SRC_FILES})
		
		foreach (_src ${ALTERA_VHDL_SYN_SRC_FILES})
			list(APPEND VHDL_SYN_SRC_FILES ${_src})
		endforeach (_src ${ALTERA_VHDL_SYN_SRC_FILES})

		message( STATUS "Using Altera Library")

	endif(USING_ALTERA)
endif(USING_XILINX)

set(VERILOG_SYN_SRC_FILES 	${VERILOG_SYN_SRC_FILES} 	PARENT_SCOPE)
set(VHDL_SYN_SRC_FILES 		${VHDL_SYN_SRC_FILES} 		PARENT_SCOPE)

# Verilog & VHDL files for synthesis plus testbench files
set(VERILOG_SRC_FILES 
	${VERILOG_SYN_SRC_FILES}
	buffer_tb.v
	PARENT_SCOPE)

set(VHDL_SRC_FILES 
	${VHDL_SYN_SRC_FILES}
	PARENT_SCOPE)

set(VERILOG_SRC_DIR ${CMAKE_CURRENT_SOURCE_DIR} PARENT_SCOPE)
set(VHDL_SRC_DIR 	${CMAKE_CURRENT_SOURCE_DIR} PARENT_SCOPE)
