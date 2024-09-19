`timescale 1 ns / 100 ps

module mod5_counter_tb();
	reg w;
	reg clock;
	reg reset;
	reg [2:0] state;
	reg [2:0] next_state;
	wire [2:0] STATE;
	wire count;
	
	mod5_counter test_counter(clock, reset, w, STATE, count);
	
	initial begin
		$display($time, "simulation start");
		clock = 1'b0;
		reset = 1'b1;
		w = 1'b0;
		state = 3'b000;
		next_state = 3'b000;
		
		#10 reset = 1'b0;
		
		 @(negedge clock);
        w = 1'b0;
        state = STATE; 
        next_state = test_counter.next_state; 
        @(negedge clock);
        w = 1'b1;
        state = STATE;
        next_state = test_counter.next_state;
        @(negedge clock);
        w = 1'b1;
        state = STATE;
        next_state = test_counter.next_state;
        @(negedge clock);
        w = 1'b1;
        state = STATE;
        next_state = test_counter.next_state;
        @(negedge clock);
        w = 1'b1;
        state = STATE;
        next_state = test_counter.next_state;
        @(negedge clock);
        w = 1'b1;
        state = STATE;
        next_state = test_counter.next_state;
        @(negedge clock);
        w = 1'b1;
        state = STATE;
        next_state = test_counter.next_state;
        @(negedge clock);
        w = 1'b1;
        state = STATE;
        next_state = test_counter.next_state;
        @(negedge clock);
        w = 1'b1;
        state = STATE;
        next_state = test_counter.next_state;
        @(negedge clock);
        w = 1'b1;
        state = STATE;
        next_state = test_counter.next_state;
        @(negedge clock);
        w = 1'b1;
        state = STATE;
        next_state = test_counter.next_state;
        #100 w = 1'b0;
        #40 w = 1'b1;
        @(negedge clock);
        state = STATE;
        next_state = test_counter.next_state;
        $stop;
	end
	
	always #10 clock = ~clock;
	
endmodule