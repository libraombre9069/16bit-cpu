`timescale 1ns/1ps
module cpu(input clk,input reset);
    //pc
    wire [15:0] pc_out;
    //instruction memory
    wire [31:0] instruction;
    //decoder
    wire [3:0] opcode;
    wire [3:0] rd;
    wire [3:0] rs1;
    wire [3:0] rs2;
    wire [15:0] imm;
    //countrol unit
    wire regwrite;
    wire memread;
    wire memwrite;
    wire branch;
    wire jump;
    wire ALUsrc;
    wire memtoreg;
    wire halt;
    wire branch_ne;
    wire [3:0] ALUop;
    //register file
    wire [15:0] read_data1;
    wire [15:0] read_data2;
    //alu mux
    wire [15:0] alu_in2;
    //alu
    wire [15:0] y;
    wire zero;
    wire carry;
    wire overflow;
    wire negative;
    //data memory
    wire [15:0] mem_data;
    //writeback mux
    wire [15:0] write_back_data;
    //done with all wires
    //INSTANTIATION
    //instantiating pc 
    pc pc_inst(.clk(clk),.reset(reset),.pc(pc_out),.halt(halt),
    .jump(jump),.branch(branch),
    .branch_ne(branch_ne),.zero(zero),
    .target_addr(imm));
    //inst instruction_memory
    instruction_memory imem(.address(pc_out),
    .instruction(instruction));
    //instantiating decoder
    decoder decoder_inst(.instruction(instruction),
    .opcode(opcode),.rd(rd),.rs1(rs1),.rs2(rs2),.imm(imm));
    //instantiating control_unit
    control_unit control_unit_inst(.opcode(opcode),.regwrite(regwrite),
    .memread(memread),.memwrite(memwrite),.ALUsrc(ALUsrc),
    .memtoreg(memtoreg),.halt(halt),.branch_ne(branch_ne),.branch(branch),.jump(jump),.ALUop(ALUop));
    //instantiating register_file 
    register_file register_file_inst(.clk(clk),.wr_en(regwrite),
    .read_add1(rs1),.read_add2(rs2),.write_add(rd),
    .write_data(write_back_data),.read_data1(read_data1),
    .read_data2(read_data2));
    //instantiating alu_mux
    alu_mux alu_muxinst(.ALUsrc(ALUsrc),.read_data2(read_data2),
    .imm(imm),.alu_in2(alu_in2));
    //instantiating alu
    alu alu_inst(.a(read_data1),.b(alu_in2),.alu_sel(ALUop),.y(y),
    .zero(zero),.carry(carry),.overflow(overflow),.negative(negative));
    //instantiating data_memory
    data_memory data_memory_inst(.clk(clk),.memread(memread),
    .memwrite(memwrite),.address(y),.write_data(read_data2),
    .read_data(mem_data));
    //instantiating writeback_mux
    writeback_mux writeback_mux_inst(.memtoreg(memtoreg),.alu_result(y),
    .mem_data(mem_data),.write_data(write_back_data));
endmodule
    
    
    
    