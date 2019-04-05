`timescale 1ns / 10ps

module MAIN(
input clk,
input data,
input sw,
output dp,
output [6:0] seg,
output [3:0] an
);

localparam N = 16;

reg [N-1:0] count = 0; //contador para switchear las entradas
reg [3:0] an_temp = 0; //registro de an_temp para anodos.
reg [6:0] sseg_temp = 0; //registro de 7 segmentos para los segmentos.
reg dp_temp = 0; //decimal que cambiará con el switcheo
reg [3:0] sseg = 0; //registro para definir que BCD se va a escribir.
reg [1:0] counter_bcd = 0;



wire [15:0] data_bcd;   //VOLTAJE BAJO
wire [15:0] data_bcd_2; //VOLTAJE ALTO

MS_suma_BCDs BCD16(clk,data,data_bcd,data_bcd_2);

always @ (posedge clk) ///Multiplexor para 1000Hz yeah
 count <= count + 1;

always @ (*) //Este always es para cambiar de anodo en anodo del sevenseg
begin
  case({count[N-1:N-2],sw})
  ////////////Switch en 0, voltaje bajo ///////////////////////////////////
   3'b000 :
				 begin
				  an_temp = 4'b1110;
                  sseg = data_bcd[3:0]; //cambiar este dato si esta incorrecto. //d3
                  dp_temp = 1'b1;  //decimal apagado
				 end
   3'b010 :
				 begin
				  an_temp = 4'b1101;
                  sseg = data_bcd[7:4]; //d2
                  dp_temp = 1'b1;  //decimal apagado
				 end

   3'b100 :
				 begin
				  an_temp = 4'b1011;
                  sseg = data_bcd[11:8]; //d1
                  dp_temp = 1'b0; //prendemos los decimales en esta posicion.
				 end
   3'b110 :
				 begin
				  an_temp = 4'b0111;
                  sseg = data_bcd[15:12];   //numero 15, apagar leds. daahh
                  dp_temp = 1'b1;   //decimal apagado
				 end
 ////////////////////   VOLTAJE ALTO ///switch en 1 ////////////////////////
   3'b001 :
				 begin
				  an_temp = 4'b1110;
                  sseg = data_bcd_2[3:0]; //cambiar este dato si esta incorrecto. //d3
                  dp_temp = 1'b1;  //decimal apagado
				 end
   3'b011 :
				 begin
				  an_temp = 4'b1101;
                  sseg = data_bcd_2[7:4]; //d2
                  dp_temp = 1'b1;  //decimal apagado
				 end

   3'b101 :
				 begin
				  an_temp = 4'b1011;
                  sseg = data_bcd_2[11:8]; //d1
                  dp_temp = 1'b0; //prendemos los decimales en esta posicion.
				 end
   3'b111 :
				 begin
				  an_temp = 4'b0111;
                  sseg = data_bcd_2[15:12];   //numero 15, apagar leds. daahh
                  dp_temp = 1'b1;   //decimal apagado
				 end
				 	 
  endcase
 end



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
assign an = an_temp; //define la salida del anodo escogido como la de la salida.
assign dp = dp_temp; //define decimal a salida.

endmodule
