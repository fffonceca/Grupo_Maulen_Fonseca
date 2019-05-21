`timescale 1ns / 1ps
module SINEKEY(clk,clk_kb,data_kb,JA,led);
input clk,clk_kb,data_kb;
output [7:0] JA, led;

//WIRE
wire [7:0] out_reg;
wire [7:0] codigo;

//Modulos a llamar
Sine caezadepichula(clk,codigo,JA);
keyboard KEY(clk_kb, data_kb, out_reg);

assign codigo = out_reg;
assign led = out_reg;

endmodule
