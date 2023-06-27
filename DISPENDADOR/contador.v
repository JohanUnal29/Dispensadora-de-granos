`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:25:21 06/26/2023 
// Design Name: 
// Module Name:    contador 
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
module contador(
    input wire clk,
    input wire reset,
    input wire input_signal,
    input wire [3:0] maximo,
   
    output reg [3:0] rise_count,
    output reg salida_apagado
);
    reg prev_input_signal;

    always @(posedge clk or posedge reset)
    begin
        if(reset)
        begin
            rise_count <= 4'b0000;
            prev_input_signal <= 1'b0;
            salida_apagado <= 0;
        end
        else
        begin
            if(input_signal && !prev_input_signal)
                rise_count <= rise_count + 1;
            
            prev_input_signal <= input_signal;

            if(rise_count == maximo ||  maximo == 4'b0000)
                salida_apagado <= 1;
            else
                salida_apagado <= 0;
        end
    end
endmodule


