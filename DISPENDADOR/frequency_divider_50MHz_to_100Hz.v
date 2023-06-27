`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:37:08 03/29/2023 
// Design Name: 
// Module Name:    frequency_divider_50MHz_to_100Hz 
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
module frequency_divider_50MHz_to_100Hz (
    input wire clk_50MHz,
    output reg clk_100Hz
);

// Para dividir la frecuencia de 50 MHz a 100 Hz, necesitamos dividirla por 500,000
localparam DIVISOR = 40000;

reg [31:0] counter;

always @(posedge clk_50MHz) begin
    if (counter == DIVISOR - 1) begin
        counter <= 0;
        clk_100Hz <= ~clk_100Hz;
    end else begin
        counter <= counter + 1;
    end
end

endmodule
