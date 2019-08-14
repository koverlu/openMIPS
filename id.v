`include "define.v"
module id(
    input wire rst,
    input wire[`INST_ADDR_BUS] pc_i,
    input wire[`INST_BUS] inst_i,
    input wire[`REG_BUS] reg1_data_i,
    input wire[`REG_BUS] reg2_data_i,
    output reg reg1_read_o,                 //Read port1 enable
    output reg reg2_read_o,                 //Read port2 enable
    output reg[`REG_ADDR_BUS] reg1_addr_o,
    output reg[`REG_ADDR_BUS] reg2_addr_o,
    output reg[`ALU_OP_BUS] aluop_o,
    output reg[`ALU_SEL_BUS] alusel_o,
    output reg[`REG_ADDR_BUS] wd_o,
    output reg wreg_o
);

//Get op code, and function code
wire[5:0] op = inst_i[31:26]
wire[4:0] op2 = inst_i[10:6]
wire[5:0] op3 = inst_i[5:0]
wire[4:0] op4 = inst_i[20:16]
//Store the immediate data
reg[`REG_BUS] imm;
//Is valid
reg instvalid;

//|31 ... 26|25 ... 21|20 ... 16|15 ... 11|10 ... 6|5 ... 0|
//|   op    |   rs    |   rt    |   rd    |   sa   | func  |
//|  6 bits |  5 bits | 5 bits  |  5 bits | 5 bits | 5 bits|
    always @(*) begin
        if (rst == `RST_ENABLE) begin
            
        end
    end

endmodule // id