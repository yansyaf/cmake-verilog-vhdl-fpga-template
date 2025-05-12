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

project ("My Project")
cmake_minimum_required(VERSION 3.1)

#############################################################################
# Option available:
# - xilinx
# - altera
# - model
#set(TARGET "model")
set(TARGET "model" CACHE STRING
  "Select the HDL model. Supported values are: xilinx;altera;model")
set(target_values "xilinx;altera;model" CACHE STRING
  "List of possible HDL models")
set_property(CACHE TARGET PROPERTY STRINGS ${target_values})
message(STATUS "TARGET='${TARGET}'")

if(NOT ((${TARGET} STREQUAL "xilinx") OR (${TARGET} STREQUAL "altera") OR (${TARGET} STREQUAL "model")))
   message(FATAL_ERROR "Unsupported HDL model: ${TARGET}")
endif()

set (DEVICE_FAMILY 	"xc7a100tfgg676-1" CACHE STRING "FPGA device family")

add_subdirectory(src)
add_subdirectory(sim)
add_subdirectory(pnr)
add_subdirectory(lib)
