`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/05/2026 11:56:04 PM
// Design Name: 
// Module Name: pc
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


module pc(
input clk, input reset,
output reg [15:0] pc,input halt,input jump,
input branch, input branch_ne, input zero,
input [15:0] target_addr);
    always @(posedge clk) begin
        if (reset)
            pc<=16'd0;
        else if(halt)
            pc<=pc;
        else if (jump)
            pc <= target_addr;
        else if (branch && zero)
            pc <= target_addr;
        else if (branch_ne && !zero)
            pc <= target_addr;
        else
            pc<=pc+16'd1;
    end
endmodule
