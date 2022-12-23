module cpu(
  input wire clock,
  input wire reset,
  input wire [7:0] instruction,
  output wire [7:0] result,
  output wire zero,
  output wire carry,
  output wire overflow
);
  reg [15:0] pc; // Program counter
  reg [7:0] a; // Register A
  reg [7:0] b; // Register B
  wire [1:0] alu_op;
  wire [3:0] rd_addr;
  wire [3:0] wr_addr;
  wire wr_enable;

  // Instantiate the register file, instruction memory, ALU, and control unit
  register_file regfile(.clock(clock), .rd_addr(rd_addr), .wr_addr(wr_addr), .wr_data(result), .wr_enable(wr_enable), .rd_data(b));
  instruction_memory imem(.address(pc), .instruction(instruction));
  alu alu(.a(a), .b(b), .opcode(alu_op), .result(result), .zero(zero), .carry(carry), .overflow(overflow));
  control_unit cu(.instruction(instruction), .alu_op(alu_op), .rd_addr(rd_addr), .wr_addr(wr_addr), .wr_enable(wr_enable));

  // Fetch-decode-execute cycle
  always_ff @(posedge clock or posedge reset) begin
    if (reset) begin
      // Initialize PC to 0 on reset
      pc <= 16'h0000;
    end else begin
      // Fetch instruction
      pc <= pc + 1;
      // Decode instruction
      a <= regfile.rd_data;
      // Execute instruction
      regfile.wr_data <= result;
    end
  end
endmodule
