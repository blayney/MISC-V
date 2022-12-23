module ALU(
  input [4:0] opcode,
  input [31:0] a,
  input [31:0] b,
  output [31:0] result,
  output [4:0] next_pc
);
    parameter ALU_ADD = 5'b00000;
    parameter ALU_SUB = 5'b01000;
    parameter ALU_AND = 5'b00001;
    parameter ALU_OR  = 5'b00010;
    parameter ALU_XOR = 5'b00011;
    parameter ALU_SLT = 5'b01011;
    parameter ALU_SLTU = 5'b01010;
    parameter ALU_SLL = 5'b00101;
    parameter ALU_SRL = 5'b00110;
    parameter ALU_SRA = 5'b00111;
    parameter PC_PLUS_4 = 5'b00000;
    parameter PC_BRANCH = 5'b00100;
    parameter PC_JALR = 5'b00101;
    parameter PC_JAL = 5'b00110;

    always_comb begin
    case (opcode)
        ALU_ADD: result = a + b; next_pc = PC_PLUS_4;
        ALU_SUB: result = a - b; next_pc = PC_PLUS_4;
        ALU_AND: result = a & b; next_pc = PC_PLUS_4;
        ALU_OR:  result = a | b; next_pc = PC_PLUS_4;
        ALU_XOR: result = a ^ b; next_pc = PC_PLUS_4;
        ALU_SLT: result = (a < b) ? 1 : 0; next_pc = PC_PLUS_4;
        ALU_SLTU: result = (a < b) ? 1 : 0; next_pc = PC_PLUS_4;
        ALU_SLL: result = a << b[4:0]; next_pc = PC_PLUS_4;
        ALU_SRL: result = a >> b[4:0]; next_pc = PC_PLUS_4;
        ALU_SRA: result = a >> b[4:0]; next_pc = PC_PLUS_4;
        PC_BRANCH: result = a; next_pc = PC_BRANCH;
        PC_JALR: result = a; next_pc = PC_JALR;
        PC_JAL: result = a; next_pc = PC_JAL;
        default: result = 0; next_pc = PC_PLUS_4;
    endcase
    end
endmodule