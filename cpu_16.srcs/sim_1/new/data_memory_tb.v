`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/21/2026 12:47:50 AM
// Design Name: 
// Module Name: data_memory_tb
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


module data_memory_tb;
    reg clk;
    reg memread;
    reg memwrite;
    reg [15:0] address;
    reg [15:0] write_data;
    wire [15:0] read_data;
    data_memory data_memory_dut(.clk(clk),
    .memread(memread),.memwrite(memwrite),
    .address(address),.read_data(read_data),
    .write_data(write_data));
    initial begin
        clk=0;
        forever #5 clk=~clk;
    end
    task write_mem;
        input [15:0] addr;
        input [15:0] data;
        begin
            @( negedge clk);
            memwrite=1;
            address=addr;
            write_data = data; 
            @(posedge clk);
            #1;
            memwrite=0;
            
            $display("WRITE : MEM[%0d] = %0d", addr, data);
        end
    endtask
    task check_mem;
        input [15:0] addr;
        input [15:0] expected;
        begin   
            memread=1;
            address=addr;
            #1;
            if (read_data==expected)
                $display("PASS : MEM[%0d] = %0d", addr, read_data);
            else
                $display("FAIL : MEM[%0d] Expected = %0d Got = %0d",addr,expected,read_data);
            memread=0;
        end
    endtask
    initial begin
        memread=0;
        memwrite=0;
        address=0;
        write_data=0;
        #2;
        write_mem(10,25);
        check_mem(10,25);
        
        write_mem(50,100);
        check_mem(50,100);
        
        write_mem(10,500);
        check_mem(10,500);
        
        check_mem(99,0);
        
        memwrite = 0;
        address = 20;
        write_data = 1234;
        @(posedge clk);

        check_mem(20,0);
        
        memread = 0;
        address = 10;

        #1;
        
        if(read_data == 16'd0)
            $display("PASS : Read disabled");
        else
            $display("FAIL : Read disable test");
        $finish;
    end
endmodule
