`timescale 1ns / 1ps
module SIMULAME();
reg r_clk;
reg r_clk_kb;
reg r_data_kb;
wire [7:0] out_reg;

keyboard uut(r_clk,r_clk_kb,r_data_kb,out_reg);

always
begin
#5 r_clk = ~r_clk;
#50000 r_clk_kb = ~r_clk_kb;
end


initial 
begin
r_clk = 0;
r_clk_kb = 0;


end
endmodule
