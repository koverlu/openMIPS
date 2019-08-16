`include "defines.v"
module ex(
    input wire rst,
    input wire[`ALU_SEL_BUS] alusel_i,
    input wire[`ALU_OP_BUS] aluop_i,
    input wire[`REG_BUS] reg1_i,
    input wire[`REG_BUS] reg2_i,
    input wire[`REG_ADDR_BUS] wd_i,
    input wire wreg_i;

    output reg[`REG_ADDR_BUS] wd_o,
    output reg wreg_o,
    output reg[`REG_BUS] wdata_o   
);
reg[`REG_BUS] logicout;
always @(*) begin
    if(rst == `RST_ENABLE) begin
        wreg_o <= `WRITE_DISABLE;
        wdata_o <= `ZERO_DWORD;
        wd_o <= `NOP_REG_ADDR;
    end else begin
        case(aluop_i)
            `EXE_OR_OP: begin
                logicout <= reg1_i | reg2_i;
            end
            default: begin
                logicout <= `ZERO_DWORD;
            end
    end
end

always @(*) begin
    wd_o <= wd_i;
    wreg_o <= wreg_i;
    case (alusel_i)
        `EXE_RES_LOGIC: begin
            wdata_o <= logicout;
        end 
        default: begin
            wdata_o <= `ZERO_DWORD;
        end
    endcase
end
endmodule // ex