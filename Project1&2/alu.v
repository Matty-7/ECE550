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

    // Invert the ctrl_ALUopcode
    wire n0, n1, n2, n3, n4;
    not (n0, ctrl_ALUopcode[0]);
    not (n1, ctrl_ALUopcode[1]);
    not (n2, ctrl_ALUopcode[2]);
    not (n3, ctrl_ALUopcode[3]);
    not (n4, ctrl_ALUopcode[4]);

    // Detect the ctrl_ALUopcode, generate operation enable signal
    wire op_add, op_sub, op_and, op_or, op_sll, op_sra;

    // op_add: 00000
    and (op_add, n4, n3, n2, n1, n0);

    // op_sub: 00001
    and (op_sub, n4, n3, n2, n1, ctrl_ALUopcode[0]);

    // op_and: 00010
    and (op_and, n4, n3, n2, ctrl_ALUopcode[1], n0);

    // op_or: 00011
    and (op_or, n4, n3, n2, ctrl_ALUopcode[1], ctrl_ALUopcode[0]);

    // op_sll: 00100
    and (op_sll, n4, n3, ctrl_ALUopcode[2], n1, n0);

    // op_sra: 00101
    and (op_sra, n4, n3, ctrl_ALUopcode[2], n1, ctrl_ALUopcode[0]);

    // Select the operandB for addition or subtraction
    wire [31:0] operandB_selected;
    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin : gen_operandB_selected
            xor (operandB_selected[i], data_operandB[i], op_sub);
        end
    endgenerate

    wire carry_in;
    assign carry_in = op_sub;

    // 32-bit CLA
    wire [31:0] sum;
    wire cout;
    cla_32bit cla32(
        .a(data_operandA),
        .b(operandB_selected),
        .cin(carry_in),
        .sum(sum),
        .cout(cout)
    );

    // Addition overflow detection
    wire add_a31_xor_b31;
    xor (add_a31_xor_b31, data_operandA[31], data_operandB[31]); // A[31] ^ B[31]
    wire add_a31_eq_b31;
    not (add_a31_eq_b31, add_a31_xor_b31); // ~(A[31] ^ B[31]) => A[31] == B[31]
    wire add_sum31_xor_a31;
    xor (add_sum31_xor_a31, sum[31], data_operandA[31]); // sum[31] ^ A[31]
    wire add_overflow_temp;
    and (add_overflow_temp, add_a31_eq_b31, add_sum31_xor_a31);
    and (add_overflow, op_add, add_overflow_temp);

    // Subtraction overflow detection
    wire sub_a31_xor_b31;
    xor (sub_a31_xor_b31, data_operandA[31], data_operandB[31]); // A[31] ^ B[31]
    wire sub_sum31_xor_a31;
    xor (sub_sum31_xor_a31, sum[31], data_operandA[31]); // sum[31] ^ A[31]
    wire sub_overflow_temp;
    and (sub_overflow_temp, sub_a31_xor_b31, sub_sum31_xor_a31);
    and (sub_overflow, op_sub, sub_overflow_temp);

    // Total overflow signal
    or (overflow, add_overflow, sub_overflow);

    // Bitwise operations: AND and OR
    wire [31:0] and_result, or_result;
    generate
        for (i = 0; i < 32; i = i + 1) begin : gen_bitwise_ops
            and (and_result[i], data_operandA[i], data_operandB[i]);
            or  (or_result[i], data_operandA[i], data_operandB[i]);
        end
    endgenerate

    // Shift operation

    // Inverse ctrl_shiftamt
    wire not_ctrl_shiftamt0, not_ctrl_shiftamt1, not_ctrl_shiftamt2, not_ctrl_shiftamt3, not_ctrl_shiftamt4;
    not (not_ctrl_shiftamt0, ctrl_shiftamt[0]);
    not (not_ctrl_shiftamt1, ctrl_shiftamt[1]);
    not (not_ctrl_shiftamt2, ctrl_shiftamt[2]);
    not (not_ctrl_shiftamt3, ctrl_shiftamt[3]);
    not (not_ctrl_shiftamt4, ctrl_shiftamt[4]);

    // SLL
    wire [31:0] sll_stage0, sll_stage1, sll_stage2, sll_stage3, sll_stage4, sll_result;
    assign sll_stage0 = data_operandA;

    // Shift stages
    // Stage 1: Shift by 1 bit
    wire [31:0] sll_shift1;
    assign sll_shift1 = {sll_stage0[30:0], 1'b0};

    generate
        for (i = 0; i < 32; i = i +1) begin : sll_stage1_gen
            wire sll_shift, sll_no_shift;
            and (sll_shift, sll_shift1[i], ctrl_shiftamt[0]);
            and (sll_no_shift, sll_stage0[i], not_ctrl_shiftamt0);
            or (sll_stage1[i], sll_shift, sll_no_shift);
        end
    endgenerate

    // Stage 2: Shift by 2 bits
    wire [31:0] sll_shift2;
    assign sll_shift2 = {sll_stage1[29:0], 2'b00};

    generate
        for (i = 0; i < 32; i = i +1) begin : sll_stage2_gen
            wire sll_shift, sll_no_shift;
            and (sll_shift, sll_shift2[i], ctrl_shiftamt[1]);
            and (sll_no_shift, sll_stage1[i], not_ctrl_shiftamt1);
            or (sll_stage2[i], sll_shift, sll_no_shift);
        end
    endgenerate

    // Stage 3: Shift by 4 bits
    wire [31:0] sll_shift4;
    assign sll_shift4 = {sll_stage2[27:0], 4'b0000};

    generate
        for (i = 0; i < 32; i = i +1) begin : sll_stage3_gen
            wire sll_shift, sll_no_shift;
            and (sll_shift, sll_shift4[i], ctrl_shiftamt[2]);
            and (sll_no_shift, sll_stage2[i], not_ctrl_shiftamt2);
            or (sll_stage3[i], sll_shift, sll_no_shift);
        end
    endgenerate

    // Stage 4: Shift by 8 bits
    wire [31:0] sll_shift8;
    assign sll_shift8 = {sll_stage3[23:0], 8'b00000000};

    generate
        for (i = 0; i < 32; i = i +1) begin : sll_stage4_gen
            wire sll_shift, sll_no_shift;
            and (sll_shift, sll_shift8[i], ctrl_shiftamt[3]);
            and (sll_no_shift, sll_stage3[i], not_ctrl_shiftamt3);
            or (sll_result[i], sll_shift, sll_no_shift);
        end
    endgenerate

    // SRA
    wire [31:0] sra_stage0, sra_stage1, sra_stage2, sra_stage3, sra_stage4, sra_result;
    assign sra_stage0 = data_operandA;

    // Shift stages
    // Stage 1: Shift by 1 bit
    wire [31:0] sra_shift1;
    assign sra_shift1 = {sra_stage0[31], sra_stage0[31:1]};

    generate
        for (i = 0; i < 32; i = i +1) begin : sra_stage1_gen
            wire sra_shift, sra_no_shift;
            and (sra_shift, sra_shift1[i], ctrl_shiftamt[0]);
            and (sra_no_shift, sra_stage0[i], not_ctrl_shiftamt0);
            or (sra_stage1[i], sra_shift, sra_no_shift);
        end
    endgenerate

    // Stage 2: Shift by 2 bits
    wire [31:0] sra_shift2;
    assign sra_shift2 = {{2{sra_stage1[31]}}, sra_stage1[31:2]};

    generate
        for (i = 0; i < 32; i = i +1) begin : sra_stage2_gen
            wire sra_shift, sra_no_shift;
            and (sra_shift, sra_shift2[i], ctrl_shiftamt[1]);
            and (sra_no_shift, sra_stage1[i], not_ctrl_shiftamt1);
            or (sra_stage2[i], sra_shift, sra_no_shift);
        end
    endgenerate

    // Stage 3: Shift by 4 bits
    wire [31:0] sra_shift4;
    assign sra_shift4 = {{4{sra_stage2[31]}}, sra_stage2[31:4]};

    generate
        for (i = 0; i < 32; i = i +1) begin : sra_stage3_gen
            wire sra_shift, sra_no_shift;
            and (sra_shift, sra_shift4[i], ctrl_shiftamt[2]);
            and (sra_no_shift, sra_stage2[i], not_ctrl_shiftamt2);
            or (sra_stage3[i], sra_shift, sra_no_shift);
        end
    endgenerate

    // Stage 4: Shift by 8 bits
    wire [31:0] sra_shift8;
    assign sra_shift8 = {{8{sra_stage3[31]}}, sra_stage3[31:8]};

    generate
        for (i = 0; i < 32; i = i +1) begin : sra_stage4_gen
            wire sra_shift, sra_no_shift;
            and (sra_shift, sra_shift8[i], ctrl_shiftamt[3]);
            and (sra_no_shift, sra_stage3[i], not_ctrl_shiftamt3);
            or (sra_result[i], sra_shift, sra_no_shift);
        end
    endgenerate

    // Select the final data_result
    generate
        for (i = 0; i <32; i = i +1) begin : result_mux
            wire mux_add, mux_sub, mux_and, mux_or, mux_sll, mux_sra;
            and (mux_add, sum[i], op_add);
            and (mux_sub, sum[i], op_sub);
            and (mux_and, and_result[i], op_and);
            and (mux_or, or_result[i], op_or);
            and (mux_sll, sll_result[i], op_sll);
            and (mux_sra, sra_result[i], op_sra);
            or (data_result[i], mux_add, mux_sub, mux_and, mux_or, mux_sll, mux_sra);
        end
    endgenerate

    // isNotEqual
    wire sum_is_zero;
    nor (sum_is_zero, sum[0], sum[1], sum[2], sum[3], sum[4], sum[5], sum[6], sum[7],
                     sum[8], sum[9], sum[10], sum[11], sum[12], sum[13], sum[14], sum[15],
                     sum[16], sum[17], sum[18], sum[19], sum[20], sum[21], sum[22], sum[23],
                     sum[24], sum[25], sum[26], sum[27], sum[28], sum[29], sum[30], sum[31]);

    wire sum_is_not_zero;
    not (sum_is_not_zero, sum_is_zero);

    and (isNotEqual, op_sub, sum_is_not_zero);

    // isLessThan
    and (isLessThan, op_sub, sum[31]);

endmodule