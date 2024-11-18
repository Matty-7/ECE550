# Project Checkpoint 4
## Simple Processor -- R-type and I-type

## Name and NetID: Xingyu Shen (xs90) and Jingheng Huan (jh730)

We implemented a single-cycle 32-bit processor that integrates the register file and ALU units, generating the necessary data memory (dmem) and instruction memory (imem) files through Quartus syncram components. The design supports basic R-type (`add`, `sub`, `and`, `or`, `sll`, `sra`) and I-type (`addi`, `lw`, `sw`) instructions with a 50 MHz clock.

## Bug!!! (Solved)
After hours of debugging and testing, even with help from TA Yunfan and TA Alleu, we still cannot handle overflow properly. We believe the logic of our code is correct and the testbench simulation works fine. However, it cannot pass all the overflow cases on gradescope.

## Module Descriptions

### 1. control.v
   - This module decodes the opcode and generates control signals for the processor. It determines whether the instruction is an `R-type` or `I-type` and sets the control signals for register writes, ALU inputs, and memory operations.

### 2. dffe.v
   - This module implements a `D flip-flop` with enable and clear functionality. It is used to store the`program counter (PC)` value to update correctly on clock edges while allowing for reset.

### 3. dmem.v
   - The data memory module is implemented using a `single-port RAM`. It allows for reading and writing 32-bit data at specified addresses, controlled by a write enable signal.

### 4. imem.v
   - The instruction memory module is also implemented using a `single-port ROM`. It reads 32-bit instructions from a specified address and is initialized with a `.mif file` containing the program instructions.

### 5. processor.v
   - This is the main processor module that integrates all components. It handles instruction `fetching`, `decoding`, and `execution`. The processor uses a program counter to fetch instructions from `imem`, decodes them, and executes the corresponding operations using the ALU and `regfile`.

### 6. alu.v
   - The ALU module performs arithmetic and logical operations on two 32-bit inputs. It supports operations such as `add`, `sub`, `and`, `or`, `sll`, and `sra`.

### 7. regfile.v
   - The register file module implements a set of 32 registers. It supports reading from and writing to registers based on control signals. The module ensures that writes to the zero register (`$r0`) are ignored, and keeps its value as zero. $30 is used to show the status of the processor, basically handling the overflow case.

### 8. skeleton.v
   - This module serves as a top-level wrapper around the processor. It generates the necessary `clock` signals for the imem, dmem, regfile, and processor. The skeleton module facilitates easier testing and integration of the processor with the memory components.

### 9. div4_clk.v
   - Make 1/4 the frequency of the original clock signal to make processor and register file work slower to match the speed of the memory components, who use the original clock.
