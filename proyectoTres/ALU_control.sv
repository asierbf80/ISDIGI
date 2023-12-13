module ALU_control (instruction,ALUop,SEL);

input [31:0] instruction;
input [2:0] ALUop;
output logic[4:0] SEL;

logic [2:0] instruction1;
logic instruction2;
logic [6:0]variable; 

assign instruction1 = instruction [14:12];
assign instruction2 = instruction [30];

assign variable = {instruction1,instruction2,ALUop};

// las S son sumas y las B son restas

always_comb
	casex(variable)

	
// R-FORMAT
//     3 1 3
//    ( )|[ ]
	7'b0000000: SEL = 5'b00000; //add
	7'b0001000: SEL = 5'b00001; //sub
	7'b0010000: SEL = 5'b01000; //sll (desplazamienyo << izquierda)
	7'b0100000: SEL = 5'b00101; //slt  (menor que <)
	7'b0110000: SEL = 5'b00101; //sltu  (menor que <, pero sin signo)
	7'b1000000: SEL = 5'b00100; //xor
	7'b1010000: SEL = 5'b01001; //srl (desplazamienyo >> derecha)
	7'b1011000: SEL = 5'b01001; //sra (desplazamienyo >> derecha del bit mas significativo)  NO ESTA EN LA ALU!!! MIRARLO BIEN
	7'b1100000: SEL = 5'b00011; //or
	7'b1110000: SEL = 5'b00010; //and
	
// I-FORMAT inmediatas
//     3 1 3        
//    ( )|[ ]
	7'b000X001: SEL = 5'b00000; //addi
	7'b010X001: SEL = 5'b00101; //slti
	7'b011X001: SEL = 5'b01000; 
	7'b100X001: SEL = 5'b00100; //xori
	7'b110X001: SEL = 5'b00011; //ori
	7'b111X001: SEL = 5'b00010; //andi
	7'b0010001: SEL = 5'b01000; //slli
	7'b1010001: SEL = 5'b01001; //srli
	7'b1011001: SEL = 5'b01001; //srai
	
// I-FORMAT load    
//     3 1 3        
//    ( )|[ ]
	7'b000X010: SEL = 5'b00000; //lb
	7'b001X010: SEL = 5'b00000; //lh
	7'b010X010: SEL = 5'b00000; //lw
	7'b100X010: SEL = 5'b00000; //lbu
	7'b110X010: SEL = 5'b00000; //lhu

	
// S-FORMAT
//     3 1 3       
//    ( )|[ ]
	7'b000X011: SEL = 5'b00000; //sb
	7'b001X011: SEL = 5'b00000; //sh
	7'b010X011: SEL = 5'b00000; //sw
	

// B-FORMAT
//     3 1 3      
//    ( )|[ ]
	7'b000X100: SEL = 5'b00001; //BEQ
	7'b001X100: SEL = 5'b01010; //BNE
	7'b100X100: SEL = 5'b00001; //BLT  less than 
	7'b101X100: SEL = 5'b00001; //BGE  grader than or equal
	7'b110X100: SEL = 5'b00001; //BLTU  less than unsigned
	7'b111X100: SEL = 5'b00001; // BGEU grader or equal unsigned

// U-FORMAT lui
//     3 1 3      
//    ( )|[ ]
	7'bXXXX101: SEL = 5'b00001;  
	
	
// U-FORMAT auipc
//     3 1 3      
//    ( )|[ ]
	7'bXXXX110: SEL = 5'b00001; 
	//7'bXXXX100: SEL = 5'b00001; 

	
// J-FORMAT 
//     3 1 3      
//    ( )|[ ]
	7'bXXXX111: SEL = 5'b00001; 

	default: SEL = 5'b00000;
	
	endcase
	

endmodule
