`timescale 1ns/1ns

module synchronizer
    #(parameter WIDTH = 1,
      parameter DEPTH = 1) (
  input logic clock,
  input logic reset,
  input logic [0:WIDTH-1] in,
  output logic [0:WIDTH-1] out);

  logic [0:DEPTH-1][0:WIDTH-1] data;

  always_ff @ (posedge clock or posedge reset) begin
    if (reset) begin
        out <= 0;
        for (int i = 0; i < DEPTH; i++) begin
            data[i] <= 0;
        end
    end else begin
        {out, data} <= {data, in};
    end
  end
endmodule
