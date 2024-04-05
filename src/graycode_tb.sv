`timescale 1ns/1ns

module testbench();

  logic [3:0] gray_decode;
  logic [3:0] binary_decode;
  gray_to_binary #(4) dut_decode(gray_decode, binary_decode);

  logic [3:0] binary_encode;
  logic [3:0] gray_encode;
  binary_to_gray #(4) dut_encode(binary_encode, gray_encode);

  initial begin
    gray_decode <= 4'b0000;
    #1 assert(binary_decode == 4'b0000);
    #1 gray_decode <= 4'b0001;
    #1 assert(binary_decode == 4'b0001);
    #1 gray_decode <= 4'b0010;
    #1 assert(binary_decode == 4'b0011);
    #1 gray_decode <= 4'b0011;
    #1 assert(binary_decode == 4'b0010);
    #1 gray_decode <= 4'b0100;
    #1 assert(binary_decode == 4'b0111);
    #1 gray_decode <= 4'b0101;
    #1 assert(binary_decode == 4'b0110);
    #1 gray_decode <= 4'b0110;
    #1 assert(binary_decode == 4'b0100);
    #1 gray_decode <= 4'b0111;
    #1 assert(binary_decode == 4'b0101);
    #1 gray_decode <= 4'b1000;
    #1 assert(binary_decode == 4'b1111);
    #1 gray_decode <= 4'b1001;
    #1 assert(binary_decode == 4'b1110);
    #1 gray_decode <= 4'b1010;
    #1 assert(binary_decode == 4'b1100);
    #1 gray_decode <= 4'b1011;
    #1 assert(binary_decode == 4'b1101);
    #1 gray_decode <= 4'b1100;
    #1 assert(binary_decode == 4'b1000);
    #1 gray_decode <= 4'b1101;
    #1 assert(binary_decode == 4'b1001);
    #1 gray_decode <= 4'b1110;
    #1 assert(binary_decode == 4'b1011);
    #1 gray_decode <= 4'b1111;
    #1 assert(binary_decode == 4'b1010);

    #1 binary_encode <= 4'b0000;
    #1 assert(gray_encode == 4'b0000);
    #1 binary_encode <= 4'b0001;
    #1 assert(gray_encode == 4'b0001);
    #1 binary_encode <= 4'b0010;
    #1 assert(gray_encode == 4'b0011);
    #1 binary_encode <= 4'b0011;
    #1 assert(gray_encode == 4'b0010);
    #1 binary_encode <= 4'b0100;
    #1 assert(gray_encode == 4'b0110);
    #1 binary_encode <= 4'b0101;
    #1 assert(gray_encode == 4'b0111);
    #1 binary_encode <= 4'b0110;
    #1 assert(gray_encode == 4'b0101);
    #1 binary_encode <= 4'b0111;
    #1 assert(gray_encode == 4'b0100);
    #1 binary_encode <= 4'b1000;
    #1 assert(gray_encode == 4'b1100);
    #1 binary_encode <= 4'b1001;
    #1 assert(gray_encode == 4'b1101);
    #1 binary_encode <= 4'b1010;
    #1 assert(gray_encode == 4'b1111);
    #1 binary_encode <= 4'b1011;
    #1 assert(gray_encode == 4'b1110);
    #1 binary_encode <= 4'b1100;
    #1 assert(gray_encode == 4'b1010);
    #1 binary_encode <= 4'b1101;
    #1 assert(gray_encode == 4'b1011);
    #1 binary_encode <= 4'b1110;
    #1 assert(gray_encode == 4'b1001);
    #1 binary_encode <= 4'b1111;
    #1 assert(gray_encode == 4'b1000);
    #1 $finish();
  end

endmodule
