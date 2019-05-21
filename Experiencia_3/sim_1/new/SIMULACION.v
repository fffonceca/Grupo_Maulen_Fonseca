`timescale 1ns / 1ps
module SIMULAME();
reg r_clk=0;
reg [7:0] r_codigo = 8'h1d;
wire [7:0] salida;

Sine uut(
    .clk(r_clk),
    .codigo(r_codigo),
    .salida(salida)
);

always
#5 r_clk = ~r_clk;

endmodule
