`timescale 1ns / 1ps
module Sine(clk,codigo,salida);
input clk;
input [7:0] codigo;
output reg [7:0] salida = 128;

//WIRE
wire [6:0] salida_sine;
wire clk4khz;

//REGISTROS 
reg [9:0] salto;  //FIJA VALOR DE PARTE ENTERA Y DECIMAL
reg [5:0] part_ent; //PARTE ENTERA
reg [3:0] BCD; //PRIMER DECIMAL
reg [0:0] estado = 0; //cuarto de la onda
reg [3:0] suma = 0; //suma parcial de los BCD
reg [6:0] index = 0; //asigna valor real que se leera en MEM_SINE

//Acceder al IPCORE
MEM_SINE SINE(
    .a(index),
    .spo(salida_sine)
);

//CLOCK 4KHZ
Divisor4khz clock_dive(clk,clk4khz);

//SINE CONFIGURATION
always @ (*)
	case(codigo)
		8'h15: begin 
		salto = 10'b10000_0111;
		part_ent = salto[9:4];
        BCD = salto[3:0]; 
		end
		8'h1d: begin
		salto = 10'b10001_0111; 
		part_ent = salto[9:4];
        BCD = salto[3:0]; 
		end
		8'h24: begin
		salto = 10'b10010_0111;
		part_ent = salto[9:4];
         BCD = salto[3:0]; 
		end 
		8'h2d: begin
		salto = 10'b10011_1001;
		part_ent = salto[9:4];
        BCD = salto[3:0]; 
		end 
		8'h2c: begin
		salto = 10'b10101_0000;
		part_ent = salto[9:4];
        BCD = salto[3:0]; 
		end 
		8'h35: begin
		salto = 10'b10110_0011;
		part_ent = salto[9:4];
        BCD = salto[3:0]; 
		end 
		8'h3c: begin
		salto = 10'b10111_0110; 
		part_ent = salto[9:4];
        BCD = salto[3:0]; 
		end
		8'h43: begin
		salto = 10'b11001_0000; 
		part_ent = salto[9:4];
        BCD = salto[3:0]; 
        end
		8'h44: begin 
		salto = 10'b11010_0101; 
		part_ent = salto[9:4];
        BCD = salto[3:0]; 
        end
		8'h4d: begin
		salto = 10'b11100_0001;
		part_ent = salto[9:4];
        BCD = salto[3:0]; 
        end 
		8'h1c: begin
		salto = 10'b11101_1000; 
		part_ent = salto[9:4];
        BCD = salto[3:0]; 
        end
		8'h1b: begin
		salto = 10'b11111_0110;
		part_ent = salto[9:4];
        BCD = salto[3:0]; 
		end 
		8'h23: begin
		salto = 10'b100001_0100; 
		part_ent = salto[9:4];
        BCD = salto[3:0]; 
		end
		8'h2b: begin
		salto = 10'b100011_0100; 
		part_ent = salto[9:4];
        BCD = salto[3:0]; 
        end
		8'h34: begin
		salto = 10'b100101_0101; 
		part_ent = salto[9:4];
        BCD = salto[3:0]; 
        end
		8'h33: begin
		salto = 10'b100111_1000; 
		part_ent = salto[9:4];
        BCD = salto[3:0]; 
        end
		8'h3b: begin 
		salto = 10'b101010_0001; 
		part_ent = salto[9:4];
        BCD = salto[3:0]; 
        end
 		8'h42: begin
 		salto = 10'b101100_0111; 
 		part_ent = salto[9:4];
        BCD = salto[3:0]; 
        end
		8'h4b: begin
		salto = 10'b101111_0011; 
		part_ent = salto[9:4];
        BCD = salto[3:0]; 
        end
		8'h22: begin
		salto = 10'b110010_0001; 
		part_ent = salto[9:4];
        BCD = salto[3:0]; 
        end
		8'h21: begin
		salto = 10'b110101_0001; 
		part_ent = salto[9:4];
        BCD = salto[3:0]; 
        end
		8'h2a: begin
		salto = 10'b111000_0011; 
		part_ent = salto[9:4];
        BCD = salto[3:0]; 
        end
		8'h32: begin
		salto = 10'b111011_0110;
		part_ent = salto[9:4];
        BCD = salto[3:0]; 
        end 
		8'h31: begin
		salto = 10'b111111_0010; 
		part_ent = salto[9:4];
        BCD = salto[3:0]; 
        end
        default: 
        begin
        salto = 10'b00000_0000;
        part_ent = salto[9:4];
        BCD = salto[3:0]; 
        end
	endcase

//TRANSICION
always @ (posedge clk4khz)
case(estado)
    2'b00: 
    begin
    if (suma + BCD > 9)
        begin
        suma <= suma + BCD +6; 
        index = index + 1;
        end
    else
        suma <= suma + BCD;
        
    if(index + part_ent > 126) /// SI CAMBIAMOS DE ESTADO, puede superar maximo
        begin
        estado <= 2'b01;
        index <= 255-(index+part_ent+1);
        salida <= {1'b1,salida_sine};
        end
    else
        begin
        index  <= index + part_ent;
        salida <= {1'b1,salida_sine};
        end
    end
	2'b01: 
		begin
        if (suma + BCD > 9) //BCD
			begin
            suma <= suma + BCD +6; 
            index = index - 1;
            end
		else
			suma <= suma + BCD;

		if(index  < part_ent) //SI ME PASO
            begin
            estado <= 2'b10;
            index  <= part_ent - index;
            salida <= {1'b1,salida_sine};
            end
		else
            begin
            index  <= index - part_ent;
            salida <= {1'b1,salida_sine};
            end
		end
	2'b10: 
		begin
        if (suma + BCD > 9) //BCD
			begin
            suma <= suma + BCD +6; 
            index = index + 1;
            end
		else
			suma <= suma + BCD;
		
		if(index + part_ent > 126) //SI ME PASO, ES IGUAL QUE ESTADO 0->1
            begin
            estado <= 2'b11;
            index  <= 255-(index+part_ent+1);
            salida <= 127 - {1'b0,salida_sine};
            end
		else
            begin
            index  <= index + part_ent;
            salida <= 127 - {1'b0,salida_sine};
            end
		end
	2'b11: 
		begin
        if (suma + BCD > 9) //BCD
			begin
            suma <= suma + BCD +6; 
            index = index - 1;
            end
		else
			suma <= suma + BCD;
			
        if(index  < part_ent) //SI ME PASO, ES IGUAL QUE ESTADO 0->1
            begin
            estado <= 2'b00;
            index  <= part_ent - index;
            salida <= 127 - {1'b0,salida_sine};
            end
		else
            begin
            index  <= index - part_ent;
            salida <= 127 - {1'b0,salida_sine};
            end
		end
	endcase
	
endmodule