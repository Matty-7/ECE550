module regfile_decoder(
    output reg [31:0] out,
    input [4:0] sel
);

    always @(*) begin
        out = 32'b0;  // Initialize the output to zero
        case (sel)
            5'b00000: out[0] = 1'b1;
            5'b00001: out[1] = 1'b1;
            5'b00010: out[2] = 1'b1;
            5'b00011: out[3] = 1'b1;
            5'b00100: out[4] = 1'b1;
            5'b00101: out[5] = 1'b1;
            5'b00110: out[6] = 1'b1;
            5'b00111: out[7] = 1'b1;
            5'b01000: out[8] = 1'b1;
            5'b01001: out[9] = 1'b1;
            5'b01010: out[10] = 1'b1;
            5'b01011: out[11] = 1'b1;
            5'b01100: out[12] = 1'b1;
            5'b01101: out[13] = 1'b1;
            5'b01110: out[14] = 1'b1;
            5'b01111: out[15] = 1'b1;
            5'b10000: out[16] = 1'b1;
            5'b10001: out[17] = 1'b1;
            5'b10010: out[18] = 1'b1;
            5'b10011: out[19] = 1'b1;
            5'b10100: out[20] = 1'b1;
            5'b10101: out[21] = 1'b1;
            5'b10110: out[22] = 1'b1;
            5'b10111: out[23] = 1'b1;
            5'b11000: out[24] = 1'b1;
            5'b11001: out[25] = 1'b1;
            5'b11010: out[26] = 1'b1;
            5'b11011: out[27] = 1'b1;
            5'b11100: out[28] = 1'b1;
            5'b11101: out[29] = 1'b1;
            5'b11110: out[30] = 1'b1;
            5'b11111: out[31] = 1'b1;
        endcase
    end

endmodule