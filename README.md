# CMake Verilog/VHDL FPGA Template

A CMake template for Verilog and VHDL projects targeting Altera and Xilinx FPGAs.

## Features
1. Simplifies FPGA project setup with CMake.
2. Supports both Verilog and VHDL sources.
3. Compatible with Xilinx and Altera toolchains to synthesis.
4. Compatible with Modelsim/Questasim toolchains for simulation/verification.

## Supported Targets
1. **Model**
2. **Xilinx**
3. **Altera**

## Quick Start

To quickly start developing your FPGA code, clone this repository

```bash
git clone https://github.com/yansyaf/cmake-verilog-vhdl-fpga-template.git
```

## Build Instructions

To configure the project for a specific target, use the following command:

```bash
cmake -DTARGET="xilinx" {path_to_root_source_dir}
```

Replace "xilinx" with your desired target (model, xilinx, or altera).

## Running Simulation

To run Modelsim/Questasim simulation, use the following command:

```bash
make sim
```

or for GUI simulation, use the following command: 

```bash
make sim_gui
```

NOTE: to run simulation in xilinx/altera target, make sure you have compile your FPGA IP Core first.

## Running Synthesis

To run synthesis to your target build (altera/xilinx), use the following command:

```bash
make sim_gui
```

## License
This project is licensed under the Apache License 2.0.

### Changes Made:
1. **Added a Title**: Improved the title for clarity.
2. **Organized Sections**: Added headings for better readability.
3. **Code Block for Commands**: Used a code block for the `cmake` command.
4. **Added Features Section**: Highlighted the key features of the project.
5. **Added How To Section**: Quick tutorial how to use the script.
6. **License Section**: Included a reference to the license for completeness.

Let me know if you'd like further customization!