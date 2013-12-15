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
OPTION(USING_XILINX "Using Xilinx as Target" ON) 
OPTION(USING_ALTERA "Using Altera as Target" OFF) 

set(ALTERA_LIBS_DIR "C:/altera/11.0sp1/quartus/eda/sim_lib")
set(XILINX_LIBS_DIR "C:/Xilinx/13.4/ISE_DS/ISE/verilog/mti_se/6.5/nt")

set(TOP_MODULE_NAME buffer PARENT_SCOPE)

# All Verilog & VHDL files which go to synthesis
set(VERILOG_SYN_SRC_FILES 
	buffer.v
)

set(VHDL_SYN_SRC_FILES 
    adder.vhd
)

if(USING_XILINX)
	set(VHDL_SYN_SRC_FILES ${VHDL_SYN_SRC_FILES} 
		xilinx/fifo.vhd)	
elseif(USING_ALTERA)
	set(VERILOG_SYN_SRC_FILES ${VERILOG_SYN_SRC_FILES} 
		${ALTERA_LIBS_DIR}/altera_mf.v
		altera/fifo.v)	
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
