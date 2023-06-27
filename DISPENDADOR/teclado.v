`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:46:41 05/09/2023 
// Design Name: 
// Module Name:    teclado 
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
module teclado(
  input [3:0] dato,
  input CLK,
  input data,
  output reg [3:0] salida,
  output oe
);

always @(posedge CLK) begin
    salida <= dato;
end

assign oe = ~(CLK & data);

endmodule

