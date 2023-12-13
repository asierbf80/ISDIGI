module ROM(address, data_out); //lecturas asincronas

parameter data = 32; 
parameter add = 1024; 

input [9: 0] address; 
output [data-1: 0] data_out; 

logic [data-1: 0]  mem [add-1:0]; 

initial 
	$readmemh("fibonacci_source.txt",mem); 
assign data_out = mem[address]; 

endmodule 