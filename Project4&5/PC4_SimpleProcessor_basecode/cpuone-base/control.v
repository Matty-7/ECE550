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