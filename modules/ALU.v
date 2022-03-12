`include "defines.v"

module ALU (val1, val2, EXE_CMD, aluOut);
  input [32-1:0] val1, val2;
  input [4-1:0] EXE_CMD;
  output reg [32-1:0] aluOut;

  always @ ( * ) begin
    case (EXE_CMD)
      4'b0000: aluOut <= val1 + val2;
      4'b0010: aluOut <= val1 - val2;
      4'b0100: aluOut <= val1 & val2;
      4'b0101: aluOut <= val1 | val2;
      `EXE_NOR: aluOut <= ~(val1 | val2);
      `EXE_XOR: aluOut <= val1 ^ val2;
      `EXE_SLA: aluOut <= val1 << val2;
      `EXE_SLL: aluOut <= val1 <<< val2;
      `EXE_SRA: aluOut <= val1 >> val2;
      `EXE_SRL: aluOut <= val1 >>> val2;
      default: aluOut <= 0;
    endcase
  end
endmodule // ALU
