`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/21/2026 10:51:30 PM
// Design Name: 
// Module Name: cpu_tb
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


module cpu_tb;
    reg clk;
    reg reset;
    cpu cpu_dut(.clk(clk),.reset(reset));
    initial begin
        clk=0;
        forever #5 clk=~clk;
    end
    initial begin
        reset=1;
        #10;
        reset=0;
        repeat(15)
            @(posedge clk);
        $finish;
    end
    always @(posedge clk) begin
        $display("time=%0t",$time);
        $display("pc=%0d",cpu_dut.pc_out);
        $display("instruction=%h",cpu_dut.instruction);
        $display("opcode=%0d",cpu_dut.opcode);
        $display("ALU result=%0d",cpu_dut.y);
        $display("writeback=%0d",cpu_dut.write_back_data);
        $display("RD  = %0d", cpu_dut.rd);
        $display("RS1 = %0d", cpu_dut.rs1);
        $display("RS2 = %0d", cpu_dut.rs2);
        $display("IMM = %0d", cpu_dut.imm);
        #1;
        $display("R0=%0d R1=%0d R2=%0d R3=%0d",
        cpu_dut.register_file_inst.registers[0],
        cpu_dut.register_file_inst.registers[1],
        cpu_dut.register_file_inst.registers[2],
        cpu_dut.register_file_inst.registers[3]);
        $display("R4=%0d R5=%0d R6=%0d R7=%0d",
        cpu_dut.register_file_inst.registers[4],
        cpu_dut.register_file_inst.registers[5],
        cpu_dut.register_file_inst.registers[6],
        cpu_dut.register_file_inst.registers[7]);
    end
endmodule
