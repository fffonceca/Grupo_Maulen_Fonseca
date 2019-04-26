`timescale 1ns / 1ps

//Este comparador compara (equisde) entre los valores de la sierra vs SINE ( o la senal entrante del ADC).
//darse cuenta que hay que implementar la UART para recibir la señal del JB1 despues...

module COMPARADOR(
input clk,
input [1:0] sw,
output VALOR_FINAL
    );


wire [7:0] SINE_W;
wire [7:0] SAW_W;
reg VALOR_FINAL_temp;

SINE  senal_sine(clk,sw,SINE_W);
SAW   senal_saw(clk,SAW_W);

always@(posedge clk)
begin
    if(SAW_W > SINE_W )
        begin
        VALOR_FINAL_temp <= 0;
        end
    else
        begin
        VALOR_FINAL_temp <= 1;
        end
end

assign VALOR_FINAL = VALOR_FINAL_temp;

endmodule
