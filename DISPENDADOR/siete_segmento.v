`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:24:12 06/26/2023 
// Design Name: 
// Module Name:    siete_segmento 
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
module siete_segmento(BCD, SSeg);

  input [3:0] BCD;
  output reg [6:0] SSeg;


always @ ( * ) begin
  case (BCD)
   4'b0000: SSeg = 7'b0000001; // "0"  
	4'b0001: SSeg = 7'b1111001; // "1" 
	4'b0010: SSeg = 7'b0100100; // "2" 
	4'b0011: SSeg = 7'b0110000; // "3" 
	4'b0100: SSeg = 7'b1011000; // "4" 
	4'b0101: SSeg = 7'b0010010; // "5" 
	4'b0110: SSeg = 7'b0000010; // "6" 
	4'b0111: SSeg = 7'b0111001; // "7" 
	4'b1000: SSeg = 7'b0000000; // "8"  
	4'b1001: SSeg = 7'b0010000; // "9"
	4'ha: SSeg = 7'b0001000;  
   4'hb: SSeg = 7'b1000010;
   4'hc: SSeg = 7'b0000111;
   4'hd: SSeg = 7'b1100000;
   4'he: SSeg = 7'b0000110;
   4'hf: SSeg = 7'b0001110;
    default:
    SSeg = 0;
  endcase
end
endmodule