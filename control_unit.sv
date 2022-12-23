module control_unit(
  input wire [7:0] instruction,
  output wire [1:0] alu_op,
  output wire [3:0] rd_addr,
  output wire [3:0] wr_addr,
  output wire wr_enable
);
  reg [1:0] alu_op;
  reg [3:0] rd_addr;
  reg [3:0] wr_addr;
  reg wr_enable;

  // Decode the instruction and generate control signals
  always_comb begin
    // Extract the opcode and operand fields from the instruction
    case (instruction[7:4])
      4'b0000: begin
        alu_op = 2'b00; // AND
        rd_addr = instruction[3:0];
        wr_addr = instruction[3:0];
        wr_enable = 1'b1;
      end
      4'b0001: begin
        alu_op = 2'b01; // OR
        rd_addr = instruction[3:0];
        wr_addr = instruction[3:0];
        wr_enable = 1'b1;
      end
      4'b0010: begin
        alu_op = 2'b10; // ADD
        rd_addr = instruction[3:0];
        wr_addr = instruction[3:0];
        wr_enable = 1'b1;
      end
      4'b0011: begin
        alu_op = 2'b11; // SUB
        rd_addr = instruction[3:0];
        wr_addr = instruction[3:0];
        wr_enable = 1'b1;
      end
      4'b0100: begin
        rd_addr = instruction[3:0];
        wr_addr = instruction[3:0];
        wr_enable = 1'b0; // NOP
      end
      // Add additional opcodes as needed
    endcase
  end
endmodule
