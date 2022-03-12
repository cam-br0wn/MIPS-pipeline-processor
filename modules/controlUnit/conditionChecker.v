`include "defines.v"

module conditionChecker (reg1, reg2, cuBranchComm, brCond);
  input [31: 0] reg1, reg2;
  input [1:0] cuBranchComm;
  output reg brCond;

  always @ ( * ) begin
    case (cuBranchComm)
      2: brCond <= 1;
      3: brCond <= (reg1 == 0) ? 1 : 0;
      1: brCond <= (reg1 != reg2) ? 1 : 0;
      default: brCond <= 0;
    endcase
  end
endmodule // conditionChecker
