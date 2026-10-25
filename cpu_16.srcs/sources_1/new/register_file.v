`timescale 1ns/ 1ps
module register_file(
input clk, input wr_en, 
input [3:0] read_add1,
input [3:0] read_add2,
input [3:0] write_add,
input [15:0] write_data,
output [15:0] read_data1,
output [15:0] read_data2
);
    reg [15:0] registers [0:15];
    integer i;
    initial begin 
        for (i=0;i<16;i=i+1)
            registers[i]=16'd0;
    end
    assign read_data1=registers[read_add1];
    assign read_data2=registers[read_add2];
    always @(posedge clk) begin
        if (wr_en)
            registers[write_add]<=write_data;
    end
         
endmodule   