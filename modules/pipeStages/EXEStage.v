`include "defines.v"

module EXEStage (clk, EXE_CMD, val1_sel, val2_sel, ST_val_sel, val1, val2, ALU_res_MEM, result_WB, ST_value_in, ALUResult, ST_value_out);
  input clk;
  input [2-1:0] val1_sel, val2_sel, ST_val_sel;
  input [4-1:0] EXE_CMD;
  input [32-1:0] val1, val2, ALU_res_MEM, result_WB, ST_value_in;
  output [32-1:0] ALUResult, ST_value_out;

  wire [32-1:0] ALU_val1, ALU_val2;

  mux_3input #(.LENGTH(32)) mux_val1 (
    .in1(val1),
    .in2(ALU_res_MEM),
    .in3(result_WB),
    .sel(val1_sel),
    .out(ALU_val1)
  );

  mux_3input #(.LENGTH(32)) mux_val2 (
    .in1(val2),
    .in2(ALU_res_MEM),
    .in3(result_WB),
    .sel(val2_sel),
    .out(ALU_val2)
  );

  mux_3input #(.LENGTH(32)) mux_ST_value (
    .in1(ST_value_in),
    .in2(ALU_res_MEM),
    .in3(result_WB),
    .sel(ST_val_sel),
    .out(ST_value_out)
  );

  ALU ALU(
    .val1(ALU_val1),
    .val2(ALU_val2),
    .EXE_CMD(EXE_CMD),
    .aluOut(ALUResult)
  );
endmodule // EXEStage
