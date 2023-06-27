`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:13:19 06/26/2023 
// Design Name: 
// Module Name:    control 
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
module control(
  input t,//0 permite llenar 1 motor moverse
  input x2,//derecha llenado
  input x1,//izqu
  input CLK,//cualquier reloj
  output DIR,//
  output Stop,//salida frenar o detener motor
  output Contador_ciclos,//
  output Empieza_tiempo,//tiempo
  
);
  wire s0;
  wire Q0_temp;
  wire s1;
  wire s2;
  wire Q1_temp;
  wire s3;
  wire s4;
  wire s5;
  wire s6;
  wire s7;
  wire s8;
  assign s4 = ~ x2;
  assign s6 = ~ t;
  assign s5 = ~ x1;
  assign s0 = ((s4 & s5 & Q0_temp) | (s3 & x1) | (x2 & Q1_temp & Q0_temp) | t);
  assign s2 = ((Q0_temp & x2) | (x2 & Q1_temp) | (Q1_temp & s5 & s4));
  assign s8 = (s6 & s1 & Q1_temp);
  assign DIR = (s7 | s8 | (s3 & x1));
  assign Stop = ((x2 & s8) | (x1 & Q1_temp) | (s7 & x2));
  assign Empieza_tiempo = (Q1_temp & s1 & ~ x1 & ~ s4 & s6);
  assign Contador_ciclos = (Q1_temp & Q0_temp & x1 & s4 & s6);
  DIG_D_FF_1bit #(
    .Default(0)
  )
  DIG_D_FF_1bit_i0 (
    .D( s0 ),
    .C( CLK ),
    .Q( Q0_temp ),
    .\~Q ( s1 )
  );
  DIG_D_FF_1bit #(
    .Default(0)
  )
  DIG_D_FF_1bit_i1 (
    .D( s2 ),
    .C( CLK ),
    .Q( Q1_temp ),
    .\~Q ( s3 )
  );
  assign s7 = (Q0_temp & s3);
  assign Q0 = Q0_temp;
  assign Q1 = Q1_temp;
endmodule

module DIG_D_FF_1bit
#(
    parameter Default = 0
)
(
   input D,
   input C,
   output Q,
   output \~Q
);
    reg state;

    assign Q = state;
    assign \~Q = ~state;

    always @ (posedge C) begin
        state <= D;
    end

    initial begin
        state = Default;
    end
endmodule

