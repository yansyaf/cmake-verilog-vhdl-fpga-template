# CMake Verilog/VHDL FPGA Template

A CMake template for Verilog and VHDL projects targeting Altera and Xilinx FPGAs.

## Supported Targets
1. **Model**
2. **Xilinx**
3. **Altera**

## Build Instructions

To configure the project for a specific target, use the following command:

```bash
cmake -DTARGET="xilinx" {path_to_root_source_dir}