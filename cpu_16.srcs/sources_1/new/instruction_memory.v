`timescale 1ns / 1ps
module instruction_memory(
    output [31:0] instruction,
    input [15:0] address);
    reg [31:0] memory [255:0];
    assign instruction=memory[address];
    initial begin
        $readmemh("program.mem",memory);
    end
endmodule