module fa (
 input a,
 input b,
 input cin,
 output sum,
 output cout
);
 wire xor1;
 assign xor1 = a ^ b;
 assign sum = xor1 ^ cin;

 wire and1, and2;
 assign and1 = xor1 & cin;
 assign and2 = a & b;
 assign cout = and1 | and2;
 
endmodule