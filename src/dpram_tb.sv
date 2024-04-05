`timescale 1ns/1ns

module dpram_testbench;
  logic clock;

  logic [7:0] write_address;
  logic [7:0] write_data;
  logic write;
  logic [7:0] read_address;
  wire [7:0] read_data;

  dpram dut(
    clock,
    write_address,
    write_data,
    write,
    read_address,
    read_data
  );

  always #5 clock = !clock;

  initial begin
    $dumpfile("dpram_tb.lx2");
    $dumpvars(0, dpram_testbench);

    clock <= 0;

    #1 write_address <= 0;
    write_data <= 0;
    write <= 0;
    read_address <= 0;

    #10 write <= 1;
    #9 write <= 0;
    #10 assert(read_data == 0);

    #4 write_data <= 'hff;
    write <= 1;
    #2 write <= 0;

    #1 assert(read_data == 'hff);

    #6 write_address <= 'h27;
    write_data <= 'hbb;
    #1 write <= 1;
    #1 write <= 0;

    #2 assert(read_data == 'hff);
    #1 read_address <= write_address;
    #1 assert(read_data == 'hbb);

    $finish;
  end


endmodule
