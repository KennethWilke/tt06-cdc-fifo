`timescale 1ns/1ns

module cdc_fifo_write_state
    #(parameter ADDRESS_WIDTH = 4) (
  input logic clock,
  input logic reset,
  input logic increment,
  input logic [ADDRESS_WIDTH-1:0] read_address_gray,

  output logic [ADDRESS_WIDTH-1:0] write_address,
  output logic [ADDRESS_WIDTH-1:0] write_address_gray,
  output logic full
);

  assign full = (write_address + 1 == read_address);

  logic [ADDRESS_WIDTH-1:0] read_address;

  gray_to_binary
      #(.WIDTH(4)) read_addr_decode (
    .gray(read_address_gray),
    .binary(read_address)
  );

  binary_to_gray
      #(.WIDTH(4)) write_addr_encode (
    .binary(write_address),
    .gray(write_address_gray)
  );

  always_ff @ (posedge clock or posedge reset) begin
    if (reset) begin
      write_address <= 0;
    end else if (increment & !full) begin
      write_address++;
    end
  end

endmodule
