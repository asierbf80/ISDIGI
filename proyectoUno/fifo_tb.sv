`timescale 1ns/100ps

module fifo_tb();

parameter T = 20;

logic CLOCK, RESET_N, CLEAR_N, READ, WRITE, F_FULL_N, F_EMPTY_N;
logic [4:0] USE_DW;
logic [7:0] DATA_IN, DATA_OUT;

FIFO duv (.CLOCK(CLOCK), 
			 .RESET_N(RESET_N), 
			 .CLEAR_N(CLEAR_N), 
			 .DATA_IN(DATA_IN), 
			 .READ(READ), 
			 .WRITE(WRITE), 
			 .F_FULL_N(F_FULL_N), 
			 .F_EMPTY_N(F_EMPTY_N), 
			 .USE_DW(USE_DW), 
			 .DATA_OUT(DATA_OUT));

//------------ Reloj ------------
always
begin 
	#(T/2) CLOCK =  ~CLOCK;  
end


//------------ Pruebas ------------
initial
begin	

	CLOCK=1'b0;
	RESET_N=1'b1;
	CLEAR_N=1'b1;
	READ=1'b0;
	WRITE=1'b0;
	
	caso_w();

	repeat(3) @(posedge CLOCK);
	caso_wr();

	repeat(3) @(posedge CLOCK);
	caso_llenar(); 

	repeat(3) @(posedge CLOCK);
	caso_vaciar();
	
	repeat(3) @(posedge CLOCK);
	simultaneo($random);
	
	repeat(3) @(posedge CLOCK);
	caso_mitad();
	
	repeat(3) @(posedge CLOCK);
	caso_w_llena();	
	
	repeat(3) @(posedge CLOCK);
	reset();
	lectura();
		
	$stop();
end

//------------ Tareas de casos ------------
task caso_w();
begin
	reset();
	escritura(8'b1);
end
endtask


task caso_wr();
begin
	reset();
	escritura(8'd2);
	escritura(8'd5);
	lectura();
end
endtask


task caso_llenar();
begin
	reset();
	repeat (32)	
	escritura($random);
	assert (F_FULL_N == 1'b0) else $display("Problema llenando fifo");
end
endtask


task caso_vaciar();
begin
	repeat(32)
	lectura(); // Se puede realizar un for? Si no está llena, cuantas veces leemos especificamente?
	assert (F_EMPTY_N == 1'b0) else $display("Problema vaciando fifo");
end
endtask


task caso_w_llena();
begin
	caso_llenar();
	escritura($random);	
end
endtask


task caso_mitad();
begin
	reset();
	repeat(16)
	escritura($random);
	repeat(16)
	lectura();
end
endtask


//------------ Tareas de bajo nivel ------------

task reset();
begin
   @(negedge CLOCK)
	RESET_N = 1'b0;
   @(negedge CLOCK)
	RESET_N = 1'b1;
end
endtask

task escritura(input reg[7:0] dato);
begin
	 @(negedge CLOCK)
	WRITE = 1'b1;
	DATA_IN=dato;
	@(negedge CLOCK)
	WRITE = 1'b0;
end
endtask

task lectura();
begin
 @(negedge CLOCK)
	READ = 1'b1;
	@(negedge CLOCK)
	READ = 1'b0;
end
endtask

task simultaneo(input reg[7:0] dato);
begin
	reset();
	@(negedge CLOCK)
	WRITE = 1'b1;
	DATA_IN = dato;
	READ = 1'b1;
	@(negedge CLOCK)
	WRITE = 1'b0;
	READ = 1'b0;
	
end
endtask


endmodule 