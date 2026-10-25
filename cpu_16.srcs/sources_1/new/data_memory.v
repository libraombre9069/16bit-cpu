`timescale 1ns/1ps
module data_memory(
    input clk,
    input memread,
    input memwrite,
    input [15:0] address,
    input [15:0] write_data,
    output reg [15:0] read_data  
);
    reg [15:0] memory [0:255];
    integer i;
    initial begin   
        for (i=0;i<256;i=i+1)
            memory[i]=16'd0;
        memory[20]=16'd123;
        memory[30]=16'd456;
        memory[40]=16'd999;
    end
    always @(*) begin
        if (memread) begin
            read_data=memory[address[7:0]];
        end
        else
            read_data=16'd0;
    end
    always @(posedge clk) begin
        if (memwrite) begin
            memory[address[7:0]]<=write_data;
        end
    end    
endmodule