`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:24:44 06/26/2023 
// Design Name: 
// Module Name:    two_second_timer 
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
module two_second_timer(
    input wire clk,
    input wire stop_signal,
    output reg clk_out
);
    reg [35:0] counter = 36'b0;

    always @(posedge clk)
    begin
        if(stop_signal)
        begin
            if(counter == 500) // 2 seconds have passed
            begin
                clk_out <= 1;
                counter <= 0;
            end
            else if(counter > 0) // if counter has started counting
            begin
                clk_out <= 0;
                counter <= counter + 1;
            end
            else
            begin
                clk_out <= 0;
                counter <= 1;
            end
        end
        else
        begin
            clk_out <= 0;
            counter <= 0;
        end
    end
endmodule

