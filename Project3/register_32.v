module register_32(
    output [31:0] q,
    input [31:0] d,
    input clk, en, clr
);

    genvar i;
    generate
        for(i = 0; i < 32; i = i + 1) begin : gen_dffe
            dffe_ref dffe_inst(
                .q(q[i]),
                .d(d[i]),
                .clk(clk),
                .en(en),
                .clr(clr)
            );
        end
    endgenerate
endmodule