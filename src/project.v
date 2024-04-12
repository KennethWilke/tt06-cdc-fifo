/*
 * Copyright (c) 2024 Kenneth Wilke
 * SPDX-License-Identifier: Apache-2.0
 */

`define default_netname none

module tt_um_kwilke_cdc_fifo (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // ui_in mappings
  wire write_clock, write_increment, read_clock, read_increment;
  wire [3:0] write_data;
  assign write_clock = ui_in[0],
    write_increment = ui_in[1],
    read_clock = ui_in[2],
    read_increment = ui_in[3],
    write_data = ui_in[7:4];

  // uo_out mappings
  wire empty, full;
  wire [3:0] read_data;
  assign uo_out[0] = empty,
    uo_out[1] = full,
    uo_out[3:2] = 'b00,
    uo_out[7:4] = read_data;

  // uio_out mapping
  wire write_reset, read_reset;
  assign write_reset = !uio_in[0],
    read_reset = !uio_in[1];

  // The FIFO! May it live forever in silicon!
  cdc_fifo #(
    .DATA_WIDTH(4),
    .ADDRESS_WIDTH(5)
  ) kwilke_fifo (
    .write_clock(write_clock),
    .write_reset(write_reset),
    .write_data(write_data),
    .write_increment(write_increment),
    .full(full),

    .read_clock(read_clock),
    .read_reset(read_reset),
    .read_increment(read_increment),
    .read_data(read_data),
    .empty(empty)
  );

  // All output pins must be assigned. If not used, assign to 0.
  assign uio_out = 0;
  assign uio_oe  = 0;

endmodule
