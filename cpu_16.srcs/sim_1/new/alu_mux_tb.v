`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/21/2026 01:38:16 PM
// Design Name: 
// Module Name: alu_mux_tb
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


module alu_mux_tb;
    wire [15:0] alu_in2;
    reg ALUsrc;
    reg [15:0] read_data2;
    reg [15:0] imm;
    alu_mux alu_mux_dut(.ALUsrc(ALUsrc),.alu_in2(alu_in2),
    .read_data2(read_data2),.imm(imm));
    task alu_mux_check;
        input sel;
        input [15:0] read_dat;
        input [15:0] imm_dat;
        input [15:0] expected;
        begin   
            read_data2=read_dat;
            imm=imm_dat;
            ALUsrc=sel;
            #1;
            if (expected==alu_in2)
                $display("PASS: ALUsrc=%0d Got=%0d",ALUsrc,alu_in2);
            else
                $display("FAIL: ALUsrc=%0d Got=%0d Expected=%0d",ALUsrc,alu_in2,expected);
       end
   endtask
   initial begin
    ALUsrc=0;
    read_data2=0;
    imm=0;
    alu_mux_check(0,16'd100,16'd98,16'd100);
    alu_mux_check(1,16'd100,16'd98,16'd98);
    alu_mux_check(0,16'd300,16'd78,16'd300);
    alu_mux_check(1,16'd300,16'd78,16'd78);
    $finish;
   end
endmodule
