Project Checkpoint1 - Simple ALU

Name: Jingheng Huan

NetID: jh730

In this project, I implemented a 32-bit ALU that supports addition and subtraction operations.

- I utilized a 32-bit Carry Lookahead Adder (CLA) to perform fast arithmetic operations. The CLA is constructed by eight 4-bit CLA modules, which enhances the speed by reducing the carry propagation delay compared to a traditional Ripple Carry Adder.
- Subtraction is achieved by computing the two’s complement of the second operand (data_operandB). This is done by inverting data_operandB and adding one (`~data_operandB + 1`).
- To comply with the project’s Verilog restrictions, I avoided behavioral statements like `if` or `case`. Instead, I used wire signals to represent operation codes (`op_add`, `op_sub`) and employed ternary operators with wire conditions for selecting operations and operands.
- Addition Overflow occurs when adding two operands of the same sign results in a different sign.
- Subtraction Overflow occurs when subtracting operands of different signs results in a sign different from the first operand.