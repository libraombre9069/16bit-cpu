`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/18/2026 06:49:36 PM
// Design Name: 
// Module Name: decoder_tb
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
module decoder_tb;
    reg [31:0] instruction;
    wire [3:0] opcode;
    wire [3:0] rd;
    wire [3:0] rs1;
    wire [3:0] rs2;
    wire [15:0] imm;
    decoder decoder_dut(.instruction(instruction),
    .opcode(opcode),.rd(rd),.rs1(rs1),.rs2(rs2),.imm(imm));
    task check_decoder;
        input [31:0] inst;
        begin
            instruction=inst;
            #1;
            $display("instruction=%h",instruction);
            $display("opcode=%h",opcode);
            $display("rd=%0d",rd);
            $display("rs1=%0d",rs1);
            $display("rs2=%0d",rs2);
            $display("imm=%0d",imm);
        end
    endtask
    initial begin
        check_decoder(32'h71000005); 
        check_decoder(32'h7200000A);
        check_decoder(32'h13120000); 
        check_decoder(32'h24310000); 
        check_decoder(32'hF0000000);  
        $display("\nDecoder Test Complete");
        $finish;
    end    
endmodule
