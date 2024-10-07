Project Checkpoint 3 - 32x32 Register File

Name: Jingheng Huan

NetID: jh730

This project checkpoint implements a 32-register, 32-bit-wide register file. The register file has:

- Two `read port`s that can read from any two registers simultaneously.
- One `write port` to write data into a specified register.
- 32 registers, where each register is `32 bits wide`.
- `Register 0` is hard-wired to 0, meaning it always reads as 32’b0, regardless of any write operation.


Modules

1. regfile

This main module implements the register file that supports reading and writing data from/to the registers.

Inputs:

- clock
- ctrl_writeEnable
- ctrl_reset
- ctrl_writeReg (5 bits)
- ctrl_readRegA, ctrl_readRegB (5 bits)
- data_writeReg (32 bits)

Outputs:

- data_readRegA, data_readRegB: 32-bits

The module uses decoders to select the appropriate register for reading and writing, and tri-state buffers to handle reading.

2. regfile_decoder

This module is a 5-to-32 decoder, which converts a 5-bit input (sel) into a 32-bit output (out), where only one bit is high, corresponding to the selected register.

Inputs:

- sel: A 5-bit register address.

Outputs:

- out: A 32-bit signal where one bit is high, indicating the selected register.

3. regfile_tristate

This module implements 32-bit tri-state buffers. It outputs data_in to data_out only if enable is high; otherwise, it outputs a high-impedance (1'bz).

Inputs:

- data_in: The 32-bit data to be passed through.
- enable: The enable signal for the tri-state buffer.

Outputs:

- data_out: The buffered 32-bit output.

4. register_32

This module implements a 32-bit register using D flip-flops. It stores 32 bits of data and can be cleared or enabled based on control signals.

Inputs:

- d: 32-bit input data.
- clk
- en: Enable signal. 
- clr: Clear signal.

Outputs:

- q: The 32-bit output data stored in the register.

5. dffe_ref

This is a D flip-flop with enable (en) and clear (clr) functionalities. It stores one bit of data (d), and on a positive clock edge, it updates its value if en is high. If clr is high, it resets the stored value to 0.

Inputs:

- d
- clk
- en
- clr

Outputs:

- q: The output data.

6. regfile_tb

This is the testbench module for simulating the register file. It writes and reads back data from each of the 32 registers to validate the functionality.

Features:

- Generates clock and reset signals.
- Writes the value 32'h0000DEAD into each register and checks that it can be read back correctly, except for register 0, which is always 0.
- Tracks and reports any errors during the simulation.

Expected Behavior

- Register 0 always returns 0, regardless of any write operation.
- All other registers store and return the values written to them.
- The testbench will report an error if any register does not behave as expected.
