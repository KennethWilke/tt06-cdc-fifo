module synchronizer #(
  parameter WIDTH = 1
) (
  input logic clock,
  input logic reset,
  input logic [0:WIDTH-1] in,
  output logic [0:WIDTH-1] out);

  logic [0:WIDTH-1] data;

  always_ff @ (posedge clock or posedge reset) begin
    if (reset) begin
        out <= 0;
        data <= 0;
    end else begin
        out <= data;
        {out, data} <= {data, in};
    end
  end
endmodule
