`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:34:41 03/29/2023 
// Design Name: 
// Module Name:    stepper_motor_28BYJ48 
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
module stepper_motor_28BYJ48 (
    input wire clk,          // Reloj del sistema
    input wire rst,          // Señal de reset
    input wire dir,          // Dirección: 0 para positivo, 1 para negativo
    input wire stop,         // Señal de parada: 1 para detener, 0 para continuar
    output reg [3:0] coil_signals
);

// Secuencia de medio paso para el motor paso a paso 28BYJ-48
reg [3:0] HALF_STEP_SEQUENCE [7:0];

initial begin
    HALF_STEP_SEQUENCE[0] = 4'b1000;
    HALF_STEP_SEQUENCE[1] = 4'b1100;
    HALF_STEP_SEQUENCE[2] = 4'b0100;
    HALF_STEP_SEQUENCE[3] = 4'b0110;
    HALF_STEP_SEQUENCE[4] = 4'b0010;
    HALF_STEP_SEQUENCE[5] = 4'b0011;
    HALF_STEP_SEQUENCE[6] = 4'b0001;
    HALF_STEP_SEQUENCE[7] = 4'b1001;
end

integer step_index;
integer next_step_index;
reg dir_last = 0;          // Guardará el último valor de dir
reg stop2 = 1'b1;          // Nuevo registro interno

always @(posedge clk or posedge rst) begin
    if (rst) begin
        step_index <= 0;
        coil_signals <= 4'b0000;
        dir_last <= 0;
        stop2 <= stop;
    end else begin
        stop2 <= (dir != dir_last) ? 1'b0 : stop;    // Si dir cambia, stop2 será 0. Si no, stop2 toma el valor de stop.
        dir_last <= dir;                             // Actualizamos dir_last para la próxima comparación

        if (!stop2) begin
            next_step_index = dir ? step_index - 1 : step_index + 1;
            if (next_step_index < 0) begin
                next_step_index = 7;
            end
            if (next_step_index > 7) begin
                next_step_index = 0;
            end
            step_index <= next_step_index;
            coil_signals <= HALF_STEP_SEQUENCE[next_step_index];
        end
    end
end

endmodule