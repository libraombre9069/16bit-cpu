`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/10/2026 02:21:46 AM
// Design Name: 
// Module Name: register_file_tb
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


module register_file_tb;
    reg clk;
    reg wr_en;
    reg [3:0] read_add1;
    reg [3:0] read_add2;
    reg [3:0] write_add;
    reg [15:0] write_data;
    wire [15:0] read_data1;
    wire [15:0] read_data2;
    register_file register_file_dut(.clk(clk),.wr_en(wr_en),
    .read_add1(read_add1),.read_add2(read_add2),
    .read_data1(read_data1),.read_data2(read_data2),
    .write_add(write_add),.write_data(write_data));
    //clk generation
    initial
    clk=0;
    always #5 clk=~clk;
    //write task
    task write_reg;
        input [3:0] add;
        input [15:0] data;
        begin
            wr_en=1;
            write_add=add;
            write_data=data;
            @(posedge clk);
            #1;
            wr_en=0;
            $display("WRITE : R%0d=%0d",add,data);
        end
    endtask
    //read and check task
    task check_reg;
    input [3:0] add;
    input [15:0] expected;
    begin 
        read_add1=add;
        #1;
        if (read_data1==expected)
            $display("PASS : R%0d=%0d",add,read_data1);
        else
            $display("FAIL : R%0d Expected=%0d Got=%0d",add,expected,read_data1);
        end
   endtask
   //dual read task
   task dual_read;
   input [3:0] add1;
   input [3:0] add2;
   begin
        read_add1=add1;
        read_add2=add2;
        #1;
        $display("dual read");
        $display("R%0d=%0d",add1,read_data1);
        $display("R%0d=%0d",add2,read_data2);
   end
   endtask
   //test seq
   initial begin
        wr_en=0;
        read_add1=0;
        read_add2=0;
        write_add=0;
        write_data=0;
        #2;
        //test1
        write_reg(4'd5,16'd25);
        check_reg(4'd5,16'd25);
        //test2
        write_reg(4'd10,16'd100);
        check_reg(4'd10,16'd100);
        //test3
        check_reg(4'd5,16'd25);
        //test4
        dual_read(4'd5,16'd10);
        //test5
        write_reg(4'd5,16'd500);
        check_reg(4'd5,16'd500);
        //test6
        check_reg(4'd15,16'd0);
        $display("ALL TESTS COMPLETED\n");
        $finish;
    end
endmodule
