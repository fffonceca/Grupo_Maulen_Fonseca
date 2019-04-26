`timescale 1ns / 1ps
module div_saw(
    input clk,
    output clkdiv
);
reg [4:0] N = 8;
reg [9:0]count = 0;
reg clk_temp = 0;



always @ (posedge clk)
begin
if (count == N-1)
    begin
    count <= 0;
    clk_temp <= ~clk_temp;
    end
else
    count <= count + 1;
end

assign clkdiv = clk_temp;

endmodule
