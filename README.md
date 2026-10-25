# 16-bit RISC-Style CPU in Verilog

A custom 16-bit RISC-style processor designed using **Verilog HDL** and simulated with **Xilinx Vivado**. The project implements a processor datapath, instruction decoding, control logic, register operations, memory access, branching, jumping, and simulation-based verification.

> **Current status:** Single-cycle CPU with arithmetic and logical operations, load/store instructions, control flow, and a self-checking testbench. Pipelining is planned as a future enhancement.

## Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Features](#features)
- [Instruction Support](#instruction-support)
- [Project Structure](#project-structure)
- [Datapath Operation](#datapath-operation)
- [Verification](#verification)
- [Tools Used](#tools-used)
- [Future Improvements](#future-improvements)

## Overview

This project explores the design and verification of a custom 16-bit processor, from individual RTL modules to an integrated CPU.

The processor uses a 16-bit datapath and a 32-bit instruction format. Its design separates instruction decoding, control-signal generation, register access, ALU execution, memory access, and register writeback into modular Verilog components.

The goal is to understand how a processor executes instructions at the hardware level and establish a working baseline for future pipelining and microarchitectural improvements.

## Architecture

| Component | Specification |
|---|---|
| Processor type | Custom RISC-style CPU |
| Datapath width | 16 bits |
| Instruction width | 32 bits |
| General-purpose registers | 16 × 16-bit registers |
| Register address width | 4 bits |
| Opcode width | 4 bits |
| Program counter | 16 bits |
| ALU | 16-bit arithmetic and logic unit |
| Design style | Single-cycle, non-pipelined |
| HDL | Verilog |
| Development environment | Xilinx Vivado |

The processor uses a custom instruction encoding; it is **not an implementation of the RISC-V ISA**.

## Features

- **ALU:** Arithmetic and bitwise operations, with status flags.
- **Register file:** Sixteen 16-bit registers with two combinational read ports and a clocked write port.
- **Instruction decoder:** Extracts the opcode, register fields, and immediate value from each instruction.
- **Control unit:** Generates the control signals required for instruction execution.
- **Program counter:** Supports sequential instruction execution, branches, jumps, and halt behavior.
- **Instruction memory:** Supplies 32-bit instructions to the processor.
- **Data memory:** Supports memory reads and writes for load/store operations.
- **Writeback datapath:** Selects the appropriate result for writing back to the register file.
- **Simulation-based verification:** Includes a CPU testbench and individual module testbenches.

## Instruction Support

The implemented instruction categories include:

| Category | Operations |
|---|---|
| Arithmetic | Addition, subtraction, and related supported ALU operations |
| Logical | AND, OR, XOR, and other supported logic operations |
| Immediate operations | Operations using an immediate operand |
| Memory access | LOAD and STORE |
| Control flow | Conditional branches, jump, and halt |
| Shifts | Supported shift operations |

The exact opcode encoding and operand formats are defined by the decoder and control-unit RTL. Refer to those modules for the authoritative instruction mapping.

## Project Structure

```text
16bit-cpu/
├── cpu_16.srcs/
│   ├── sources_1/
│   │   └── new/
│   │       ├── alu.v
│   │       ├── alu_mux.v
│   │       ├── control_unit.v
│   │       ├── cpu.v
│   │       ├── data_memory.v
│   │       ├── decoder.v
│   │       ├── instruction_memory.v
│   │       ├── pc.v
│   │       ├── register_file.v
│   │       └── writeback_mux.v
│   └── sim_1/
│       └── new/
│           ├── alu_mux_tb.v
│           ├── alu_tb.v
│           ├── cpu_tb.v
│           ├── data_memory_tb.v
│           ├── decoder_tb.v
│           ├── pc_tb.v
│           ├── register_file_tb.v
│           └── writeback_mux_tb.v
├── program.mem
├── cpu_16.xpr
├── .gitignore
└── README.md
```

## Datapath Operation

The processor follows this general instruction-execution flow:

1. **Instruction fetch:** The program counter selects an instruction from instruction memory.
2. **Decode:** The decoder extracts instruction fields, and the control unit generates the required control signals.
3. **Register read:** The register file supplies the source operands.
4. **Execute:** The ALU performs the requested operation or calculates a memory address.
5. **Memory access:** LOAD reads data from data memory; STORE writes data to memory.
6. **Writeback:** The writeback multiplexer selects the ALU result or memory data for the destination register, as appropriate.
7. **Next PC:** The processor advances to the next instruction or changes the program counter when a branch, jump, or halt condition requires it.

For LOAD and STORE, the ALU result is used as the memory address. A LOAD routes the retrieved data back to the register file, while a STORE writes the source-register data into memory.

## Verification

The repository includes testbenches for the CPU and several individual modules.

Verification should cover:

- ALU operations and status flags.
- Register-file reads and clocked writes.
- Instruction decoding and control-signal generation.
- Program-counter updates, including branches, jumps, and halt.
- Data-memory read/write behavior.
- LOAD/STORE datapath operation.
- End-to-end instruction execution using the CPU testbench.

Run the self-checking CPU testbench in Vivado and confirm that all expected register and memory values match the actual results.

Simulation evidence and detailed test results can be added as they are documented.

## Running the Project

1. Install Xilinx Vivado.
2. Clone or download this repository.
3. Open `cpu_16.xpr` in Vivado.
4. Check the source and simulation file sets.
5. Confirm that `program.mem` is available at the path expected by the instruction-memory module.
6. Select `cpu_tb` as the simulation top module.
7. Run behavioral simulation and inspect the testbench output and waveforms.

**Note:** File paths for `$readmemh` depend on the simulation working directory. If the instruction memory cannot find `program.mem`, update the file path or Vivado simulation settings accordingly.

## Tools Used

- Verilog HDL
- Xilinx Vivado
- Git and GitHub

## Instruction Set Architecture (ISA)

The processor uses a custom 32-bit instruction format with a 16-bit datapath. Instructions contain a 4-bit opcode, three 4-bit register fields, and a 16-bit immediate field. The opcode determines the operation performed by the control unit.

### Instruction Format

| Field | Bits | Description |
|---|---|---|
| Opcode | `[31:28]` | Selects the instruction |
| Destination register (`rd`) | `[27:24]` | Destination register field |
| Source register 1 (`rs1`) | `[23:20]` | First source register field |
| Source register 2 (`rs2`) | `[19:16]` | Second source register field |
| Immediate (`imm`) | `[15:0]` | 16-bit immediate field |

### Supported Instructions

| Opcode | Mnemonic | Description |
|---|---|---|
| `0x0` | Reserved / NOP-like | No control signals asserted |
| `0x1` | ADD | Adds two operands |
| `0x2` | SUB | Subtracts the second operand from the first |
| `0x3` | AND | Bitwise AND |
| `0x4` | OR | Bitwise OR |
| `0x5` | XOR | Bitwise XOR |
| `0x6` | NOT | Bitwise complement of operand A |
| `0x7` | ADDI | Adds an immediate operand |
| `0x8` | LOAD | Reads data memory and writes the result back to a register |
| `0x9` | STORE | Writes register data to data memory |
| `0xA` | BEQ | Branch-equal control; uses subtraction for comparison |
| `0xB` | BNE | Branch-not-equal control; uses subtraction for comparison |
| `0xC` | JMP | Activates jump control |
| `0xD` | SLL | Logical left shift |
| `0xE` | SRL | Logical right shift |
| `0xF` | HALT | Activates the halt signal |

### ALU Operations

The ALU supports addition, subtraction, bitwise logic, increment, decrement, logical shifts, equality comparison, and operand pass-through operations. It also generates zero, carry, overflow, and negative flags.

The instruction opcode and ALU select code are separate encodings. The control unit translates instruction opcodes into ALU select signals.

### Architecture Notes

- 16-bit data path and 32-bit instructions.
- 16 general-purpose register addresses, encoded using 4-bit register fields.
- Separate instruction and data memory modules.
- Control-unit-driven ALU, memory access, branching, jumping, and halt control.
- Single-cycle, non-pipelined implementation.


## Future Improvements

- Add a five-stage pipeline: IF, ID, EX, MEM, and WB.
- Introduce pipeline registers between stages.
- Implement data forwarding and hazard detection.
- Add stalls and pipeline flushing for control hazards.
- Expand the instruction set and test coverage.
- Capture simulation waveforms and document expected-versus-actual results.
- Evaluate synthesis resource utilization and timing.

## Author

**Lewin Mariya**

Developed as a digital design and computer architecture project to explore processor datapaths, RTL design, and functional verification.
