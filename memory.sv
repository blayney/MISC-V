module instruction_memory(
  input wire [15:0] address,
  output wire [7:0] instruction
);
  reg [7:0] mem[255:0]; // 256 8-bit instruction memory locations

  always_ff @(posedge clock) begin
    instruction <= mem[address];
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
