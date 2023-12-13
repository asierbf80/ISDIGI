module inm_gen(inst,inm);

input [31:0] inst;
output reg [31:0] inm;

logic [6:0]opcode;

assign opcode = inst[6:0];

always_comb
begin 
    case(opcode)
    7'b0110011: inm = 32'b0;   // tipo R
    7'b0010011: inm = {{20{inst[31]}},inst[31:20]};   // tipo I
    7'b0100011: inm = {{20{inst[31]}},inst[31:25],inst[11:7]};   // tipo S
    7'b1100011: inm = {{19{inst[31]}},inst[31],inst[7],inst[30:25],inst[11:8], 1'b0};   // tipo B
    7'b0110111 : inm = {{12{inst[31]}},inst[31:12]};   // tipo LUI
    7'b0010111 : inm = {{12{inst[31]}},inst[31:12]};   // tipo AUPIC
    //7'b1100111 : inm = {{20{inst[11]}},inst[11:0]};   // tipo JALR
    7'b1100111: inm = {{19{inst[31]}},inst[31:20]}; // tipo JALR
    // 7'b1101111 : // inm = {{11{inst[20]}},inst[20],inst[10:1],inst[11],inst[19:12],1'b0};   // tipo JAL
    7'b1101111 : inm = {{12{inst[31]}},inst[19:12],inst[20],inst[30:21],1'b0}; // tipo JAL
    default: inm = 32'b0;
    endcase 

end

endmodule 