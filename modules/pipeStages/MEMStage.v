`include "defines.v"

module MEMStage (clk, rst, MEM_R_EN, MEM_W_EN, ALU_res, ST_value, dataMem_out);
  input clk, rst, MEM_R_EN, MEM_W_EN;
  input [32-1:0] ALU_res, ST_value;
  output [32-1:0]  dataMem_out;

  dataMem dataMem (
    .clk(clk),
    .rst(rst),
    .writeEn(MEM_W_EN),
    .readEn(MEM_R_EN),
    .address(ALU_res),
    .dataIn(ST_value),
    .dataOut(dataMem_out)
  );
endmodule // MEMStage
