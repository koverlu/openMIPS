`include "defines.v"
module openmips_min_sopc(
    input wire clk,
    input wire rst
);
wire[`INST_ADDR_BUS] inst_addr;
wire[`INST_BUS] inst;
wire rom_ce;

openmips openmips0(
    .rst(rst),
    .clk(clk),
    //from rom
    .rom_data_i(inst),
    //to rom
    .rom_addr_o(inst_addr),
    .rom_ce_o(rom_ce)
);

inst_rom inst_rom0(
    .ce(rom_ce),
    .addr(inst_addr),
    .inst(inst)
);

endmodule // 