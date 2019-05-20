`timescale 1ns / 1ps
module Divisor4khz(
    input clk,
    output clkdiv
);
reg [13:0]count = 0;
reg clk_temp = 0;

always @ (posedge clk)
begin
if (count == 12499)
    begin
    count <= 0;
    clk_temp <= ~clk_temp;
    end
else
    count <= count + 1;
end

assign clkdiv = clk_temp;

endmodule