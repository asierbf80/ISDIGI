module divisor_segmentado(CLK,RSTa,START,NUM,DEN,COC,RES,DONE);

parameter tamanyo=8;
parameter etapas = 1+2*tamanyo;

input  CLK,RSTa,START;
input [tamanyo-1:0] NUM;
input  [tamanyo-1:0] DEN;
output logic [tamanyo-1:0] COC;
output logic [tamanyo-1:0] RES;
output logic DONE;

logic [etapas-1:0] start;
logic [etapas-1:0][tamanyo-1:0] accu;
logic [etapas-1:0][tamanyo-1:0] q;
logic [etapas-1:0][tamanyo-1:0] m;



always_ff @(posedge CLK or negedge RSTa)
begin
	if (!RSTa)
	begin
		start = 1'b0;
		accu = 1'b0;
		q = 1'b0;
		m = 1'b0;
	end
	else 
	begin
		start[etapas-1] = START;
		if (START) 
		begin
			accu[etapas-1] = 1'b0;
			q[etapas-1] = NUM;
			m[etapas-1] = DEN;
		end
			for (int i = etapas-2; i>-1; i=i-1)
			begin
				start[i] = start[i+1];
				m[i] = m[i+1];
				if (start[i+1])
				begin
					if(i % 2 == 1) 
						{accu[i],q[i]} = {accu[i+1][tamanyo-2:0],q[i+1],1'b0};
					else
						if(accu[i] >= m[i]) 
						begin
							q[i] = q[i+1]+1;
							accu[i] = accu[i+1] - m[i+1];
						end
						else
						begin
							q[i] = q[i+1];
							accu[i] = accu[i+1];
						end
				end
/*		else
		begin
			accu[i] = 1'b0;
			q[i] = 1'b0;
			m[i] = 1'b0;
		end*/
		end
	end	
end



always_comb 
begin
	DONE = start[0];
	COC = q[0];
	RES = accu[0];
end 


endmodule 