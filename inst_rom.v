`include "defines.v"
module inst_rom(
    input wire ce,
    input wire[`INST_ADDR_BUS] addr,
    output reg[`INST_BUS] inst
);

reg[`INST_BUS] inst_mem[0:`INST_MEM_BYTES / 4 - 1];

initial $readmemh("D:/project/openMIPS/inst_rom.data", inst_mem);

always @(*) begin
    if(ce == `CHIP_DISABLE) begin
        inst <= `ZERO_DWORD;
    end else begin
        inst <= inst_mem[addr[`INST_MEM_BYTES_LOG2 + 1 : 2]];
    end
end
endmodule // inst_rominput wire ce,