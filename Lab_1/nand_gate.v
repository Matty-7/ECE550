module nand_gate(a, b, f);

		input a, b;
		output f;
		
		nand first_nand(f, a, b);
		
endmodule