module alu(
  input wire [7:0] a,
  input wire [7:0] b,
  input wire [1:0] opcode,
  output wire [7:0] result,
  output wire zero,
  output wire carry,
  output wire overflow
);
  reg [7:0] result;
  reg zero;
  reg carry;
  reg overflow;

  // Define the operations that the ALU can perform
  always_comb begin
    case (opcode)
      2'b00: result = a & b;
      2'b01: result = a | b;
      2'b10: result = a + b;
      2'b11: result = a - b;
    endcase
  end

  // Check for zero and carry out
  always_ff @(posedge clock) begin
    if (result == 8'h00) begin
      zero <= 1'b1;
    end else begin
      zero <= 1'b0;
    end
    carry <= (result[7] & ~b[7] & ~a[7]) | (result[7] & b[7] & a[7]) | (a[7] & ~b[7] & ~result[7]);
    overflow <= (result[7] & ~b[7] & ~a[7]) | (~result[7] & b[7] & a[7]);
  end
endmodule
