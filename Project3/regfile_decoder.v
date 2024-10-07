module regfile_decoder(
    output [31:0] out,
    input [4:0] sel
);

    wire n0, n1, n2, n3, n4;  

    
    not (n0, sel[0]);
    not (n1, sel[1]);
    not (n2, sel[2]);
    not (n3, sel[3]);
    not (n4, sel[4]);

    
    and (out[0], n4, n3, n2, n1, n0); //00000
    and (out[1], n4, n3, n2, n1, sel[0]); //00001
    and (out[2], n4, n3, n2, sel[1], n0); //00010
    and (out[3], n4, n3, n2, sel[1], sel[0]); //00011
    and (out[4], n4, n3, sel[2], n1, n0); //00100
    and (out[5], n4, n3, sel[2], n1, sel[0]); //00101
    and (out[6], n4, n3, sel[2], sel[1], n0); //00110
    and (out[7], n4, n3, sel[2], sel[1], sel[0]); //00111
    and (out[8], n4, sel[3], n2, n1, n0); //01000
    and (out[9], n4, sel[3], n2, n1, sel[0]); //01001
    and (out[10], n4, sel[3], n2, sel[1], n0); //01010
    and (out[11], n4, sel[3], n2, sel[1], sel[0]); //01011
    and (out[12], n4, sel[3], sel[2], n1, n0); //01100
    and (out[13], n4, sel[3], sel[2], n1, sel[0]); //01101
    and (out[14], n4, sel[3], sel[2], sel[1], n0); //01110
    and (out[15], n4, sel[3], sel[2], sel[1], sel[0]); //01111
    and (out[16], sel[4], n3, n2, n1, n0); //10000
    and (out[17], sel[4], n3, n2, n1, sel[0]); //10001
    and (out[18], sel[4], n3, n2, sel[1], n0); //10010
    and (out[19], sel[4], n3, n2, sel[1], sel[0]); //10011
    and (out[20], sel[4], n3, sel[2], n1, n0); //10100
    and (out[21], sel[4], n3, sel[2], n1, sel[0]); //10101
    and (out[22], sel[4], n3, sel[2], sel[1], n0); //10110
    and (out[23], sel[4], n3, sel[2], sel[1], sel[0]); //10111
    and (out[24], sel[4], sel[3], n2, n1, n0); //11000
    and (out[25], sel[4], sel[3], n2, n1, sel[0]); //11001
    and (out[26], sel[4], sel[3], n2, sel[1], n0); //11010
    and (out[27], sel[4], sel[3], n2, sel[1], sel[0]); //11011
    and (out[28], sel[4], sel[3], sel[2], n1, n0); //11100
    and (out[29], sel[4], sel[3], sel[2], n1, sel[0]); //11101
    and (out[30], sel[4], sel[3], sel[2], sel[1], n0); //11110
    and (out[31], sel[4], sel[3], sel[2], sel[1], sel[0]); //11111

endmodule