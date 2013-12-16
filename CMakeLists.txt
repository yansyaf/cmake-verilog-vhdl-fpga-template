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
cmake_minimum_required(VERSION 2.8)

# Select one of option bellow to be ON/OFF
set(USING_XILINX 0 CACHE STRING "Xilinx Option")
set(USING_ALTERA 1 CACHE STRING "Altera Option")

#############################################################################
# Option available:
# - xilinx
# - altera
# - model
set(TARGET "xilinx")

add_subdirectory(src)
add_subdirectory(sim)
add_subdirectory(pnr)
