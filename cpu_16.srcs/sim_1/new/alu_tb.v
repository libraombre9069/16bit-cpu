`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/05/2026 11:37:09 PM
// Design Name: 
// Module Name: alu_tb
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


module alu_tb;
    reg [15:0] a;
    reg [15:0] b;
    reg [3:0] alu_sel;
    wire [15:0] y;
    wire zero;
    wire carry;
    wire overflow;
    wire negative;
    alu dut(.a(a),.b(b),.y(y),.alu_sel(alu_sel),.zero(zero),.carry(carry),
    .overflow(overflow),.negative(negative));
    task test;
        input [15:0] w;
        input [15:0] z;
        input [3:0] sel;
        input [15:0] expected;
        begin
            a=w;
            b=z;
            alu_sel=sel;
            #10;
            if (y ==expected)
                $display("PASS");
            else
                $display("FAIL");
            $display("x=%h  z=%h  sel=%d", a, b, alu_sel);
            $display("y=%h expected=%h Z=%b  C=%b  V=%b  N=%b",
                      y, expected, zero, carry, overflow, negative);
        end
    endtask
    initial begin
        test(16'd5,16'd3,4'd0,16'd8);
        test(16'h7FFF,16'h0001,4'd0,16'h8000);
        test(16'd15,16'd7,4'd1,16'd8);
        test(16'd10,16'd10,4'd1,16'd0);
        test(16'd5,16'd10,4'd1,16'hFFFB);
        test(16'hAAAA,16'h5555,4'd2,16'h0000);
        test(16'hAAAA,16'h5555,4'd3,16'hFFFF);
        test(16'hAAAA,16'hFFFF,4'd4,16'h5555);
        test(16'hAAAA,16'h0000,4'd5,16'h5555);
        test(16'd10,16'd0,4'd6,16'd11);
        test(16'd10,16'd0,4'd7,16'd9);
        test(16'h0001,16'd4,4'd8,16'h0010);
        test(16'h8000,16'd1,4'd9,16'h4000);
        test(16'd10,16'd10,4'd10,16'd1);
        test(16'd10,16'd5,4'd10,16'd0);
        test(16'h1234,16'h5678,4'd11,16'h1234);
        test(16'h1234,16'h5678,4'd12,16'h5678);
        $display("\n========== ALL TESTS COMPLETED ==========\n");
        $finish;
end
endmodule
