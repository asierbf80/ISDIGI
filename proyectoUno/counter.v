module counter(CLK,RSTn,EN,UP_DOWN,TC,COUNT);

parameter M = 32; // Módulo 
parameter N = $clog2(M-1); // Número de bits

input CLK,RSTn, EN, UP_DOWN;
output reg [N-1:0] COUNT;
output TC;

always @(posedge CLK or negedge RSTn)
	if(!RSTn)
		COUNT <= {N{1'b0}};
	else
		if(UP_DOWN == 1'b1)
			if(EN == 1'b1)
				if(COUNT == M-1)
					COUNT <= {N{1'b0}};
				else
					COUNT <= COUNT + 1;
			else
				COUNT <= COUNT;
		else
			if(EN == 1'b1)
				if(COUNT == {N{1'b0}})
					COUNT <= M-1;
				else
					COUNT <= COUNT - 1;
			else
				COUNT <= COUNT;
				
assign TC = (UP_DOWN == 1'b1 && COUNT == M-1 && EN == 1'b1) ? 1'b1 : 
				(UP_DOWN == 1'b0 && COUNT == {N{1'b1}} && EN == 1'b1) ? 1'b1 : 1'b0;
				
		
endmodule 