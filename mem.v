`include "defines.v"
module mem(
    input wire rst,

    input wire[`REG_ADDR_BUS] wd_i,
    input wire wreg_i,
    input wire[`REG_BUS] wdata_i,

    output reg[`REG_ADDR_BUS] wd_o,
    output reg wreg_o,
    output reg[`REG_BUS] wdata_o
);

always @(*) begin
    if(rst == `RST_ENABLE) begin
        wreg_o <= `WRITE_DISABLE;
        wdata_o <= `ZERO_DWORD;
        wd_o <= `NOP_REG_ADDR;
    end else begin
        wreg_o <= wreg_i;
        wdata_o <= wdata_i;
        wd_o <= wd_i;
    end
end
endmodule // mem