module CORE(reset, clk, datos_IMEM, datos_DMEM, dir_IMEM, dir_DMEM, w_DMEM, read_write);

input reset, clk; 
input [31:0] datos_IMEM, datos_DMEM; 
output [31:0] w_DMEM; 
output logic read_write;
output logic [31:0] dir_IMEM, dir_DMEM;

logic [31:0] pc_in,pc_out;


//cables ALU
logic [31:0] a, b; 
logic [3:0] sel; 
logic zero; 

//cables inm_gen 
logic [31:0] inm_gen; 

//cables control
logic [6:0] OPCODE; 
logic BRANCH, MemRead, MemReg; 
logic [2:0] ALUop_mux; 
logic MemWrite, ALUScr, RegWrite; 
logic [1:0] AuipcLui; 

//cables ALU_control
logic [3:0] control_inst; 

//cables registros
logic [31:0] data_wr, rd1_mux, rd2_mux;

logic [31:0] result; 

assign dir_DMEM = result; 
assign rd2_mux = w_DMEM; 

//señal de lectura/escritura RAM 
//cambiar para segmentacion 
assign read_write = MemWrite;

//instanciaciones
ALU duv_alu (
	.A(a),
	.B(b),
	.CONTROL(sel),
	.RESULT(result),
	.ZERO(zero)
); 

inm_gen duv_inm_gen (
	.inst(datos_IMEM),
	.inm(inm_gen)
);


control duv_control (
	.OPCODE(datos_IMEM[6:0]), 
	.BRANCH(BRANCH), 
	.MemRead(MemRead), 
	.MemReg(MemReg), 
	.ALUOp(ALUop_mux), 
	.MemWrite(MemWrite), 
	.ALUScr(ALUScr), 
	.RegWrite(RegWrite), 
	.AuipcLui(AuipcLui)
);
//duda conexiones
ALU_control duv_ALU_control (
	.instruction(datos_IMEM[30|14:12]),
	.ALUop(ALUop_mux),
	.SEL(sel)
);

banco_registros duv_banco_registros(
	.clock(clk),
	.reset(reset),
	.read_register_1(datos_IMEM[19:15]),
	.read_register_2(datos_IMEM[24:20]),
	.write_register(datos_IMEM[11:7]),
	.write_data(data_wr),
	.reg_write(RegWrite),
	.read_data_1(rd1_mux),
	.read_data_2(w_DMEM)
);
//PC

assign dir_IMEM= pc_out;

always_ff @(posedge clk or negedge reset)
	if(!reset)
		pc_out = 1'b0; 
	else 
		pc_out = pc_in; 
		

//multiplexores

assign data_wr = (MemReg == 1'b1) ? datos_DMEM : result;  

assign b = (ALUScr == 1'b0) ? rd2_mux : inm_gen; 

always_comb 
case(AuipcLui)
	2'b00: a = pc_out; 
	2'b01: a = 32'b0; 
	2'b10: a = rd1_mux; 
	default: a = pc_out;	
endcase			

//sumadores
assign pc_in = ((BRANCH & zero) == 1'b0) ? (pc_out +1) : (pc_out + inm_gen);

endmodule 



 