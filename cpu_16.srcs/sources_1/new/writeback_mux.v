`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/21/2026 02:29:48 PM
// Design Name: 
// Module Name: writeback_mux
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


module writeback_mux(
    input memtoreg,
    input [15:0] alu_result,
    input [15:0] mem_data,
    output [15:0] write_data
);

assign write_data = (memtoreg) ? mem_data : alu_result;

endmodule
