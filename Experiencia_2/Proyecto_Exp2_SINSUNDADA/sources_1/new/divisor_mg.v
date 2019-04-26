`timescale 1ns / 1ps
module Divisordeclk(
    input clk,
    input [1:0] sw,
    output clkdiv
);
reg [9:0] N_reg = 0;
reg [9:0]count = 0;
reg clk_temp = 0;

always @ (posedge clk)
begin
    case(sw)
        2'b00: N_reg <= 888;
        2'b01: N_reg <= 499;
        2'b10: N_reg <= 353;
        2'b11: N_reg <= 264;
        default: N_reg <= 888;
    endcase
end

always @ (posedge clk)
begin
if (count == N_reg-1)
    begin
    count <= 0;
    clk_temp <= ~clk_temp;
    end
else
    count <= count + 1;
end

assign clkdiv = clk_temp;

endmodule