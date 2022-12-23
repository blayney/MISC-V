module InstructionMemory(
  input clk,
  input reset,
  output [31:0] pc,
  output [31:0] instruction
);

always_ff @(posedge clk) begin
  if (reset) begin
    pc <= 0;
  end else begin
    pc <= pc + 4;
  end
end

endmodule

module RegisterFile(
  input [4:0] read_reg_1,
  input [4:0] read_reg_2,
  input [4:0] write_reg,
  input [31:0] write_data,
  output [31:0] regfile_out_1,
  output [31:0] regfile_out_2,
  output [31:0] regfile[32]
);

reg [31:0] regfile[32];

// read registers
always_comb begin
  regfile_out_1 = regfile[read_reg_1];
  regfile_out_2 = regfile[read_reg_2];
end

// write register
always_ff @(posedge clk) begin
  regfile[write_reg] <= write_data;
end

endmodule
