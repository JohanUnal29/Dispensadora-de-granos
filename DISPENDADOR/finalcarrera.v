`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:29:42 06/20/2023 
// Design Name: 
// Module Name:    finalcarrera 
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
module finalcarrera(
    input wire clk,
    input wire [1:0] btn,
    output reg [1:0] salida
);

reg [7:0] registro0 = 8'b0;
reg [7:0] registro1 = 8'b0;

always @(posedge clk) begin
    registro0 <= {registro0[6:0], btn[0]};
    registro1 <= {registro1[6:0], btn[1]};

    if (registro0 == 8'b11111111) begin
        salida[0] <= 1'b1;
    end else if(registro0 == 8'b0) begin
        salida[0] <= 1'b0;
    end

    if (registro1 == 8'b11111111) begin
        salida[1] <= 1'b1;
    end else if(registro1 == 8'b0) begin
        salida[1] <= 1'b0;
    end
end

endmodule


