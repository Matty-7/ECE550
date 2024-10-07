module regfile (
    input clock,
    input ctrl_writeEnable, ctrl_reset, 
	 input [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB, 
	 input [31:0] data_writeReg,
    output [31:0] data_readRegA, data_readRegB
);

    /* YOUR CODE HERE */
    
    wire [31:0] write_decode, read_decodeA, read_decodeB;

    
    wire [31:0] registers [31:0];

    
    regfile_decoder write_decoder(write_decode, ctrl_writeReg);
    regfile_decoder read_decoderA(read_decodeA, ctrl_readRegA);
    regfile_decoder read_decoderB(read_decodeB, ctrl_readRegB);

    
    genvar i;
    generate
        for(i = 0; i < 32; i = i + 1) begin : reg_block
            if(i == 0) begin
                
                assign registers[i] = 32'b0;
            end else begin
                
                register_32 reg_inst(
                    .q(registers[i]),
                    .d(data_writeReg),
                    .clk(clock),
                    .en(write_decode[i] & ctrl_writeEnable),
                    .clr(ctrl_reset)
                );
            end
        end
    endgenerate

    
    regfile_tristate read_buf_A(
        .data_out(data_readRegA),
        .data_in(registers[ctrl_readRegA]),
        .enable(read_decodeA[ctrl_readRegA])
    );

    
    regfile_tristate read_buf_B(
        .data_out(data_readRegB),
        .data_in(registers[ctrl_readRegB]),
        .enable(read_decodeB[ctrl_readRegB])
    );

endmodule
