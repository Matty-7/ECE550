module mod5_counter (
	input wire clock,
	input wire reset,
	input wire w,
	output reg [2:0] STATE,
	output reg count
);

	parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100;
	
	reg [2:0] next_state;
	
	always @(posedge clock or posedge reset) begin
		if (reset)
			STATE <= S0;
		else
			STATE <= next_state;
	end
	
	always @(*) begin
		case (STATE)
			S0: next_state = w ? S1 : S0;
			S1: next_state = w ? S2 : S1;
			S2: next_state = w ? S3 : S2;
			S3: next_state = w ? S4 : S3;
			S4: next_state = w ? S0 : S4;
			default: next_state = S0;
		endcase
	end
	
	always @(STATE) begin
		count = (STATE == S4) ? 1'b1 : 1'b0;
	end
	
endmodule