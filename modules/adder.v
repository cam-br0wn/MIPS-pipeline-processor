`include "defines.v"

module adder (in1, in2, out);
  input [32-1:0] in1, in2;
  output [32-1:0] out;

  assign out = in1 + in2;
endmodule // adder
