Project Checkpoint 1-2 - Simple ALU

Name: Jingheng Huan

NetID: jh730

In this project, I implemented a 32-bit Arithmetic Logic Unit (ALU) that supports various arithmetic and logical operations, including `addition`, `subtraction`, `bitwise AND`, `bitwise OR`, `logical shift left (SLL)`, and `arithmetic shift right (SRA)`.

- I utilized a 32-bit Carry Lookahead Adder (CLA) to perform fast arithmetic operations. The CLA is constructed by eight 4-bit CLA modules, which enhances the speed by reducing the carry propagation delay compared to a traditional Ripple Carry Adder.
- Subtraction is achieved by computing the two’s complement of the second operand (data_operandB). This is done by inverting data_operandB and adding one (`~data_operandB + 1`).
- To comply with the project’s Verilog restrictions, I avoided behavioral statements like `if` or `case`. Instead, I used wire signals to represent operation codes (`op_add`, `op_sub`) and employed ternary operators with wire conditions for selecting operations and operands.
- `Addition Overflow` occurs when adding two operands of the same sign results in a different sign.
- `Subtraction Overflow` occurs when subtracting operands of different signs results in a sign different from the first operand.
- This ALU supports `bitwise AND and OR` operations, calculated by applying the respective operations on each bit of the input operands.
- `Logical Shift Left (SLL)`: Implements left shifting of `data_operandA` by `ctrl_shiftamt` bits, filling the vacated bits with zeros.
- `Arithmetic Shift Right (SRA)`: Performs a right shift on `data_operandA` by `ctrl_shiftamt` bits, with the sign bit replicated to maintain the number’s sign.
- `isNotEqual`: Indicates whether two operands are unequal, set when subtraction (`op_sub`) results in a non-zero outcome.
- `isLessThan`: Signals that `data_operandA` is less than `data_operandB` when the most significant bit of the subtraction result is set.

Permitted Constructs

	•	Ternary Assign: Allowed only when cond, high, and low are wires or input/output ports, without expressions in cond.
	•	Primitive Instantiation: and (out, in1, in2) and other basic gate instantiations.
	•	Bitwise NOT: Using ~.
	•	Generate Blocks: generate if, generate for, and genvar are allowed.
	•	RCA Usage: Ripple Carry Adders can be used to construct components, but the 32-bit adder itself should not be an RCA.
	•	Parameters: Both parameter and localparam are allowed.
	•	Range Expressions: Complex expressions within range specifiers, such as a[i*15+36/2-13%2].

Banned Constructs

	•	Behavioral Description Structures: Including if, else, for (except generate for), case.
	•	Megafunctions: Operators like +, -, *, /, %, **, ==, >, >=, <=, &&, ||, !, <<, <<<, >>, >>> are not allowed outside of generate control or parameter expressions.
	•	SystemVerilog: Prohibited, except when constructing DFFE.