module ALU (A,B,CONTROL,RESULT,ZERO);

input signed [31:0] A,B;
input signed [3:0] CONTROL ;

output reg [31:0] RESULT;
output ZERO;

always @(*)
begin
	case(CONTROL)
	4'b0000: RESULT = A + B; //Suma       //aritmetica
	4'b0001: RESULT = A - B; //Resta
	4'b0010: RESULT = A & B; // AND       //logica
	4'b0011: RESULT = A | B; //OR
	4'b0100: RESULT = A ^ B; //XOR   
	4'b0101: RESULT = A < B; //Menor que  //comparador 
	4'b0110: RESULT = A <= B; //Menor igual que
	4'b0111: RESULT = A >= B; //Mayor igual que
	4'b1000: RESULT = A << B; //Desplazamiento izquierda  //desplazamiento
	4'b1001: RESULT = A >> B; //Desplazamiento derecha
	4'b1010: RESULT = !(A==B);  //BEQ
	4'b1001: RESULT = (A==B);  //BNE
	4'b1011: RESULT = !(A<B);  //BLT
	4'b1100: RESULT = (A<B); //BGE


	default: RESULT = A + B;
	endcase
end

assign ZERO = (RESULT==32'b0) ? 1'b1 : 1'b0;



endmodule 
