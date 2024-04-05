`timescale 1ns/1ns

module cdc_fifo_read_state
    #(parameter ADDRESS_WIDTH = 4) (
  input logic clock,
  input logic reset,
  input logic increment,
  input logic [ADDRESS_WIDTH-1:0] write_address_gray,

  output logic [ADDRESS_WIDTH-1:0] read_address,
  output logic [ADDRESS_WIDTH-1:0] read_address_gray,
  output logic empty
);

  logic [ADDRESS_WIDTH-1:0] write_address;

  gray_to_binary
      #(.WIDTH(4)) write_addr_decode (
    .gray(write_address_gray),
    .binary(write_address)
  );

  binary_to_gray
      #(.WIDTH(4)) read_addr_encode (
    .binary(read_address),
    .gray(read_address_gray)
  );

  assign empty = (write_address == read_address);

  always_ff @ (posedge clock or posedge reset) begin
    if (reset) begin
      read_address <= 0;
    end else if (increment & !empty) begin
      read_address++;
    end
  end

endmodule
