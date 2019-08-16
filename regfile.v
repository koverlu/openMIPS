`include "defines.v"
//32 32-bits General Purpose Register
//Support 2 read operations and 1 write operation simultaneously
module regfile(
    input wire clk,
    input wire rst,
    //Write port
    input wire we,
    input wire [`REG_ADDR_BUS] waddr,
    input wire [`REG_BUS] wdata,

    //Read port1
    input wire re1,
    input wire[`REG_ADDR_BUS] raddr1,
    output reg[`REG_BUS] rdata1,

    //Read port2
    input wire re2,
    input wire[`REG_ADDR_BUS] raddr2,
    output reg[`REG_BUS] rdata2    
);

reg[`REG_BUS] regs[0:`REG_NUM - 1];
//Write operation
always @(posedge clk) begin
    if(rst == `RST_DISABLE) begin
        if((we == `WRITE_ENABLE) && (waddr != `REG_NUM_LOG2'h0)) begin
            regs[waddr] <= wdata;
        end
    end        
end

//Read1 operation
always @(*) begin
    if(rst == `RST_ENABLE || re1 == `READ_DISABLE || raddr1 == `REG_NUM_LOG2'h0) begin
        rdata1 <= `ZERO_DWORD; 
    end else if (we == `WRITE_ENABLE && raddr1 == waddr) begin
        rdata1 <= wdata;        
    end else begin
        rdata1 <= regs[raddr1];
    end
end

//Read2 operation
always @(*) begin
    if(rst == `RST_ENABLE || re2 == `READ_DISABLE || raddr2 == `REG_NUM_LOG2'h0) begin
        rdata2 <= `ZERO_DWORD;          
    end else if (we == `WRITE_ENABLE && raddr2 == waddr) begin
        rdata2 <= wdata;
    end else begin
        rdata2 <= regs[raddr2];
    end
end
endmodule //regfile 