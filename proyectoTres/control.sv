module control (OPCODE, BRANCH, MemRead, MemReg, ALUOp, MemWrite, ALUScr, RegWrite, AuipcLui); 

input [6:0] OPCODE; 
output logic BRANCH, MemRead, MemReg; 
output logic [2:0] ALUOp; 
output logic MemWrite, ALUScr, RegWrite; 
output logic [1:0] AuipcLui; 

always_comb 
begin
	case(OPCODE)
		7'b0110011: // tipo R, TODO MEMORIAS DESACTIVADO.
		begin
						BRANCH= 1'b0; //DESACTIVADA
						MemRead = 1'b1; //DESACTIVADA
						MemReg = 1'b0;//DESACTIVADA
						ALUOp = 3'b000 ; //CODIFICACION
						MemWrite = 1'b1; //DESACTIVADA
						ALUScr = 1'b0; //DESACTIVADA
						RegWrite = 1'b1; //ACTIVADA
						AuipcLui = 2'b10; // datos del registros
		end 
		7'b0010011: //tipo I INMEDIATO tipo 1, REGWRITE ACTIVADA
		begin
						BRANCH= 1'b0; //DESACTIVADA
						MemRead = 1'b1; //DESACTIVADA
						MemReg = 1'b0;//DESACTIVADA
						ALUOp =3'b001 ; //CODIFICACION
						MemWrite = 1'b1; //DESACTIVADA
						ALUScr =1'b1 ; //ACTIVADA
						RegWrite = 1'b1; //ACTIVADA
						AuipcLui = 2'b10; //datos del registros
		end 
		7'b0000011: //tipo I LOAD INMEDIATO tipo 2, REGWRITE ACTIVADA
		begin
						BRANCH= 1'b0; //DESACTIVADA
						MemRead = 1'b0; //ACTIVADA
						MemReg = 1'b1;//ACTIVADA
						ALUOp = 3'b010; //CODIFICACION
						MemWrite = 1'b1;//desACTIVADA
						ALUScr =1'b1 ; //ACTIVADA
						RegWrite = 1'b1; //ACTIVADA 
						AuipcLui = 2'b10; //datos del registros
		end
		7'b0100011: //tipo S
		begin
						BRANCH= 1'b0; //DESACTIVADA
						MemRead = 1'b0; //ACTIVADA
						MemReg = 1'b0;//ACTIVADA
						ALUOp = 3'b011; //CODIFICACION
						MemWrite = 1'b0; //ACTIVADA
						ALUScr =  1'b1; //ACTIVADA 
						RegWrite = 1'b0; //DESACTIVADA 
						AuipcLui = 2'b10;//datos del registros
		end 
		7'b1100011: //tipo B
		begin
						BRANCH= 1'b1; //ACTIVADA
						MemRead = 1'b1;//DESACTIVADA 
						MemReg = 1'b1;//DESACTIVADA
						ALUOp = 3'b100; //CODIFICACION
						MemWrite = 1'b1; //DESACTIVADA
						ALUScr =  1'b0; //DESACTIVADA 
						RegWrite = 1'b0; //DESACTIVADA 
						AuipcLui = 2'b10;//datos del registro
		end 	
		7'b0110111: //tipo U, lui
		begin
						BRANCH= 1'b0; //DESACTIVADA
						MemRead = 1'b1;//DESACTIVADA 
						MemReg = 1'b1;//DESACTIVADA
						ALUOp = 3'b101; //CODIFICACION
						MemWrite = 1'b1; //DESACTIVADA
						ALUScr =  1'b0; //DESACTIVADA 
						RegWrite = 1'b1; //ACTIVADA 
						AuipcLui = 2'b01;//ceros
		end 
		7'b0010111: //tipo U, auipc
		begin
						BRANCH= 1'b0; //DESACTIVADA
						MemRead = 1'b1;//DESACTIVADA 
						MemReg = 1'b1;//DESACTIVADA
						ALUOp = 3'b110; //CODIFICACION
						MemWrite = 1'b1; //DESACTIVADA
						ALUScr =  1'b0; //DESACTIVADA 
						RegWrite = 1'b1; //ACTIVADA 
						AuipcLui = 2'b00;//pc
		end 
		7'b1101111: //tipo J
		begin
						BRANCH= 1'b1; //ACTIVADA
						MemRead = 1'b1;//DESACTIVADA 
						MemReg = 1'b1;//DESACTIVADA
						ALUOp = 3'b111; //CODIFICACION
						MemWrite = 1'b1; //DESACTIVADA
						ALUScr =  1'b0; //DESACTIVADA 
						RegWrite = 1'b1; //ACTIVADA 
						AuipcLui = 2'b10;//datos del registro
		end 
		default: 
				begin
						BRANCH= 1'b0; //DESACTIVADA
						MemRead = 1'b1; //DESACTIVADA
						MemReg = 1'b1;//DESACTIVADA
						ALUOp = 3'b000 ; //CODIFICACION
						MemWrite = 1'b1; //DESACTIVADA
						ALUScr = 1'b0; //DESACTIVADA
						RegWrite = 1'b1; //ACTIVADA
						AuipcLui = 2'b10; // datos del registros
				end 
	endcase
end 

endmodule 