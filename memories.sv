module InstructionMemory(
  input clk,
  input reset,
  output [31:0] pc,
  output [31:0] instruction
);

reg [31:0] pc;
reg [31:0] instruction;

always_ff @(posedge clk) begin
  if (reset) begin
    pc <= 0;
  end else begin
    pc <= pc + 4;
  end
end

endmodule

module register_file(
  input wire [3:0] rd_addr,
  input wire [3:0] wr_addr,
  input wire [7:0] wr_data,
  input wire wr_enable,
  output wire [7:0] rd_data
);
  reg [7:0] regs[15:0]; // 16 8-bit registers

  always_ff @(posedge clock) begin
    if (wr_enable) begin
      regs[wr_addr] <= wr_data;
    end
    rd_data <= regs[rd_addr];
  end
endmodule
