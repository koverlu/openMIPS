`include "define.v"
module id(
    input wire rst,
    input wire[`INST_ADDR_BUS] pc_i,
    input wire[`INST_BUS] inst_i,
    //Read data form regfile
    input wire[`REG_BUS] reg1_data_i,
    input wire[`REG_BUS] reg2_data_i,

    //Send read GPR request to regfile
    output reg reg1_read_o,                 //Read port1 enable
    output reg reg2_read_o,                 //Read port2 enable
    output reg[`REG_ADDR_BUS] reg1_addr_o,
    output reg[`REG_ADDR_BUS] reg2_addr_o,

    output reg[`ALU_OP_BUS] aluop_o,        //operation type
    output reg[`ALU_SEL_BUS] alusel_o,      //ALU type(logic)
    output reg[`REG_ADDR_BUS] wd_o,         //Write dst GPR address
    output reg[`REG_BUS] reg1_o,
    output reg[`REG_BUS] reg2_o,
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

//Instruction Decode
//|31 ... 26|25 ... 21|20 ... 16|15 ... 11|10 ... 6|5 ... 0|
//|   op    |   rs    |   rt    |   rd    |   sa   | func  |
//|  6 bits |  5 bits | 5 bits  |  5 bits | 5 bits | 5 bits|
always @(*) begin
    if (rst == `RST_ENABLE) begin
        aluop_o <= `EXE_NOP_OP;
        alusel_o <= `EXE_RES_NOP;
        wd_o <= `NOP_REG_ADDR;
        wreg_o <= `WRITE_DISABLE;
        instvalid <= `INST_VALID;
        reg1_read_o <= 1'b0;
        reg2_read_o <= 1'b0;
        reg1_addr_o <= `NOP_REG_ADDR;
        reg2_addr_o <= `NOP_REG_ADDR;
        imm <= `ZERO_DWORD;
    end else begin
        aluop_o <= `EXE_NOP_OP;
        alusel_o <= `EXE_RES_NOP;
        wd_o <= inst_i[15:11];
        wreg_o <= `WRITE_DISABLE;
        instvalid <= `INST_INVALID;
        reg1_read_o <= 1'b0;
        reg2_read_o <= 1'b0;
        reg1_addr_o <= inst_i[25:21];   //rs
        reg2_addr_o <= inst_i[20:16];   //rt
        imm <= `ZERO_DWORD;

        case(op)
            `EXE_ORI: begin
                //Reg[rt] = Reg[rs] | (uint32)imm
                wreg_o <= `WRITE_ENABLE;
                aluop_o <= `EXE_OR_OP;
                alusel_o <= `EXE_RES_LOGIC;
                reg1_read_o <= 1'b1;
                reg2_read_o <= 1'b0;
                imm <= {16'h0, inst_i[15:0]};
                wd_o <= inst_i[20:16];
                instvalid   <= `INST_VALID;
            end
            default: begin                
            end
        endcase
    end
end

//Output the src1 of the operation
always @(*) begin
    if (rst == `RST_ENABLE) begin
        reg1_o <= `ZERO_DWORD;
    end else if (reg1_read_o == 1'b1) begin
        reg1_o <= reg1_data_i;
    end else begin
        reg1_o <= imm;
    end
end

//Output the src2 of the operation
always @(*) begin
    if (rst == `RST_ENABLE) begin
        reg2_o <= `ZERO_DWORD;
    end else if (reg2_read_o == 1'b1) begin
        reg2_o <= reg2_data_i;
    end else begin
        reg2_o <= imm;
    end
end

endmodule // id