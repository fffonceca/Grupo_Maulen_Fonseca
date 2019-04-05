`timescale 1ns/10ps

module MS_suma_BCDs
(
input clk,
input data,
output [11:0] data12
);

parameter esperando = 2'b00; 
parameter procesando = 2'b01;
parameter enviando = 2'b10; 

wire Signal;
wire [7:0] Byte;

reg [1:0] estado_contador = 0;
reg [4:0] indice_bcd = 0; //son 12 bits nomas
reg [11:0] data12_temp = 0;
reg [1:0] contador_signal = 0;

UART_a_lo_choro BCD8(clk,data,Signal,Byte);

always @(posedge clk)
    begin
        case(estado_contador)
            esperando: 
            begin
                if (Signal == 0)
                    begin
                    estado_contador <= esperando;
                    end
                else
                    begin
                    estado_contador <= procesando;
                    data12_temp[indice_bcd] <= Byte[0];    ///Esto hay que cambiarlo si esta mal. //
                    data12_temp[indice_bcd+1] <= Byte[1]; //
                    data12_temp[indice_bcd+2] <= Byte[2]; //
                    data12_temp[indice_bcd+3] <= Byte[3];  //
                    contador_signal <= contador_signal + 1; 
                    indice_bcd <= indice_bcd + 4;      
                    end
            end
            procesando:
            begin
                if (contador_signal < 3)
                begin
                    if (Signal == 0)
                    begin
                      estado_contador <= procesando;
                    end
                    else
                    begin
                    estado_contador <= procesando;
                    data12_temp[indice_bcd] <= Byte[0];    ///Esto hay que cambiarlo si esta mal. //3
                    data12_temp[indice_bcd+1] <= Byte[1]; //4 
                    data12_temp[indice_bcd+2] <= Byte[2]; //5
                    data12_temp[indice_bcd+3] <= Byte[3];  //6
                    contador_signal <= contador_signal + 1;     
                    indice_bcd <= indice_bcd + 4;    
                    end
                end
                else
                begin
                estado_contador <= enviando;
                contador_signal <= 0;
                end
            end
                 
            enviando: 
            begin
                estado_contador <= esperando;
                indice_bcd <= 0;
                contador_signal <= 0;
                indice_bcd <=0;
               
            end
            
            default:
                estado_contador <= esperando;
        endcase
    end

assign data12 = data12_temp; //se transferirá la información a data12 solo si la MS esta lista.

endmodule
