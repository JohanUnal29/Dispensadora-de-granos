
  

  

<p  align="center">  <img  src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/a2/Escudo_de_la_Universidad_Nacional_de_Colombia_%282016%29.svg/798px-Escudo_de_la_Universidad_Nacional_de_Colombia_%282016%29.svg.png"  alt="Escudo Universidad Nacional"  style="height:300px; width:250px"  />  </p>

  

  

<h1  align="center">Dispensador de granos</h1>

  

  

<p  align="center">Laboratorio Electrónica Digital I</p>

  

<br></br>

  

<p  align="center">Ingeniería Eléctrica y Electrónica</p>

  

<br></br>

  

<h4  align="center">Integrantes:</h4>

  

<p  align="center">Andrés Camilo Díaz Ariza</p>

  

<p  align="center">Johan Nicolás Ardila Hernández</p>

  

<p  align="center">Emiro andres lara Ruiz</p>

  

<br></br>

  

<h4  align="center">Profesores:</h4>

  

<p  align="center">Diego Alexander Tibaduiza Burgos</p>

  

<p  align="center">Johnny German Cubides Castro</p>

  

<br></br>

  

<p  align="center">Electrónica Digital I</p>

  

<p  align="center">Universidad Nacional de Colombia</p>

  

<p  align="center">Bogotá D.C.</p>

  

<p  align="center">Facultad de Ingeniería</p>

  

<p  align="center">2023</p>

  

  

## Imagen del proyecto

<p  align="center"><img  src="https://drive.google.com/uc?export=download&id=1V8LD-SszciNObAwh6efMUB6CzLbXfnDx"  /></p>

<p  align="center"><img  src="https://drive.google.com/uc?export=download&id=1QHOr6ckiYKxwRgUx-XXk2VxiJ8xjuA1m"  /></p>

## Descripción

  

<p  style="text-align: justify">

  

  

A continuación se explicará el proyecto del dispensador de granos, que tiene como objetivo satisfacer las necesidades del sector agropecuario colombiano, en particular en aplicaciones portátiles para la cría de gallinas y otros animales pequeños. El dispensador de granos se diseñará y desarrollará utilizando principios de Electrónica Digital, con el fin de automatizar y simplificar este proceso.

  

  

Para su funcionamiento el dispensador contará con una tarjeta FPGA Nexys 2 de la marca AMD, compuesta por una maquina de estados, un motor, dos sensores final de carrera y pulsadores, controlados por el lenguaje de programación verilog, a esto sumado un prototipo funcional impreso en 3D.

  

  

</p>

  

  

## Alcance y problemática

  

<p  style="text-align: justify">

  

  

Diseñar, desarrollar e implementar un dispositivo automatizado que permita la distribución eficiente de granos en la cría de gallinas, esto con el fin de optimizar tiempo y recursos en el sector agropecuario.

  

  

Esta idea nace a partir de la necesidad de una alimentación adecuada y regular de los animales en el sector agropecuario colombiano. Los agricultores y criadores enfrentan dificultades para alimentar a sus animales de manera constante y controlada, lo que puede afectar la salud y el crecimiento de los mismos. Además, el proceso de alimentación manual requiere tiempo y esfuerzo, lo que puede limitar la eficiencia y la productividad en el manejo de los animales.

  

  

</p>

  

  

## Objetivos

  

<p  style="text-align: justify">

  

**Principal:**

  

- Diseñar un dispensador que mejore la distribución de granos en la cría de gallinas con el fin de optimizar tiempo y recursos en el sector agropecuario.

  

**Secundarios**

  

- Diseñar e implementar un prototipo funcional para suplir las funciones fisico/mecancias del proyecto.

  

- Diseñar y aplicar una maquina de estados para controlar la mayor parte lógica del proyecto

  

- Implementar el ingreso de repeticiones de distribución por teclado matricial.

  

- Mostrar el conteo utilizando los displays 7 segmentos.

  

- Configurar el tiempo de recolección de granos necesarios para llenar el recipiente.

  

</p>

  

  

## Diagrama de cajas negras, de bloques

  

### Diagrama:

  

<p  style="text-align: justify">A continuación podemos evidenciar la conexión entre los diferentes modulos del proyecto, modulos que más adelante serán explicados </p>

  

<p  align="center"><img  src="https://drive.google.com/uc?export=download&id=1t2Hqz4Sm-9nNRownKtfwdIvLhrZLvAjp"  /></p>

  
  

### Motor:

  

  

