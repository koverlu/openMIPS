`include "defines.v"
module id_ex(
    input wire clk,
    input wire rst,
    //from id
    input wire[`ALU_OP_BUS] id_aluop,        //operation type
    input wire[`ALU_SEL_BUS] id_alusel,      //ALU type(logic)
    input wire[`REG_ADDR_BUS] id_wd,         //Write dst GPR address
    input wire[`REG_BUS] id_reg1,
    input wire[`REG_BUS] id_reg2,
    input wire id_wreg,
    //to ex
    output reg[`ALU_OP_BUS] ex_aluop,        //operation type
    output reg[`ALU_SEL_BUS] ex_alusel,      //ALU type(logic)
    output reg[`REG_ADDR_BUS] ex_wd,         //Write dst GPR address
    output reg[`REG_BUS] ex_reg1,
    output reg[`REG_BUS] ex_reg2,
    output reg ex_wreg
);

always @(posedge clk) begin
    if (rst == `RST_ENABLE) begin
        ex_aluop <= `EXE_NOP_OP;
        ex_alusel <= `EXE_RES_NOP;
        ex_reg1 <= `ZERO_DWORD;
        ex_reg2 <= `ZERO_DWORD;
        ex_wd <= `NOP_REG_ADDR;
        ex_wreg <= `WRITE_DISABLE;
    end else begin
        ex_aluop <= id_aluop;
        ex_alusel <= id_alusel;
        ex_reg1 <= id_reg1;
        ex_reg2 <= id_reg2;
        ex_wd <= id_wd;
        ex_wreg <= id_wreg;
    end
end

endmodule // id_ex