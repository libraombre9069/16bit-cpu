`timescale 1ns/ 1ps
module control_unit(input [3:0] opcode,
    output reg regwrite,
    output reg memread,
    output reg memwrite,
    output reg ALUsrc,
    output reg memtoreg,
    output reg branch,
    output reg jump,
    output reg [3:0] ALUop,
    output reg halt,
    output reg branch_ne);
    always @(*) begin
        regwrite=0;
        memread=0;
        memwrite=0;
        ALUsrc=0;
        memtoreg=0;
        branch=0;
        jump=0;
        halt=0;
        branch_ne=0;
        ALUop=4'd0;
        case(opcode)
            4'd0: begin
            end
            4'd1: begin
                regwrite=1;
                ALUop=4'd0;
                end
            4'd2: begin
                regwrite=1;
                ALUop=4'd1;
                end
            4'd3: begin
                regwrite=1;
                ALUop=4'd2;
                end
            4'd4: begin
                regwrite=1;
                ALUop=4'd3;
                end
            4'd5: begin
                regwrite=1;
                ALUop=4'd4;
                end
            4'd6: begin
                regwrite=1;
                ALUop=4'd5;
                end
            4'd7: begin
                regwrite=1;
                ALUsrc=1;
                ALUop=4'd0;
                end
            4'd8: begin 
                regwrite=1;
                memread=1;
                memtoreg=1;
                ALUsrc=1;
                ALUop=4'd0;
                end
            4'd9: begin
                memwrite=1;
                ALUsrc=1;
                ALUop=4'd0;
                end
            4'd10: begin
                branch=1;
                ALUsrc=0;
                ALUop=4'd1;
                end
            4'd11: begin
                regwrite=0;
                branch_ne=1;
                ALUsrc=0;
                ALUop=4'd1;
                end
            4'd12: begin
                jump=1;
                end
            4'd13: begin
                regwrite=1;
                ALUsrc=1;
                ALUop=4'd8;
                end
            4'd14: begin
                regwrite=1;
                ALUsrc=1;
                ALUop=4'd9;
                end
            4'd15: begin
                halt=1;
                end    
            default: begin
                end
        endcase
    end
endmodule