<p  align="center"><img  src="https://drive.google.com/uc?export=download&id=18Gswz4wRFPrKELA2Q42kpWCM8g1iPTaU"  /></p>

  

<p  style="text-align: justify">

  

Este módulo implementa un controlador de motor paso a paso para el motor 28BYJ-48. El controlador puede decidir sobre la dirección de rotación del motor y puede detener o reanudar la rotación.

  

  

**Entradas:**

  

  

-  `clk`: Esta es la señal de reloj que se utiliza para sincronizar el módulo.

  

  

-  `rst`: Esta es la señal de reset que se utiliza para restablecer el índice de paso a 0 y detener la rotación del motor.

  

-  `dir`: Esta es la dirección de rotación del motor. Un valor de 0 indica una rotación positiva (en sentido horario), mientras que un valor de 1 indica una rotación negativa (en sentido antihorario).

  

-  `stop`: Esta es la señal de parada. Un valor de 1 detiene el motor y un valor de 0 permite que el motor continúe.

  

  

**Salidas:**

  

-  `coil_signals`: Esta es una señal de 4 bits que se utiliza para controlar los cuatro bobinas del motor.

  

  

**Funcionamiento**

  

El módulo comienza definiendo una secuencia de pasos en medio paso para el motor 28BYJ-48, que se almacena en el registro HALF_STEP_SEQUENCE. Luego, en cada flanco de subida de la señal de reloj clk o en el flanco de subida de la señal de reset rst (si rst está en alto), se reinician varios elementos: el índice de paso step_index, las señales de bobina coil_signals, el último valor de dir (dir_last) y un nuevo registro interno llamado stop2.

  

En caso de que rst no esté en alto, se verifica si el valor de dir ha cambiado con respecto al ciclo de reloj anterior. Si ha cambiado, se establece stop2 en 0, lo que permite que el motor comience a moverse en la nueva dirección. Si no ha cambiado, stop2 adopta el valor de stop.

  

Si stop2 es bajo, se calcula el siguiente índice de paso next_step_index en función de la dirección dir. Si dir es 0, se incrementa step_index; si dir es 1, se decrementa step_index. Se manejan los casos en los que next_step_index se sale del rango [0,7] para reiniciar la secuencia de pasos.

  

Por último, se actualiza step_index con el valor de next_step_index y se modifican las señales de bobina coil_signals según el nuevo paso en la secuencia.

  

</p>

  

  

### Teclado (modulo botones):

  

<p  align="center"><img  src="https://drive.google.com/uc?export=download&id=1cFq-oWvHnjCxXl1Ot-TDIHvCIqL2kRLa"  /></p>

  

  

<p  style="text-align: justify">

  

El módulo "Botones" es un módulo en Verilog que detecta la presión de un botón, ya sea estable o inestable, durante varios ciclos de reloj. Implementa un filtro digital de software para eliminar el rebote de los botones físicos. Este módulo recibe una señal de reloj (clk) y las señales de los botones (btn) como entradas, y produce una salida (salida) que indica si un botón ha sido presionado de manera estable durante 8 ciclos de reloj.

  

  

**Entradas:**

  

-  `clk`: Señal de reloj. El flanco de subida de esta señal activa el muestreo de las señales de los botones.

  

-  `btn[3:0]`: Vector de 4 bits que representa el estado de los 4 botones. Cada bit indica el estado de un botón: 1 cuando el botón está presionado, y 0 cuando no lo está.

  

  

**Salidas:**

  

  

-  `salida[3:0]`: Vector de 4 bits que representa la salida del módulo. Cada bit de esta salida corresponde a uno de los botones en la entrada btn. Un bit de salida se establece en 1 cuando el botón correspondiente ha sido presionado de manera estable durante 8 ciclos de reloj, y se establece en 0 cuando el botón correspondiente no ha sido presionado de manera estable durante 8 ciclos de reloj.

  

  

**Funcionamiento del Módulo:**

  

  

En cada flanco de subida de clk, el módulo mueve el estado actual del botón al bit menos significativo de un registro de desplazamiento de 8 bits (registro0 para btn[0], registro1 para btn[1], etc.), desplazando los demás bits una posición a la izquierda.

  

A continuación, el módulo verifica si todos los bits en el registro de desplazamiento son 1 o 0. Si todos los bits son 1, lo cual indica que el botón ha sido presionado de manera estable durante 8 ciclos de reloj, se establece el bit correspondiente en la salida en 1. Si todos los bits son 0, lo cual indica que el botón no ha sido presionado de manera estable durante 8 ciclos de reloj, se establece el bit correspondiente en la salida en 0.

  

  

