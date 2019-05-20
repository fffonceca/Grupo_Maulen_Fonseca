`timescale 1ns / 1ps

module Sine(clk_in,codigo,salida);
input clk_in;
input [7:0] codigo;
output reg [7:0] salida = 128;

//WIRE
wire [6:0] salida_sine;
wire clk;
//REGISTROS
reg [9:0] salto;
reg [5:0] part_ent;
reg [3:0] BCD;
reg [1:0] cuarto = 0;
reg [3:0] suma = 0;
reg [6:0] index1 = 0;
reg [6:0] index2 = 127;
reg [6:0] index3 = 0;
reg [6:0] index4 = 0;


reg [6:0] index = 0; //asigna valor real que se leera en MEM_SINE
//Acceder al IPCORE

MEM_SINE SINE(
    .a(index),
    .spo(salida_sine)
);

Divisor4khz clock_dive(clk_in,clk);


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
        salto = 10'b1_0111;
        part_ent = salto[9:4];
        BCD = salto[3:0]; 
        end
	endcase


always @ (posedge clk)
case(cuarto)
	2'b00:
		begin
		if (suma + BCD > 9)
			begin
            suma <= suma + BCD +6;
			if(index1 + 1 > 127)
				begin
				index2 <= 127-(index1+1);
				cuarto <= 2'b01;
				end
			else
                index1 = index1 + 1;
			end
		else
			suma <= suma + BCD;

		if( index1+part_ent <= 127)
			begin
			index1 = index1 + part_ent;
			index <= index1;
			salida <= {1'b1,salida_sine};
			end

		else if(index1 + part_ent > 127)
			begin
			cuarto <= 2'b01;
			index2 <= 127-(index1+part_ent-128);
			end
		end
	2'b01:
		begin
		if(suma+BCD >9)
			begin
			suma <= suma+BCD + 6;
			index2 = index2 -1;
			end
		else
			suma <= suma + BCD;

		if(index2 < part_ent)
		  begin
			cuarto <= 2'b10;
			index3 <= 0+ (part_ent-index2);
		  end
		else
		  begin
		    index2 = index2-part_ent;
		    index <= index2;
		    salida <= {1'b1,salida_sine};
		  end
		end
	2'b10:
		begin
		if (suma + BCD >9)
			begin
			suma <= suma+BCD+6;
			if(index3 + 1 > 127)
				begin
				index4 <= 127-(index3+1-127);
				cuarto <= 2'b11;
				end
			else
				index3 = index3+1;
			end
		else
			suma <= suma +BCD;
		if (index3 + part_ent > 127)
			begin
			cuarto <= 2'b11;
			index4 <= 127-(index3+part_ent-127); 
			end
		else
			begin
			index3 = index3+part_ent;
            index <= index3;
			salida <= 128-{1'b0,salida_sine};
			end
		end

	2'b11:
		begin
		if (suma+BCD >9)
			begin
			suma <= suma+BCD+6;
			if (index4 - 1 < 0)
                begin
                    cuarto <= 2'b00;
                    index1 <= 1-index4;
                end
			else
				index4 = index4-1;
			end
		if (index4  < part_ent)
		  begin
			cuarto <= 2'b00;
			index1 <= part_ent - index4;
		  end
			
		else
			begin
			index4 = index4-part_ent;
			index <= index4;
			salida <= 128-{1'b0,salida_sine};
			end
		end
	endcase
	
endmodule