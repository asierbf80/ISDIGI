module RAM (data_in, address, wren, clock, data_out); // lecturas asincronas y escrituas sincronas 

parameter data = 32; 
parameter add = 1024; 

input [data-1: 0] data_in; 
input [9: 0]  address; 
input wren, clock; 
output [data-1: 0] data_out; 

logic [add-1: 0] [data-1:0] mem; 

//cambiar para segmentacion el enable de lectura

always_ff @(posedge clock)
	if (!wren)
		mem[address] <= data_in; 
		
assign data_out = mem[address]; 

endmodule
