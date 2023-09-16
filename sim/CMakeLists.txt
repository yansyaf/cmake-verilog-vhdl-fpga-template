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

# Verilog source code collection
# INPUT: 
#  VERILOG_SRC_FILES - Verilog file names from src directory
#  VERILOG_SRC_DIR   - path to src directory
# OUTPUT
#  SRC_ABS will contain the source files with correct path

#############################################################################

if( ${TARGET} MATCHES "xilinx" )
  set(DEFINE_LIBRARY unisims_ver)
  set(DEFINE_TARGET "TARGET_XILINX")  
elseif( ${TARGET} MATCHES "altera" )
  set(DEFINE_LIBRARY altera_mf_ver)
  set(DEFINE_TARGET "TARGET_ALTERA")
else()
  set(DEFINE_LIBRARY "work")
  set(DEFINE_TARGET "TARGET_MODEL")
endif()

macro(verilog_src_collect)
  unset(VERILOG_SRC_ABS CACHE)
  foreach (_src ${VERILOG_SRC_FILES})
      list( APPEND VERILOG_SRC_ABS ${VERILOG_SRC_DIR}/${_src})
  endforeach (_src ${VERILOG_SRC_FILES})
endmacro(verilog_src_collect)

macro(vhdl_src_collect)
  unset(VHDL_SRC_ABS CACHE)
  foreach (_src ${VHDL_SRC_FILES})
      list( APPEND VHDL_SRC_ABS ${VHDL_SRC_DIR}/${_src})
  endforeach (_src ${VHDL_SRC_FILES})
endmacro(vhdl_src_collect)

#### Custom commands

macro(add_compile_command)
  add_custom_command(
    OUTPUT work/_vlogmake
    COMMAND vlog ${VERILOG_SRC_ABS} +define+${DEFINE_TARGET}
    DEPENDS ${VERILOG_SRC_ABS} ${CMAKE_CURRENT_BINARY_DIR}/work
    COMMENT "Compiling Verilog files: ${VERILOG_SRC_ABS}"
  )

  add_custom_command(
    OUTPUT work/_vhdmake
    COMMAND vcom ${VHDL_SRC_ABS} 
    DEPENDS ${VHDL_SRC_ABS} ${CMAKE_CURRENT_BINARY_DIR}/work
    COMMENT "Compiling VHDL files: ${VHDL_SRC_ABS}"
  )

  # Generate the work library
  add_custom_command(
    OUTPUT work/
    COMMAND vlib work
    COMMENT "Generating modelsim work library"
  )
endmacro(add_compile_command)

macro(add_sim_command)
  # Run the simulation
  add_custom_command(
    OUTPUT transcript
    COMMAND echo "vsim -c -do \"run -all\;quit\" -L ${DEFINE_LIBRARY} ${TESTBENCH_MODULE_NAME}"
    COMMAND vsim -c -do \"run -all\;quit\" -L ${DEFINE_LIBRARY} ${TESTBENCH_MODULE_NAME}
    DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/work/_vlogmake ${CMAKE_CURRENT_BINARY_DIR}/work/_vhdmake
    COMMENT "Run Simulation"
  )

  add_custom_command(
    OUTPUT transcript_gui
    COMMAND echo "vsim -novopt -do \"run -all\;quit\" -L ${DEFINE_LIBRARY} ${TESTBENCH_MODULE_NAME}"
    COMMAND vsim -novopt -do \"run -all\;quit\" -L ${DEFINE_LIBRARY} ${TESTBENCH_MODULE_NAME}
    DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/work/_vlogmake ${CMAKE_CURRENT_BINARY_DIR}/work/_vhdmake
    COMMENT "Run Simulation"
  )  
endmacro(add_sim_command)

## Here are the sim and compile targets 

verilog_src_collect()
vhdl_src_collect()

add_compile_command()
add_sim_command()

add_custom_target(compile DEPENDS work/_vlogmake work/_vhdmake)

add_custom_target(sim DEPENDS transcript)
add_custom_target(sim_gui DEPENDS transcript_gui)
