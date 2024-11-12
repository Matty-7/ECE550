`timescale 1ns/1ps
`define CLK_PERIOD 20

module Processor_tb;
    reg clock, reset;
    wire imem_clock, dmem_clock, processor_clock, regfile_clock;

    // Design under test (DUT)
    skeleton dut(
        .clock(clock), 
        .reset(reset), 
        .imem_clock(imem_clock), 
        .dmem_clock(dmem_clock), 
        .processor_clock(processor_clock), 
        .regfile_clock(regfile_clock)
    );

    // Clock generation
    always begin
        #(`CLK_PERIOD / 2) clock = ~clock;
    end

    // Initial block to control reset and simulate test
    initial begin
        // Initialize clock and reset
        clock = 0;
        reset = 1;   // Assert reset at the beginning
        #100;        // Hold reset for 5 cycles
        reset = 0;   // Deassert reset

        // Let the processor run and print signals during key cycles
        monitor_signals();

        // Wait for some cycles to ensure instructions run correctly
        #5000;   // 100 full cycles

        $stop;   // Stop the simulation
    end

    // Task to monitor key signals during simulation
    task monitor_signals;
        integer i;
        begin
            // Print header for easier reading
            $display("Time\tPC\tInstruction\tR1\tR2\tR3\tR4\tR5\tR6\tR7\tR8\tR9\tMem[1]\tMem[2]");
            
            // Use $monitor to track the values of the internal registers and memory
            $monitor("%0d\t%h\t%h\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d",
                $time, 
                dut.my_processor.pc,         // PC value
                dut.q_imem,                  // Current instruction
                dut.my_regfile.registers[1], // R1
                dut.my_regfile.registers[2], // R2
                dut.my_regfile.registers[3], // R3
                dut.my_regfile.registers[4], // R4
                dut.my_regfile.registers[5], // R5
                dut.my_regfile.registers[6], // R6
                dut.my_regfile.registers[7], // R7
                dut.my_regfile.registers[8], // R8
                dut.my_regfile.registers[9], // R9
                dut.my_dmem.q[1],            // Memory location 1
                dut.my_dmem.q[2]             // Memory location 2
            );
        end
    endtask
endmodule
