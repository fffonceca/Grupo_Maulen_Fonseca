`timescale 1ns / 1ps

module MAIN
(
input clock,
input data,
output dp,
output [6:0] seg,
output [3:0] an
);

localparam N = 21;

reg [N-1:0] count; //contador para switchear las entradas
reg [3:0] an_temp; //registro de an_temp para anodos.
reg [6:0] sseg_temp; //registro de 7 segmentos para los segmentos.
reg dp_temp; //decimal que cambiará con el switcheo
reg [3:0] sseg; //registro para definir que BCD se va a escribir.
reg [1:0] counter_bcd;

wire [11:0] data_bcd;

MS_suma_BCDs BCD12(clock,data,data_bcd);

always @ (posedge clock) ///Multiplexor para 1000Hz yeah
 count <= count + 1;

always @ (*) //Este always es para cambiar de anodo en anodo del sevenseg
begin
  case(count[N-1:N-2])
   2'b00 :
				 begin
				  an_temp = 4'b1110;
                  sseg = data_bcd[3:0]; //cambiar este dato si esta incorrecto. //d3
                  dp_temp = 1'b1;  //decimal apagado
				 end
   2'b01 :
				 begin
				  an_temp = 4'b1101;
                  sseg = data_bcd[7:4]; //d2
                  dp_temp = 1'b1;  //decimal apagado
				 end

   2'b10:
				 begin
				  an_temp = 4'b1011;
                  sseg = data_bcd[11:8]; //d1
                  dp_temp = 1'b0; //prendemos los decimales en esta posicion.
				 end
	2'b11:
				 begin
				  an_temp = 4'b0111;
                  sseg = 4'b1111;   //numero 15, apagar leds. daahh
                  dp_temp = 1'b1;   //decimal apagado
				 end
  endcase
 end

 assign an = an_temp; //define la salida del anodo escogido como la de la salida.
 assign dp = dp_temp; //define decimal a salida.


 always @ (*) //always para definir que numero llevara el sseg en cada caso
  begin
   case(sseg)
    4'd0 : sseg_temp = 7'b1000000; //to display 0
    4'd1 : sseg_temp = 7'b1111001; //to display 1
    4'd2 : sseg_temp = 7'b0100100; //to display 2
    4'd3 : sseg_temp = 7'b0110000; //to display 3
    4'd4 : sseg_temp = 7'b0011001; //to display 4
    4'd5 : sseg_temp = 7'b0010010; //to display 5
    4'd6 : sseg_temp = 7'b0000010; //to display 6
    4'd7 : sseg_temp = 7'b1111000; //to display 7
    4'd8 : sseg_temp = 7'b0000000; //to display 8
    4'd9 : sseg_temp = 7'b0010000; //to display 9
    default : sseg_temp = 7'b1111111; //nada
   endcase
  end

assign seg = sseg_temp;

endmodule
