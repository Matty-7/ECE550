`timescale 1ns/1ps

module wtm_5x5_tb;

    reg [4:0] A;
    reg [4:0] B;
	 reg [9:0] expected_product;
    wire [9:0] Product;

    wtm_5x5 uut (
        .A(A),
        .B(B),
        .Product(Product)
    );

    initial begin
    
    A = 5'b00000; // A = 0
    B = 5'b00000; // B = 0
	 expected_product = A * B;
    #10;
    $display("Test 1: A = %b, B = %b, Product = %b (Expected: %b)", A, B, Product, expected_product);

    
    A = 5'b01111; // A = 15
    B = 5'b00011; // B = 3
	 expected_product = A * B;
    #10;
    $display("Test 2: A = %b, B = %b, Product = %b (Expected: %b)", A, B, Product, expected_product);
	 
    
    A = 5'b11001; // A = 25
    B = 5'b10001; // B = 17
	 expected_product = A * B;
    #10;
    $display("Test 3: A = %b, B = %b, Product = %b (Expected: %b)", A, B, Product, expected_product);

    
    A = 5'b11111; // A = 31
    B = 5'b11111; // B = 31
	 expected_product = A * B;
    #10;
    $display("Test 4: A = %b, B = %b, Product = %b (Expected: %b)", A, B, Product, expected_product);

    
    A = 5'b01010; // A = 10
    B = 5'b10100; // B = 20
	 expected_product = A * B;
    #10;
    $display("Test 5: A = %b, B = %b, Product = %b (Expected: %b)", A, B, Product, expected_product);

    
    #10;
    $stop;
end

endmodule