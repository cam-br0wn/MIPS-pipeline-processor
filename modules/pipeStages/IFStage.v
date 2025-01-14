`include "defines.v"

module IFStage (clk, rst, brTaken, brOffset, freeze, PC, instruction);
  input clk, rst, brTaken, freeze;
  input [32-1:0] brOffset;
  output [32-1:0] PC, instruction;

  wire [32-1:0] adderIn1, adderOut, brOffserTimes4;

  mux #(.LENGTH(32)) adderInput (
    .in1(32'd4),
    .in2(brOffserTimes4),
    .sel(brTaken),
    .out(adderIn1)
  );

  adder add4 (
    .in1(adderIn1),
    .in2(PC),
    .out(adderOut)
  );

  register PCReg (
    .clk(clk),
    .rst(rst),
    .writeEn(~freeze),
    .regIn(adderOut),
    .regOut(PC)
  );

  instructionMem instructions (
    .rst(rst),
    .addr(PC),
    .instruction(instruction)
  );

  assign brOffserTimes4 = brOffset << 2;
endmodule // IFStage
