module CPU(
  input clk,
  input reset,
  input [31:0] instruction_memory[],
  output [31:0] regfile[32],
  output [31:0] pc
);

// internal signals
reg [31:0] pc;
reg [31:0] regfile[32];
wire [31:0] alu_result;
wire [4:0] next_pc;

// instantiate modules
ALU alu(.opcode(opcode), .a(a), .b(b), .result(alu_result), .next_pc(next_pc));
InstructionMemory imem(.clk(clk), .reset(reset), .pc(pc), .instruction(instruction));
ControlUnit cu(.opcode(opcode), .func3(func3), .func7(func7), .alu_op(alu_op), .branch_op(branch_op), .jump_op(jump_op));
RegisterFile rf(.read_reg_1(read_reg_1), .read_reg_2(read_reg_2), .write_reg(write_reg), .write_data(write_data), .regfile_out_1(regfile_out_1), .regfile_out_2(regfile_out_2), .regfile(regfile));

// main execution loop
always_ff @(posedge clk) begin
  if (reset) begin
    pc <= 0;
  end else begin
    // fetch instruction
    instruction <= instruction_memory[pc];
    opcode <= instruction[6:0];
    func3 <= instruction[14:12];
    func7 <= instruction[31:25];
    
    // decode instruction
    cu.decode();
    
    // read operands from register file
    rf.read();
    
    // execute instruction
    alu.execute();
    
    // write result to register file
    rf.write();
    
    // update program counter
    case (next_pc)
      PC_PLUS_4: pc <= pc + 4;
      PC_BRANCH: pc <= alu_result;
      PC_JALR: pc <= (regfile_out_1 + alu_result) & ~1;
      PC_JAL: pc <= alu_result;
    endcase
  end
end

endmodule
