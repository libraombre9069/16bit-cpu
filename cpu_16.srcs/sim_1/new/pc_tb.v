`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/10/2026 11:48:11 PM
// Design Name: 
// Module Name: pc_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module pc_tb;
    reg clk;
    reg reset;
    wire [15:0] pc;
    pc pc_dut(.clk(clk),.reset(reset),.pc(pc));
    initial
        clk=0;
    always #5 clk=~clk;
    initial begin
        reset=1;
        @(posedge clk);
        #1;
        $display("Reset ON  -> PC = %0d", pc);
        reset=0;
        repeat(5) begin
            @(posedge clk);
            #1;
            $display("pc=%0d",pc);
        end
        reset=1;
        @(posedge clk);
        #1;
        $display("Reset Again -> PC = %0d", pc);
        $display("PC TEST COMPLETE");
        $finish;
   end  
endmodule
