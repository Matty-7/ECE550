module alu(
	data_operandA, 
	data_operandB, 
	ctrl_ALUopcode, 
	ctrl_shiftamt, 
	data_result, 
	isNotEqual, 
	isLessThan, 
	overflow
);

   input [31:0] data_operandA, data_operandB;
   input [4:0] ctrl_ALUopcode, ctrl_shiftamt;

   output [31:0] data_result;
   output isNotEqual, isLessThan, overflow;

   // YOUR CODE HERE //
	wire [31:0] b_neg;
	wire [31:0] operandB_selected;
	wire [31:0] sum;
	wire cout;
	
	wire op_add, op_sub;
   assign op_add = (ctrl_ALUopcode == 5'b00000);
   assign op_sub = (ctrl_ALUopcode == 5'b00001);
	
	assign b_neg = ~data_operandB + 32'd1;
	
	assign operandB_selected = op_sub ? b_neg : data_operandB;
	
	cla_32bit cla32(
		.a(data_operandA),
		.b(operandB_selected),
		.cin(1'b0),
		.sum(sum),
		.cout(cout)
	);
	
	assign data_result = sum;
	
	assign overflow = ( op_add & ( (data_operandA[31] == data_operandB[31]) && (sum[31] != data_operandA[31]) ) ) |
                      ( op_sub & ( (data_operandA[31] != data_operandB[31]) && (sum[31] != data_operandA[31]) ) );
							
	assign isNotEqual = 1'b0;
	assign isLessThan = 1'b0;
		

endmodule