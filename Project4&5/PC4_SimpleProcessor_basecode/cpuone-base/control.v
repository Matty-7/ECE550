module control(opcode, Rwe, Rdst, ALUinB, ALUop_ctl, DMWe, Rwd, JP, BR, is_R, is_addi, is_sw, is_lw);
    input [4:0] opcode;
    output Rwe, Rdst, ALUinB, ALUop_ctl, DMWe, Rwd, JP, BR, is_R, is_addi, is_sw, is_lw;
    
    // R: 00000
    assign is_R = (~opcode[4]) & (~opcode[3]) & (~opcode[2]) & (~opcode[1]) & (~opcode[0]);
    // addi: 00101
    assign is_addi = (~opcode[4]) & (~opcode[3]) & (opcode[2]) & (~opcode[1]) & (opcode[0]);
    // sw: 00111
    assign is_sw = (~opcode[4]) & (~opcode[3]) & (opcode[2]) & (opcode[1]) & (opcode[0]);
    // lw: 01000
    assign is_lw = (~opcode[4]) & (opcode[3]) & (~opcode[2]) & (~opcode[1]) & (~opcode[0]);

    assign ALUinB = is_addi | is_lw | is_sw;
    assign DMWe = is_sw;
    assign Rwe = is_R | is_addi | is_lw; 
    assign Rdst = is_R ;
    assign Rwd = is_lw;
    // not required for this checkpoint
    assign JP = 1'b0;
    assign BR = 1'b0;
    assign ALUop_ctl = 1'b0;

endmodule

module control(opcode, Rwe, Rdst, ALUinB, ALUop_ctl, DMWe, Rwd, JP, BR, is_R, is_addi, is_sw, is_lw, is_j, is_jal, is_jr, is_bex, is_setx);
    input [4:0] opcode;
    output Rwe, Rdst, ALUinB, ALUop_ctl, DMWe, Rwd, JP, BR, is_R, is_addi, is_sw, is_lw, is_j, is_jal, is_jr, is_bex, is_setx;
    
    // R: 00000
    assign is_R = (~opcode[4]) & (~opcode[3]) & (~opcode[2]) & (~opcode[1]) & (~opcode[0]);
    // addi: 00101
    assign is_addi = (~opcode[4]) & (~opcode[3]) & (opcode[2]) & (~opcode[1]) & (opcode[0]);
    // sw: 00111
    assign is_sw = (~opcode[4]) & (~opcode[3]) & (opcode[2]) & (opcode[1]) & (opcode[0]);
    // lw: 01000
    assign is_lw = (~opcode[4]) & (opcode[3]) & (~opcode[2]) & (~opcode[1]) & (~opcode[0]);

    assign ALUinB = is_addi | is_lw | is_sw;
    assign DMWe = is_sw;
    assign Rwe = is_R | is_addi | is_lw; 
    assign Rdst = is_R ;
    assign Rwd = is_lw;

    // J-type instructions
    // j: 00001
    assign is_j = (opcode == 5'b00001);
    // jal: 00011
    assign is_jal = (opcode == 5'b00011);
    // jr: 00100
    assign is_jr = (opcode == 5'b00100);
    // bex: 10110
    assign is_bex = (opcode == 5'b10110);
    // setx: 10101
    assign is_setx = (opcode == 5'b10101);

    // Control signals for J-type instructions
    assign JP = is_j | is_jal | is_jr | is_bex;
    assign BR = 1'b0; // Branching is not used for J-type instructions
    assign Rwe = is_jal | is_setx; // Write enable for jal and setx
    assign Rdst = is_jal; // Write to $ra for jal
    assign ALUinB = 1'b0; // Not used for J-type
    assign ALUop_ctl = 1'b0; // Not used for J-type
    assign DMWe = 1'b0; // Not used for J-type
    assign Rwd = 1'b0; // Not used for J-type
endmodule
