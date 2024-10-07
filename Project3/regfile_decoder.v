module regfile_decoder(
    output [31:0] out,
    input [4:0] sel
);

    genvar i;
    generate
        for(i = 0; i < 32; i = i + 1) begin : decoder_block
            assign out[i] = (sel == i) ? 1'b1 : 1'b0;
        end
    endgenerate

endmodule