</p>

  

  

### Final de carrera:

  

<p  align="center"><img  src="https://drive.google.com/uc?export=download&id=1mW4VLW6phuq5ikxuStRd7IDqpqCSkyXx"  /></p>

  

  

<p  style="text-align: justify">

  

  

El módulo finalcarrera es un controlador para detectar eventos de carrera final, utilizando dos registros. Un evento de carrera se considera completo cuando los registros (registro0 y registro1) alcanzan el valor '11111111'. La salida es una señal lógica 'OR' de los dos registros.

  

  

**Entradas:**

  

-  `clk`: Señal de reloj de entrada. El flanco de subida de esta señal activa las operaciones dentro del módulo.

  

-  `btn[2:0]`: Vector de 2 bits que corresponde a los botones de entrada. En cada flanco de subida del reloj, cada bit del vector se registra en un registro separado (registro0 para btn[0] y registro1 para btn[1]).

  

  

**Salidas:**

  

-  `salida2`: Salida digital que se activa (se establece en '1') cuando alguno de los registros alcanza el valor '11111111', o cuando el bit correspondiente en la salida es '1'.

  

  

**Funcionamiento:**

  

El módulo finalcarrera recibe dos entradas: el reloj (clk) y un vector de dos bits (btn). En cada flanco de subida del reloj, el bit 0 del vector btn se desplaza al registro0, y el bit 1 del vector btn se desplaza al registro1. Esto implica que los registros registro0 y registro1 realizan una operación de registro de desplazamiento.

  

Si en algún momento el registro0 se llena con todos los bits en '1' (es decir, se vuelve '11111111'), se activa la salida 0 (es decir, salida[0] se establece en '1'). De manera similar, si el registro1 se llena con todos los bits en '1' (es decir, se vuelve '11111111'), se activa la salida 1 (es decir, salida[1] se establece en '1').

  

La salida final (salida2) es el resultado de una operación OR de los dos bits de salida. En otras palabras, si alguno de los bits de salida es '1', entonces salida2 también será '1'.

  

  

**Notas adicionales:**

  

  

registro0 y registro1 son registros de 8 bits utilizados para la operación de registro de desplazamiento.

  

  

salida es un registro de 2 bits utilizado para almacenar las salidas correspondientes de registro0 y registro1.

  

</p>

  

### Final de carrera:

  

<p  align="center"><img  src="https://drive.google.com/uc?export=download&id=1Xe_XT_q3on2CKUjiMzQIMnNJiVJKKzVy"  /></p>

  

  

<p  style="text-align: justify">

  

  

Este módulo de temporizador de conteo en Verilog cuenta hasta 25 cada vez que recibe una señal de parada.

  

  

**Entradas:**

  

-  `clk`: Señal de reloj de entrada. El flanco de subida de esta señal activa las operaciones dentro del módulo.

  

-  `Stop signal`: El módulo contador comienza a contar cuando la señal "stop_signal" se encuentra en alto.

  

  

**Salidas:**

  

-  `clk_out`: Se activa cuando el conteo llega a 25

**Funcionamiento:**

  
  

- Realiza un conteo hasta 25 ciclos de reloj.

- Inicia el conteo cuando recibe una señal de parada.

- Genera una salida activa cuando alcanza el conteo de 25.

  

El módulo contador comienza a contar cuando la señal "stop_signal" se encuentra en alto. El contador se incrementa en cada ciclo de reloj. Cuando el contador alcanza el valor de 25, la salida "clk_out" se activa durante un ciclo de reloj y luego se reinicia a 0. Si la señal "stop_signal" se establece en bajo, el contador se reinicia a 0.

### Divisor de frecuencia:

  

<p  align="center"><img  src="https://drive.google.com/uc?export=download&id=1GvYZ2SyU0xTwThEPUAL2A4_X6LB54TTM"  /></p>

  

  

<p  style="text-align: justify">

  

  

Este módulo diseñado en Verilog funciona como un divisor de frecuencia, reduciendo una señal de entrada de 50 MHz a una frecuencia de salida de 100 Hz.

  

  

**Entradas:**

  

-  `clk_50MHz (tipo: wire)`: Señal de reloj de entrada esperada con una frecuencia de 50 MHz.

  
  

**Salidas:**

  

-  `clk_100Hz`: Señal de reloj de salida que ha sido reducida a una frecuencia de 100 Hz.

**Funcionamiento:**

  

