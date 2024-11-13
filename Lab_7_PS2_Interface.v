module PS2_Interface(
    input inclock, resetn,
    inout ps2_clock, ps2_data,
    output ps2_key_pressed,
    output [7:0] ps2_key_data,
    output [7:0] last_data_received,
);
    // Internal Registers
    reg [7:0] ascii_data; // Internal register to store the mapped ASCII value

    // Mapping PS2 scan codes to ASCII values
    always @(*) begin
        case (ps2_key_data)
            8'h15: ascii_data = 8'd81;  // 'Q'
            8'h1C: ascii_data = 8'd65;  // 'A'
            8'h32: ascii_data = 8'd66;  // 'B'
            8'h21: ascii_data = 8'd67;  // 'C'
            default: ascii_data = 8'd32; // Space character for unmapped keys
        endcase
    end

    // ASCII Mapping Logic: Add a small combinational logic block
    always @(posedge inclock) begin
        if (resetn == 1'b0)
            last_data_received <= 8'h00;
        else if (ps2_key_pressed == 1'b1)
            last_data_received <= ascii_data;
    end


    PS2_Controller PS2 (
        .CLOCK_50 (inclock),
        .reset (~resetn),
        .PS2_CLK (ps2_clock),
        .PS2_DAT (ps2_data),
        .received_data (ps2_key_data),
        .received_data_en (ps2_key_pressed)
    );

endmodule
