`timescale 1ns/100ps

module tb_proyecto ();

parameter T=20;

logic CLK, RSTn;
logic [31:0] instruccion, read_data, data_RAM; 
logic [9:0] address_ROM,address_RAM;
logic wren;

//instanciacion
CORE duv_core(
		.reset(RSTn), 
		.clk(CLK), 
		.datos_IMEM(instruccion), 
		.datos_DMEM(read_data), 
		.dir_IMEM(address_ROM), 
		.dir_DMEM(address_RAM), 
		.w_DMEM(data_RAM), 
		.read_write(wren)
);

RAM duv_RAM(
		.data_in(data_RAM), 
		.address(address_RAM), 
		.wren(wren), 
		.clock(CLK), 
		.data_out(read_data)
);

ROM duv_ROM(
		.address(address_ROM), 
		.data_out(instruccion)
);

//------------ Reloj ------------
always
begin 
	#(T/2) CLK =  ~CLK;  
end


//------------ Pruebas ------------
initial
begin	

	CLK=1'b0;
	RSTn=1'b1;
	reset;
	
	repeat(20) @(posedge CLK);
	$stop();
end

task reset();
begin
   @(negedge CLK)
	RSTn = 1'b0;
   @(negedge CLK)
	RSTn = 1'b1;
end
endtask

endmodule 