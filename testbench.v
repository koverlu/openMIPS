`include "defines.v"
`timescale 1ns/1ps
module openmips_min_sopc_tb();
reg clock_50;
reg rst;

//Signal clock_50 flips every 10ns. So T=20ns, f=50MHz
initial begin
    clock_50 = 1'b0;
    forever #10 clock_50 = ~clock_50;
end

initial begin
    rst = `RST_ENABLE;
    #195 rst = `RST_DISABLE;
    #1000 $stop;
end

openmips_min_sopc openmips_min_sopc0(
    .clk(clock_50),
    .rst(rst)
);
endmodule // openmips_min_sopc_tb