module wtm_5x5(
    input [4:0] A,        
    input [4:0] B,       
    output [9:0] Product  
);

    wire pp[4:0][4:0];  

    genvar i, j;
    generate
        for (i = 0; i < 5; i = i + 1) begin : gen_pp_i
            for (j = 0; j < 5; j = j + 1) begin : gen_pp_j
                assign pp[i][j] = A[i] & B[j];
            end
        end
    endgenerate

    assign Product[0] = pp[0][0];

    
    wire s1_1, c1_1;
    half_adder ha1_1 (
        .a(pp[0][1]),
        .b(pp[1][0]),
        .sum(Product[1]),
        .cout(c1_1)
    );

    
    wire s2_1, c2_1;
    full_adder fa2_1 (
        .a(pp[0][2]),
        .b(pp[1][1]),
        .cin(pp[2][0]),
        .sum(s2_1),
        .cout(c2_1)
    );

    wire s2_2, c2_2;
    full_adder fa2_2 (
        .a(s2_1),
        .b(c1_1),
        .cin(1'b0),
        .sum(Product[2]),
        .cout(c2_2)
    );

    
    wire s3_1, c3_1;
    full_adder fa3_1 (
        .a(pp[0][3]),
        .b(pp[1][2]),
        .cin(pp[2][1]),
        .sum(s3_1),
        .cout(c3_1)
    );

    wire s3_2, c3_2;
    full_adder fa3_2 (
        .a(pp[3][0]),
        .b(c2_1),
        .cin(c2_2),
        .sum(s3_2),
        .cout(c3_2)
    );

    wire s3_3, c3_3;
    full_adder fa3_3 (
        .a(s3_1),
        .b(s3_2),
        .cin(1'b0),
        .sum(Product[3]),
        .cout(c3_3)
    );

    
    wire s4_1, c4_1;
    full_adder fa4_1 (
        .a(pp[0][4]),
        .b(pp[1][3]),
        .cin(pp[2][2]),
        .sum(s4_1),
        .cout(c4_1)
    );

    wire s4_2, c4_2;
    full_adder fa4_2 (
        .a(pp[3][1]),
        .b(pp[4][0]),
        .cin(c3_1),
        .sum(s4_2),
        .cout(c4_2)
    );

    wire s4_3, c4_3;
    full_adder fa4_3 (
        .a(s4_1),
        .b(s4_2),
        .cin(c3_2),
        .sum(s4_3),
        .cout(c4_3)
    );

    wire s4_4, c4_4;
    full_adder fa4_4 (
        .a(s4_3),
        .b(c3_3),
        .cin(1'b0),
        .sum(Product[4]),
        .cout(c4_4)
    );

    
    wire s5_1, c5_1;
    full_adder fa5_1 (
        .a(pp[1][4]),
        .b(pp[2][3]),
        .cin(pp[3][2]),
        .sum(s5_1),
        .cout(c5_1)
    );

    wire s5_2, c5_2;
    full_adder fa5_2 (
        .a(pp[4][1]),
        .b(c4_1),
        .cin(c4_2),
        .sum(s5_2),
        .cout(c5_2)
    );

    wire s5_3, c5_3;
    full_adder fa5_3 (
        .a(s5_1),
        .b(s5_2),
        .cin(c4_3),
        .sum(s5_3),
        .cout(c5_3)
    );

    wire s5_4, c5_4;
    full_adder fa5_4 (
        .a(s5_3),
        .b(c4_4),
        .cin(1'b0),
        .sum(Product[5]),
        .cout(c5_4)
    );

    
    wire s6_1, c6_1;
    full_adder fa6_1 (
        .a(pp[2][4]),
        .b(pp[3][3]),
        .cin(pp[4][2]),
        .sum(s6_1),
        .cout(c6_1)
    );

    wire s6_2, c6_2;
    full_adder fa6_2 (
        .a(c5_1),
        .b(c5_2),
        .cin(c5_3),
        .sum(s6_2),
        .cout(c6_2)
    );

    wire s6_3, c6_3;
    full_adder fa6_3 (
        .a(s6_1),
        .b(s6_2),
        .cin(c5_4),
        .sum(Product[6]),
        .cout(c6_3)
    );

    
    wire s7_1, c7_1;
    full_adder fa7_1 (
        .a(pp[3][4]),
        .b(pp[4][3]),
        .cin(c6_1),
        .sum(s7_1),
        .cout(c7_1)
    );

    wire s7_2, c7_2;
    full_adder fa7_2 (
        .a(s7_1),
        .b(c6_2),
        .cin(c6_3),
        .sum(Product[7]),
        .cout(c7_2)
    );

    
    wire s8_1, c8_1;
    full_adder fa8_1 (
        .a(pp[4][4]),
        .b(c7_1),
        .cin(c7_2),
        .sum(Product[8]),
        .cout(c8_1)
    );

    
    assign Product[9] = c8_1;

endmodule


module full_adder(
    input a,      
    input b,      
    input cin,    
    output sum,   
    output cout   
);
    assign sum = a ^ b ^ cin;                          
    assign cout = (a & b) | (b & cin) | (a & cin);     
endmodule

module half_adder(
    input a,      
    input b,      
    output sum,   
    output cout   
);
    assign sum = a ^ b;    
    assign cout = a & b;  
endmodule