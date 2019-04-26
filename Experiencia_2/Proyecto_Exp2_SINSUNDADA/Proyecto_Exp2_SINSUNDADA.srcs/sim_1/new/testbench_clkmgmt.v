`timescale 1ns / 1ps
module SIMULAME();
reg r_clk = 0;
wire [7:0] lawea;

SAW uut(r_clk,lawea);

always
#1 r_clk = ~r_clk;


initial
begin
#100000000 $finish;
end


endmodule
