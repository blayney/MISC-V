module ControlUnit(
  input [6:0] opcode,
  input [2:0] func3,
  input [7:0] func7,
  output [4:0] alu_op,
  output branch_op,
  output jump_op
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
  alu_op = 0;
  branch_op = 0;
  jump_op = 0;
  case (opcode)
    // R-type instructions
    6'b0110011: begin
      alu_op = func3;
      case (func7)
        7'b0000000: alu_op = ALU_ADD;
        7'b0100000: alu_op = ALU_SUB;
        7'b0000000: alu_op = ALU_SLL;
        7'b0000000: alu_op = ALU_SLT;
        7'b0000000: alu_op = ALU_SLTU;
        7'b0000000: alu_op = ALU_XOR;
        7'b0000000: alu_op = ALU_SRL;
        7'b0100000: alu_op = ALU_SRA;
        7'b0000000: alu_op = ALU_OR;
        7'b0000000: alu_op = ALU_AND;
      endcase
    end
    // I-type instructions
    6'b0010011: alu_op = func3;
    // S-type instructions
    6'b0100011: alu_op = func3;
    // B-type instructions
    6'b1100011: branch_op = 1;
    // U-type instructions
    6'b0110111: jump_op = 1;
    6'b0010111: jump_op = 1;
  endcase
end

endmodule
