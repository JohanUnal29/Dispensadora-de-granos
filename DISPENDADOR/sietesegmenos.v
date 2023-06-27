`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:19:14 06/27/2023 
// Design Name: 
// Module Name:    sietesegmenos 
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
module sietesegmenos (
    input [3:0] xi,
    input [3:0] yi,
    input clk,
    output wire [6:0] sg,
    output wire [3:0] an,
	  output wire [1:0] clk1s,
	   output [6:0] seg1,
  output wire [6:0] seg2,
  output wire[6:0] seg3,
  output wire[6:0] seg4

);
   
    
 
    reg [6:0] seg;

    divsorsementos divisor(clk, clk1s, an);
	 
    siete_segmento b0(4'b0000 , seg1);
    siete_segmento b1(xi, seg2);
    siete_segmento b2(4'b0000, seg3);
    siete_segmento b3(yi, seg4);

    always @(*) begin
        case (an)
            4'b1110: seg = seg4; // "0"  
            4'b1101: seg = seg3;
            4'b1011: seg = seg2;
            4'b0111: seg = seg1;
        endcase
    end

    assign sg = seg;
endmodule
