`include "defines.v"

module register (clk, rst, writeEn, regIn, regOut);
  input clk, rst, writeEn;
  input [32-1:0] regIn;
  output reg [32-1:0] regOut;

  always @ (posedge clk) begin
    if (rst == 1) regOut <= 0;
    else if (writeEn) regOut <= regIn;
  end
endmodule // register
