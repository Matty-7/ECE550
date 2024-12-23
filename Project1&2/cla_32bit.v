module cla_32bit(
    input [31:0] a,
    input [31:0] b,
    input cin,
    output [31:0] sum,
    output cout
);
    wire [7:0] carry;

    cla_4bit cla0(
        .a(a[3:0]),
        .b(b[3:0]),
        .cin(cin),
        .sum(sum[3:0]),
        .cout(carry[0])
    );

    cla_4bit cla1(
        .a(a[7:4]),
        .b(b[7:4]),
        .cin(carry[0]),
        .sum(sum[7:4]),
        .cout(carry[1])
    );

    cla_4bit cla2(
        .a(a[11:8]),
        .b(b[11:8]),
        .cin(carry[1]),
        .sum(sum[11:8]),
        .cout(carry[2])
    );

    cla_4bit cla3(
        .a(a[15:12]),
        .b(b[15:12]),
        .cin(carry[2]),
        .sum(sum[15:12]),
        .cout(carry[3])
    );

    cla_4bit cla4(
        .a(a[19:16]),
        .b(b[19:16]),
        .cin(carry[3]),
        .sum(sum[19:16]),
        .cout(carry[4])
    );

    cla_4bit cla5(
        .a(a[23:20]),
        .b(b[23:20]),
        .cin(carry[4]),
        .sum(sum[23:20]),
        .cout(carry[5])
    );

    cla_4bit cla6(
        .a(a[27:24]),
        .b(b[27:24]),
        .cin(carry[5]),
        .sum(sum[27:24]),
        .cout(carry[6])
    );

    cla_4bit cla7(
        .a(a[31:28]),
        .b(b[31:28]),
        .cin(carry[6]),
        .sum(sum[31:28]),
        .cout(carry[7])
    );

    assign cout = carry[7];
endmodule