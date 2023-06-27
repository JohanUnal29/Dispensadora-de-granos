`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:24:01 04/14/2023 
// Design Name: 
// Module Name:    botones 
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
module botones(
    input wire clk,
    input wire [3:0] btn,
    output reg [3:0] salida
);

// Declaración de registros separados para cada bit de btn
reg [7:0] registro0 = 8'b0;
reg [7:0] registro1 = 8'b0;
reg [7:0] registro2 = 8'b0;
reg [7:0] registro3 = 8'b0;

always @(posedge clk) begin
    registro0 <= {registro0[6:0], btn[0]};
    registro1 <= {registro1[6:0], btn[1]};
    registro2 <= {registro2[6:0], btn[2]};
    registro3 <= {registro3[6:0], btn[3]};

    // Verifica si todos los bits del registro están en 1 o en 0
    if (registro0 == 8'b11111111) begin
        salida[0] <= 1'b1;
    end else if(registro0 == 8'b0)begin
        salida[0] <= 1'b0;
    end

    if (registro1 == 8'b11111111) begin
        salida[1] <= 1'b1;
    end else if(registro1 == 8'b0)begin
        salida[1] <= 1'b0;
    end

    if (registro2 == 8'b11111111) begin
        salida[2] <= 1'b1;
    end else if(registro2 == 8'b0)begin
        salida[2] <= 1'b0;
    end

    if (registro3 == 8'b11111111) begin
        salida[3] <= 1'b1;
    end else if(registro3 == 8'b0)begin
        salida[3] <= 1'b0;
    end
end

endmodule
