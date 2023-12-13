module banco_registros(clock, reset, read_register_1, read_register_2, write_register,write_data, reg_write,  read_data_1, read_data_2); // dos lecturas y una lectura simultanea 

parameter tamanyo = 32; 

input clock, reset; 
input [4:0] read_register_1, read_register_2, write_register; 
input [tamanyo-1:0] write_data; 
input reg_write; //señal de habilitacion de la escritura 
output reg [tamanyo-1:0] read_data_1, read_data_2; 

reg [tamanyo-1:0] [0:tamanyo-1] memoria ; // indica el numero de registros, 32. Almacena los datos 
// memoria bidimensional 32x32


//PROCESO DE ESCRITURA Y LECTURAS
always_ff @(posedge clock or negedge reset) // utilizamos el bloque always_ff para la escritura sincrona 
begin 
	if (!reset)
		memoria <= '0; 
	else 
		if (reg_write && (write_register!=0)) 
			begin
				memoria [write_register] <=  write_data; 
			end 
end 

always_comb // lecturas asincronas 
begin
	read_data_1 = (read_register_1 == 0) ? '0 : memoria[read_register_1]; 
	read_data_2 = memoria[read_register_2]; 
end 

endmodule 
	