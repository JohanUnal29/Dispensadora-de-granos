`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:33:25 03/29/2023 
// Design Name: 
// Module Name:    PRINCIPAL 
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

module PRINCIPAL (
    input wire clk_50MHz,     // Reloj del sistema de 50 MHz
    input wire rst, // Seal de reset
	input wire inicio, 	 
    input wire [3:0] btn,      // boton de prueba del modulo botones
              // Direccin: 0 para positivo, 1 para negativo
             // Seal de parada: 1 para detener, 0 para continuar
    output wire [3:0] coils,  // Seales de bobina: A, B, C y D
	 output wire dir, 
    output wire [6:0] Q,
    output wire led,
    output wire[3:0] btn_salida, // Boton salida ahora es de 4 bits
    output wire clk_100Hz,
    input wire [3:0] teclado_dato,
    input wire teclado_data,
    output wire [3:0] teclado_salida,
    output wire teclado_oe,
    input wire [1:0] btn_final,
	 output wire[1:0] stop_signal, // Señal de parada recibida
	output wire Contador_repiticiones,
    output wire stop,
	 output wire t,
	  output wire  [3:0] rise_count,
	 output wire  Empieza_tiempo,
	 output wire  senal_de_frenado,
		output reg inicio_otra,// se emplea para apagar la mauina de estado cuando el coteo sea igual al maximo
		output wire salida_apagado,
		output reg stop2,
		input wire [3:0] maximo,
		output wire [3:0] maximo2,
		 output wire [3:0] an
);

 Comparador_de_conteo comparador_ionstance(
  .Num_repeticiones(4'b0101),
  .X1(stop_signal[0]),
  .rise_count(rise_count),
  .Senal_frenado_maquina_estados(senal_de_frenado) 
);
/*
siete_segmento siete(
.BCD(rise_count),
.SSeg(Q)
);
*/

sietesegmenos siete_segmentos_instance (
    .xi(rise_count),
    .yi(maximo2),
    .clk(clk_50MHz),
    .sg(Q),
    .an(an)
  );
 
contador counter_instance (
    .clk(clk_100Hz),            // Conectar el reloj del sistema al módulo RisingEdgeCounter
    .reset(inicio),                // Conectar la señal de reset al módulo RisingEdgeCounter
    .input_signal(Contador_repiticiones), // Conectar la señal de entrada al módulo RisingEdgeCounter
    .rise_count(rise_count) ,  // Conectar la salida rise_count del módulo RisingEdgeCounter
	 .salida_apagado(salida_apagado),
	 .maximo(maximo)
	 
  );
  
 
   
 contol control_instance (
    .t(t),
	 	 // Conecta la señal 't' al puerto 't' del módulo 'control'
    .x2(stop_signal[0]),                  // Conecta la señal 'x2' al puerto 'x2' del módulo 'control'
    .x1(inicio_otra),                  // Conecta la señal 'x1' al puerto 'x1' del módulo 'control'
    .CLK(clk_100Hz),          // Conecta la señal 'clk_100Hz' al puerto 'CLK' del módulo 'control'
    .DIR(dir),                // Conecta el puerto 'DIR' del módulo 'control' a la señal 'DIR' del módulo 'PRINCIPAL'
    .Stop(stop) ,
	  .Contador_ciclos(Contador_repiticiones),
	  .Empieza_tiempo(Empieza_tiempo)
	 // Conecta el puerto 'Stop' del módulo 'control' a la señal 'Stop' del módulo 'PRINCIPAL'
    // ... otros puertos de salida y entrada del módulo 'control' ...
  );


   assign inicio_otra_temp = salida_apagado || stop_signal[1];
	assign inicio_otra_temp2 = salida_apagado || stop;
	assign maximo2= maximo;
    always @(posedge clk_50MHz)
    begin
        inicio_otra <= inicio_otra_temp;
		  stop2 <= inicio_otra_temp2;
    end

// Instanciar el módulo frequency_divider_50MHz_to_100Hz
frequency_divider_50MHz_to_100Hz freq_divider (
    .clk_50MHz(clk_50MHz),
    .clk_100Hz(clk_100Hz)
);

two_second_timer u1 (
	  .clk(clk_100Hz),           // Conectar el reloj del sistema al módulo del temporizador
	  .stop_signal(Empieza_tiempo),  // Conectar la señal de stop al módulo del temporizador
	  .clk_out(t)    // Salida del módulo del temporizador conectada a la salida del módulo principal
 );

// Instancia del módulo stepper_motor_28BYJ48 
stepper_motor_28BYJ48 motor_instance (   // Nueva instancia de motor
    .clk(clk_100Hz),
    .rst(rst),
    .dir(dir),                     // Usamos 'motor_dir' en lugar de 'dir'
    .stop(stop2),                   // Usamos 'motor_stop' en lugar de 'stop'
    .coil_signals(coils)
);

// Instanciar el módulo Teclado
/*keyboard_4x4 keyboard (
    .Fila(btn_salida),
    .CLK(clk_100Hz),
    .led(led),
    .Columna(col),
    .Q(Q)
);
*/
// Instanciar el módulo botones
botones boton ( 
    .clk(clk_100Hz),
    .btn(btn), 
    .salida(btn_salida)
);

teclado teclado (
    .dato(teclado_dato),
    .CLK(clk_100Hz),
    .data(teclado_data),
    .salida(teclado_salida),
    .oe(teclado_oe)
);

// Instanciar el módulo finalcarrera
finalcarrera final_carrera (
    .clk(clk_50MHz),
    .btn(btn_final),
    .salida(stop_signal)
);

// Asignación continua para conectar stop desde el módulo finalcarrera


endmodule


