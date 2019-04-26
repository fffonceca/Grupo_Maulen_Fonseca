`timescale 1ns / 1ps
module SIMULAME();
reg r_clk = 0;
reg [1:0] sw = 3;
wire lawea;

COMPARADOR uut(r_clk,sw,lawea);

always
#5 r_clk = ~r_clk;

initial
begin
#100000000;
end
endmodule
