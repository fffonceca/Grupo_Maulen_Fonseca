`timescale 1ns / 1ps

module MS_suma_BCDs
(
input clk,
input data,
output [11:0] data12
);

parameter esperando = 2'b00; 
parameter procesando = 2'b01;
parameter LISTO = 2'b10; 

wire Signal;
wire [7:0] Byte;

reg estado_contador;
reg [4:0] indice_bcd; //son 12 bits nomas
reg [11:0] data12_temp;

UART_a_lo_choro BCD8(clk,data,Signal,Byte);

initial
indice_bcd = 0;

always @(posedge clk)
    begin
        case(estado_contador)
            esperando: 
            begin
                if (Signal ==0)
                    begin
                    indice_bcd <=0;
                    estado_contador <= esperando;
                    data12_temp <= 0;
                    end
                else
                    begin
                    estado_contador <= procesando;
                    end
            end
            procesando: 
            begin
            if (indice_bcd < 12)
                begin
                estado_contador <= LISTO;
                end
            else
                begin
                if (Signal == 0)
                    begin
                    estado_contador <= procesando;
                    end
                
                else
                    begin
                    data12_temp[indice_bcd] <= Byte[3]; ///Esto hay que cambiarlo si esta mal.
                    data12_temp[indice_bcd+1] <= Byte[4];
                    data12_temp[indice_bcd+2] <= Byte[5];
                    data12_temp[indice_bcd+3] <= Byte[6];
                    indice_bcd <= indice_bcd + 4;
                    estado_contador <= procesando;
                    end
                end
            end
            
            LISTO: 
            begin
                estado_contador <= esperando;
                indice_bcd <= 0;
            end
            
            default:
                estado_contador <= esperando;
        endcase
    
    end

assign data12 = data12_temp & (estado_contador == LISTO); //se transferirá la información a data12 solo si la MS esta lista.


endmodule
