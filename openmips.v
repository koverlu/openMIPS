`include "defines.v"
module openmips(
    input wire rst,
    input wire clk,
    input wire[`INST_BUS] rom_data_i,

    output wire[`INST_ADDR_BUS] rom_addr_o,
    output wire rom_ce_o
);

//connect if_id to id
wire[`INST_ADDR_BUS] pc;
wire[`INST_ADDR_BUS] id_pc_i;
wire[`INST_BUS] id_inst_i;

//connect id to id_ex
wire[`ALU_OP_BUS] id_aluop_o;
wire[`ALU_SEL_BUS] id_alusel_o;
wire[`REG_ADDR_BUS] id_wd_o;
wire[`REG_BUS] id_reg1_o;
wire[`REG_BUS] id_reg2_o;
wire id_wreg_o;

//connect id_ex to ex
wire[`ALU_OP_BUS] ex_aluop_i;
wire[`ALU_SEL_BUS] ex_alusel_i;
wire[`REG_ADDR_BUS] ex_wd_i;
wire[`REG_BUS] ex_reg1_i;
wire[`REG_BUS] ex_reg2_i;
wire ex_wreg_i;

//connect ex to ex_mem
wire[`REG_ADDR_BUS] ex_wd_o;
wire ex_wreg_o;
wire[`REG_BUS] ex_wdata_o;

//connect ex_mem to mem
wire[`REG_ADDR_BUS] mem_wd_i;
wire mem_wreg_i;
wire[`REG_BUS] mem_wdata_i;

//connect mem to mem_wb
wire[`REG_ADDR_BUS] mem_wd_o;
wire mem_wreg_o;
wire[`REG_BUS] mem_wdata_o;

//connect mem_wb to wb
wire[`REG_ADDR_BUS] wb_wd_i;
wire wb_wreg_i;
wire[`REG_BUS] wb_wdata_i;

//connect id to regfile
wire reg1_read;
wire reg2_read;
wire[`REG_ADDR_BUS] reg1_addr;
wire[`REG_ADDR_BUS] reg2_addr;
wire[`REG_BUS] reg1_data;
wire[`REG_BUS] reg2_data;

pc_reg pc_reg0(
    .clk(clk), 
    .rst(rst), 
    .pc(pc), 
    .ce(rom_ce_o)
);

assign rom_addr_o = pc;

if_id if_id0(
    .clk(clk), 
    .rst(rst), 
    .if_pc(pc), 
    .if_inst(rom_data_i),
    //to id
    .id_pc(id_pc_i), 
    .id_inst(id_inst_i)
);

id id0(
    .rst(rst),
    //from if_id
    .pc_i(id_pc_i),
    .inst_i(id_inst_i),
    //from regfile
    .reg1_data_i(reg1_data),
    .reg2_data_i(reg2_data),
    //to regfile
    .reg1_read_o(reg1_read),
    .reg2_read_o(reg2_read),
    .reg1_addr_o(reg1_addr),
    .reg2_addr_o(reg2_addr),
    //to id_ex
    .aluop_o(id_aluop_o),
    .alusel_o(id_alusel_o),
    .wd_o(id_wd_o),
    .reg1_o(id_reg1_o),
    .reg2_o(id_reg2_o),
    .wreg_o(id_wreg_o)
);

regfile regfile0(
    .clk(clk),
    .rst(rst),
    //from mem_wb
    .we(wb_wreg_i),
    .waddr(wb_wd_i),
    .wdata(wb_wdata_i),
    //Read port1 from/to id
    .re1(reg1_read),
    .raddr1(reg1_addr),
    .rdata1(reg1_data),
    //Read port2 from/to id
    .re2(reg2_read),
    .raddr2(reg2_addr),
    .rdata2(reg2_data)    
);

id_ex id_ex0(
    .clk(clk),
    .rst(rst),
    //from id
    .id_aluop(id_aluop_o),
    .id_alusel(id_alusel_o),
    .id_wd(id_wd_o),
    .id_reg1(id_reg1_o),
    .id_reg2(id_reg2_o),
    .id_wreg(id_wreg_o),
    //to ex
    .ex_aluop(ex_aluop_i),
    .ex_alusel(ex_alusel_i),
    .ex_wd(ex_wd_i),
    .ex_reg1(ex_reg1_i),
    .ex_reg2(ex_reg2_i),
    .ex_wreg(ex_wreg_i)
);

ex ex0(
    .rst(rst),
    //from id_ex
    .alusel_i(ex_alusel_i),
    .aluop_i(ex_aluop_i),
    .reg1_i(ex_reg1_i),
    .reg2_i(ex_reg2_i),
    .wd_i(ex_wd_i),
    .wreg_i(ex_wreg_i),
    //to ex_mem
    .wd_o(ex_wd_o),
    .wreg_o(ex_wreg_o),
    .wdata_o(ex_wdata_o)   
);

ex_mem ex_mem0(
    .clk(clk),
    .rst(rst),
    //from ex
    .ex_wd(ex_wd_o),
    .ex_wreg(ex_wreg_o),
    .ex_wdata(ex_wdata_o),
    //to mem
    .mem_wd(mem_wd_i), 
    .mem_wreg(mem_wreg_i),
    .mem_wdata(mem_wdata_i)  
);

mem mem0(
    .rst(rst),
    //from ex_mem
    .wd_i(mem_wd_i),
    .wreg_i(mem_wreg_i),
    .wdata_i(mem_wdata_i),
    //to mem_wb
    .wd_o(mem_wd_o),
    .wreg_o(mem_wreg_o),
    .wdata_o(mem_wdata_o)
);

mem_wb mem_wb0(
    .rst(rst),
    .clk(clk),
    //from mem
    .mem_wd(mem_wd_o), 
    .mem_wreg(mem_wreg_o),
    .mem_wdata(mem_wdata_o),
    //to wb(regfile)
    .wb_wd(wb_wd_i),
    .wb_wreg(wb_wreg_i),
    .wb_wdata(wb_wdata_i)
);






endmodule // openmips