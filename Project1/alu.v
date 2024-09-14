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

    
    wire n0, n1, n2, n3, n4;
    not (n0, ctrl_ALUopcode[0]);
    not (n1, ctrl_ALUopcode[1]);
    not (n2, ctrl_ALUopcode[2]);
    not (n3, ctrl_ALUopcode[3]);
    not (n4, ctrl_ALUopcode[4]);

    
    wire and0_out, and1_out, and2_out;
    and (and0_out, n0, n1);
    and (and1_out, n2, n3);
    and (and2_out, and0_out, and1_out);
    and (op_add, and2_out, n4);

    
    wire and0_out_sub, and1_out_sub, and2_out_sub;
    and (and0_out_sub, n1, n2);
    and (and1_out_sub, n3, n4);
    and (and2_out_sub, and0_out_sub, and1_out_sub);
    and (op_sub, and2_out_sub, ctrl_ALUopcode[0]);

    
    wire [31:0] operandB_selected;
    generate
        genvar i;
        for (i = 0; i < 32; i = i +1) begin : gen_operandB_selected
            xor (operandB_selected[i], data_operandB[i], op_sub);
        end
    endgenerate

    
    wire carry_in;
    assign carry_in = op_sub;

    
    wire [31:0] sum;
    wire cout;
    cla_32bit cla32(
        .a(data_operandA),
        .b(operandB_selected),
        .cin(carry_in),
        .sum(sum),
        .cout(cout)
    );

    
    wire a31_xor_b31;
    xor (a31_xor_b31, data_operandA[31], data_operandB[31]);
    wire a31_eq_b31;
    not (a31_eq_b31, a31_xor_b31); 

    
    wire sum31_xor_a31;
    xor (sum31_xor_a31, sum[31], data_operandA[31]); 

    
    wire add_overflow_temp;
    and (add_overflow_temp, a31_eq_b31, sum31_xor_a31);
    and (add_overflow, op_add, add_overflow_temp);

    
    wire sub_overflow_temp;
    and (sub_overflow_temp, a31_xor_b31, sum31_xor_a31);
    and (sub_overflow, op_sub, sub_overflow_temp);

    
    or (overflow, add_overflow, sub_overflow);

    
    assign data_result = sum;

    
    assign isNotEqual = 1'b0;
    assign isLessThan = 1'b0;

endmodule