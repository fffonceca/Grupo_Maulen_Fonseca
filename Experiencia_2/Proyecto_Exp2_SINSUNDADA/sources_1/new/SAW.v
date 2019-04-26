`timescale 1ns / 1ps

module SAW(
input clk,
output reg [7:0] counter 
    );
wire clock_nuevo;
initial
counter <= 0;

div_saw nombre_decente1(clk,clock_nuevo);
 
always @(posedge clock_nuevo)
begin
counter <= counter + 1;
end


endmodule
