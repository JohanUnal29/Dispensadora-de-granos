`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:13:40 06/27/2023 
// Design Name: 
// Module Name:    divsorsementos 
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
module divsorsementos(clk,clkis,an);
input clk;
output [1:0] clkis;
output [3:0] an;
reg [32:0]count=0;
reg [1:0] clk1s;
reg [3:0] ant;
always @ (posedge clk)
    if(count<50000)
   	 count=count+1;
    else
    begin
   	 clk1s=clk1s+1;
   	 count=0;
   	 case (clk1s)
   		 2'b00: ant = 4'b0111; // "0"  
   		 2'b01: ant = 4'b1011;
   		 2'b10: ant = 4'b1101;
   		 2'b11: ant = 4'b1110;
   	 endcase
   	 
end
assign clkis = clk1s;
assign an = ant;
endmodule