El módulo implementa un contador que se incrementa en cada flanco de subida de la señal de reloj de entrada (clk_50MHz). Cuando el contador alcanza el valor de DIVISOR - 1, se reinicia a 0 y la señal de reloj de salida (clk_100Hz) cambia de estado. De esta manera, por cada DIVISOR flancos de subida en clk_50MHz, se obtiene un único flanco de subida en clk_100Hz, lo que reduce efectivamente la frecuencia.

  

Sin embargo, es importante mencionar que en el código proporcionado, el valor de DIVISOR se ha establecido en 40000, lo cual no resulta en una frecuencia de salida de 100 Hz, sino en una frecuencia mucho más alta. Para lograr una salida de 100 Hz al convertir una señal de 50 MHz, el valor correcto para DIVISOR debería ser 500,000 (calculado como 50,000,000 / 100). Se recomienda corregir el valor de DIVISOR para obtener los resultados esperados.

### Contador:

  

<p  align="center"><img  src="https://drive.google.com/uc?export=download&id=1wbIYKN6zVki8JqHL23JZMe7YBNrAfLp_"  /></p>

  

  

<p  style="text-align: justify">

  

El módulo contador es un contador de flancos de subida que registra el número de veces que la señal de entrada experimenta un flanco de subida. El contador se almacena en el registro "rise_count", el cual es un vector de 4 bits. Además, el módulo proporciona una salida llamada "salida_apagado", que se activa cuando la cuenta alcanza el valor máximo especificado por la señal "maximo" o cuando "maximo" es igual a 4'b0000.

  

**Entradas:**

  

-  `clk(tipo: wire)`:Señal de reloj que controla el comportamiento del módulo.

-  `reset (wire)`:Señal de reset que restablece la cuenta a 0.

-  `input_signal (wire)`:Señal de entrada utilizada para contar los flancos de subida.

-  `maximo (wire [3:0])`: Valor máximo que se desea alcanzar en "rise_count".

  

**Salidas:**

  

-  `rise_count (reg [3:0])`: Salida que muestra el número de flancos de subida detectados. La cuenta se almacena en un registro de 4 bits.

-  `salida_apagado (reg)`: Salida que se activa cuando la cuenta alcanza el valor máximo especificado por "maximo" o cuando "maximo" es igual a 4'b0000.

**Funcionamiento:**

  

El módulo contador cuenta los flancos de subida de la señal de entrada "input_signal". Cada vez que se detecta un flanco de subida, la salida "rise_count" se incrementa en 1. La cuenta se mantiene en el rango de 0 a 15 (binario) y se almacena en el registro interno "rise_count". Cuando la señal de reset "reset" se activa, la cuenta se restablece a 0. Si "maximo" es igual a 4'b0000, la salida "salida_apagado" se activa de inmediato. De lo contrario, "salida_apagado" se activa cuando "rise_count" alcanza el valor especificado por "maximo".

  
  

## Diagrama de flujo de su solución

  

<p  align="center"><img  src="https://drive.google.com/uc?export=download&id=17w0of8XUILDTnA1OlQS7ZlRkkuhfWaPd"  /></p>

  

  

## Máquina de estados

  

<p  align="center"><img  src="https://drive.google.com/uc?export=download&id=1h4DcYRqFcgQtGaXpi1SJ2sjknXm4dJsz"  /></p>

  

  

## Simulaciones (las más relevantes)

  

  

<p  style="text-align: justify">

  

  

**A continuación se evidencia la simulación de la maquina de estados:**

  

  

</p>

  

  

[![Vista previa del video](https://i.ytimg.com/vi/JroxjESi-8Y/hqdefault.jpg)](https://youtu.be/JroxjESi-8Y)

  

  

<p  style="text-align: justify">

  

  

**A continuación se evidencia la simulación del prototipo funcional:**

  

  

</p>

  

  

[![Texto alternativo](https://img.youtube.com/vi/l9OhKDxRPds/0.jpg)](https://youtu.be/l9OhKDxRPds)

  

## Vídeo del proyecto 

[![Texto alternativo](https://img.youtube.com/vi/kct24l4yY-Q/0.jpg)](https://www.youtube.com/watch?v=kct24l4yY-Q)

  

## Referencias

  

  

<p  style="text-align: justify">

  

  

- UNAL - DNIA - plataforma moodle. (s/f). Edu.Co. Recuperado el 27 de junio de 2023, de https://micampus.unal.edu.co/course/view.php?id=38149 (Material curso electrónica digital).

  

  

</p>