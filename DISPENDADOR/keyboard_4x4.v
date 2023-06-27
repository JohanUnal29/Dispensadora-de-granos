`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:38:20 04/08/2023 
// Design Name: 
// Module Name:    keyboard_4x4 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////


module keyboard_4x4 (
    input [3:0] Fila,
    input CLK,
    output led,
    output reg [3:0] Columna,
    output [6:0] Q
);

  reg [1:0] presente, prox;
  reg dato;
  reg [3:0] Qn;
  reg [3:0] F;
  reg [16:0] count;
  reg clk_s;

  initial begin
    Qn = 4'b1111;
    F = 4'b1111;
  end

  always @(posedge CLK)
  begin
    if (count < 2500000) // Para un reloj de 1 MHz, usar 25000 para obtener 20 Hz
      count <= count + 1;
    else
    begin
      clk_s <= ~clk_s;
      count <= 0;
    end
  end

  always @(presente, Fila)
  begin
    case (presente)
      2'b00: // A
      begin
        Columna <= 4'b1000;
        case (Fila)
          4'b1000: begin F = 4'b0001; dato = 1; end
          4'b0100: begin F = 4'b0100; dato = 1; end
          4'b0010: begin F = 4'b0111; dato = 1; end
          4'b0001: begin F = 4'b1110; dato = 1; end
          default: begin dato = 0; end
        endcase
        prox <= 2'b01;
      end

      2'b01: // B
begin
  Columna <= 4'b0100;
  case (Fila)
    4'b1000: begin F = 4'b0001; dato = 1; end
    4'b0100: begin F = 4'b0100; dato = 1; end
    4'b0010: begin F = 4'b0111; dato = 1; end
    4'b0001: begin F = 4'b1110; dato = 1; end
    default: begin dato = 0; end
  endcase
  prox <= 2'b10;
end

2'b10: // C
begin
  Columna <= 4'b0010;
  case (Fila)
    4'b1000: begin F = 4'b0001; dato = 1; end
    4'b0100: begin F = 4'b0100; dato = 1; end
    4'b0010: begin F = 4'b0111; dato = 1; end
    4'b0001: begin F = 4'b1110; dato = 1; end
    default: begin dato = 0; end
  endcase
  prox <= 2'b11;
end

2'b11: // D
begin
  Columna <= 4'b0001;
    case (Fila)
    4'b1000: begin F = 4'b0001; dato = 1; end
    4'b0100: begin F = 4'b0100; dato = 1; end
    4'b0010: begin F = 4'b0111; dato = 1; end
    4'b0001: begin F = 4'b1110; dato = 1; end
    default: begin dato = 0; end
  endcase
  prox <= 2'b00;
end

    endcase
  end

  always @(posedge clk_s)
  begin
    if (dato == 0)
      Qn <= 4'b0;
    else
      Qn <= F;
		presente = prox;
  end

  assign led = dato;

  assign Q = (Qn == 4'b0001) ? 7'b1111001 :
             (Qn == 4'b0010) ? 7'b0100100 :
             (Qn == 4'b0011) ? 7'b0110000 :
             (Qn == 4'b0100) ? 7'b0011001 :
             (Qn == 4'b0101) ? 7'b0010010 :
             (Qn == 4'b0110) ? 7'b0000010 :
             (Qn == 4'b0111) ? 7'b1111000 :
             (Qn == 4'b1000) ? 7'b0000000 :
             (Qn == 4'b1001) ? 7'b0010000 :
             (Qn == 4'b1010) ? 7'b0001000 :
             (Qn == 4'b1011) ? 7'b0000011 :
             (Qn == 4'b1100) ? 7'b1000110 :
             (Qn == 4'b1101) ? 7'b0100001 :
             (Qn == 4'b1110) ? 7'b0000110 :
                              7'b1000000; // Para todos los demás casos, incluido 4'b1111, mostrar un guión alto (segmento A encendido)

endmodule



