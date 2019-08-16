`include "define.v"
module ex_mem(
    input wire clk,
    input wire rst,

    input wire[`REG_ADDR_BUS] ex_wd,
    input wire ex_wreg,
    input wire[`REG_BUS] ex_wdata,

    output reg[`REG_ADDR_BUS] mem_wd, 
    output reg mem_wreg,
    output reg[`REG_BUS] mem_wdata  
);

always @(posedge clk) begin
    if(rst == `RST_ENABLE) begin
        mem_wreg <= `WRITE_DISABLE;
        mem_wdata <= `ZERO_DWORD;
        mem_wd <= `NOP_REG_ADDR;
    end else begin
        mem_wreg <= ex_wreg;
        mem_wdata <= ex_wdata;
        mem_wd <= ex_wd;
    end
end

endmodule // ex_mem