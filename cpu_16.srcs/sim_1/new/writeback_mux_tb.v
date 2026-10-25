`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/21/2026 02:30:18 PM
// Design Name: 
// Module Name: writeback_mux_tb
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


module writeback_mux_tb;
    wire [15:0] write_data; 
    reg memtoreg;
    reg [15:0] alu_result;
    reg [15:0] mem_data;
    writeback_mux writeback_mux_dut(.write_data(write_data),
    .memtoreg(memtoreg),.alu_result(alu_result),
    .mem_data(mem_data));
    task check_writeback;
        input sel;
        input [15:0] alures;
        input [15:0] memdat;
        input [15:0] expected;
        begin
            alu_result=alures;
            mem_data=memdat;
            memtoreg=sel;
            #1;
            if (expected==write_data)
                $display("PASS: memtoreg=%0d got=%0d",memtoreg,expected);
            else
                $display("FAIL: memtoreg=%0d got= %0d expected=%0d",memtoreg,write_data,expected);
        end
    endtask
    initial begin
        memtoreg=0;
        alu_result=16'd0;
        mem_data=16'd0;
        check_writeback(0, 16'd50, 16'd100, 16'd50);
        check_writeback(1, 16'd50, 16'd100, 16'd100);
        check_writeback(0, 16'd500, 16'd25, 16'd500);
        check_writeback(1, 16'd500, 16'd25, 16'd25);
        $finish;
    end
endmodule
