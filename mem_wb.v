`include "defines.v"
module mem_wb(
    input wire rst,
    input wire clk,

    input wire[`REG_ADDR_BUS] mem_wd, 
    input wire mem_wreg,
    input wire[`REG_BUS] mem_wdata,

    output reg[`REG_ADDR_BUS] wb_wd,
    output reg wb_wreg,
    output reg[`REG_BUS] wb_wdata
);

always @(posedge clk) begin
    if(rst == `RST_ENABLE) begin
        wb_wreg <= `WRITE_DISABLE;
        wb_wdata <= `ZERO_DWORD;
        wb_wd <= `NOP_REG_ADDR;
    end else begin
        wb_wreg <= mem_wreg;
        wb_wdata <= mem_wdata;
        wb_wd <= mem_wd;
    end
end
endmodule // mem_wb