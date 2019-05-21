`timescale 1ns / 10ps
//100Mhz / 115200 baudios = mas o menos: 868

module UART_SUNDADA
(
input clk,
input data,
output Signal,
output [7:0] byte
);

parameter CLKs_por_bit = 868;
parameter stand_by = 3'b000;
parameter bit_partida = 3'b001;
parameter leyendo = 3'b010;
parameter bit_parada = 3'b011;
parameter clean = 3'b100;

reg [11:0] counter = 0;
reg [2:0] indice_temp=0;
reg [7:0] Byte_temp=0;
reg [2:0] state=0;
reg signal_registro=0;

always @(posedge clk)
begin
    case(state)
        stand_by:
            begin
                counter<=0;
                indice_temp<=0;
                signal_registro <= 0;
                if (data == 1'b0)
                    state <= bit_partida;
                else
                    state <= stand_by;
            end
        bit_partida:
            begin
                if (counter == (CLKs_por_bit-1)/2 )
                    begin
                    if (data == 1'b0) //bit de parada?
                        begin
                        counter <= 0;
                        state <= leyendo;
                        end
                    else
                        state <= stand_by;
                    end
                else
                    begin
                    counter <= counter + 1;
                    state <= bit_partida;
                    end
            end

        leyendo:
            begin
                if (counter < CLKs_por_bit-1)
                    begin
                    counter <= counter + 1;
                    state <= leyendo;
                    end

                else
                    begin
                    counter <= 0;
                    Byte_temp[indice_temp] <= data;

                    if(indice_temp <7)
                        begin
                        indice_temp <= indice_temp + 1;
                        state <= leyendo;
                        end
                    else //terminamos de leer
                        begin
                        state <= bit_parada;
                        indice_temp <= 0;
                        end
                    end
            end
        bit_parada:
        begin
            if (counter < CLKs_por_bit)
                begin
                counter <= counter + 1;
                state <= bit_parada;
                end
            else
                begin
                counter <= 0;
                signal_registro <= 1'b1;
                state <= clean;
                end
        end
        clean:
            begin
            state <=  stand_by;
            signal_registro <= 1'b0;
            end

        default:
            state <= stand_by;
    endcase
end

assign byte = Byte_temp;
assign Signal = signal_registro;

endmodule
