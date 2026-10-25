`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/05/2026 11:56:04 PM
// Design Name: 
// Module Name: alu
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

module alu(
input [15:0] a,
input [15:0] b,
input [3:0] alu_sel,
output reg [15:0] y,
output reg zero,
output reg carry,
output reg overflow,
output reg negative
);
reg [16:0] temp;
always @(*) begin
    zero=0;
    carry=0;
    overflow=0;
    negative=0;
    y=16'b0;
    temp=17'b0;
    case(alu_sel)
        4'd0: begin
            temp=a+b;
            y=temp[15:0];
            carry=temp[16];
            overflow=(a[15]==b[15])&&(y[15]!=a[15]);
            end
        4'd1: begin
            temp=a-b;
            y=temp[15:0];
            carry=temp[16];
            overflow=(a[15]!=b[15])&&(y[15]!=a[15]);
            end
        4'd2: y=a&b;
        4'd3: y=a|b;
        4'd4: y=a^b;
        4'd5: y=~a;
        4'd6: y=a+1;
        4'd7: y=a-1;
        4'd8: y=a<<b[3:0];
        4'd9: y=a>>b[3:0];
        4'd10: begin
            y=(a==b)?16'b1:16'b0;
            end
        4'd11: y=a;
        4'd12: y=b;
        default: y=16'b0;
    endcase
    if (y==16'b0)
        zero=1; 
    negative=y[15];
    end
endmodule
