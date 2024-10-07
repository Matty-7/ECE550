module regfile_tristate(
    output [31:0] data_out,
    input [31:0] data_in,
    input enable
);

    genvar i;
    generate
        for(i = 0; i < 32; i = i + 1) begin : tri_state_buffer
            assign data_out[i] = enable ? data_in[i] : 1'bz;
        end
    endgenerate
endmodule
