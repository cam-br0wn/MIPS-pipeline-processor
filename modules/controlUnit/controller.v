`include "defines.v"

module controller (opCode, branchEn, EXE_CMD, Branch_command, Is_Imm, ST_or_BNE, WB_EN, MEM_R_EN, MEM_W_EN, hazard_detected);
  input hazard_detected;
  input [6-1:0] opCode;
  output reg branchEn;
  output reg [4-1:0] EXE_CMD;
  output reg [1:0] Branch_command;
  output reg Is_Imm, ST_or_BNE, WB_EN, MEM_R_EN, MEM_W_EN;

  always @ ( * ) begin
    if (hazard_detected == 0) begin
      {branchEn, EXE_CMD, Branch_command, Is_Imm, ST_or_BNE, WB_EN, MEM_R_EN, MEM_W_EN} <= 0;
      case (opCode)
        // operations writing to the register file
        6'b000001: begin EXE_CMD <= 4'b0000; WB_EN <= 1; end
        6'b000011: begin EXE_CMD <= 4'b0010; WB_EN <= 1; end
        6'b000101: begin EXE_CMD <= 4'b0100; WB_EN <= 1; end
        6'b000110:  begin EXE_CMD <= 4'b0101;  WB_EN <= 1; end
        6'b000111: begin EXE_CMD <= `EXE_NOR; WB_EN <= 1; end
        6'b000111: begin EXE_CMD <= `EXE_XOR; WB_EN <= 1; end
        6'b001001: begin EXE_CMD <= `EXE_SLA; WB_EN <= 1; end
        6'b001010: begin EXE_CMD <= `EXE_SLL; WB_EN <= 1; end
        6'b001011: begin EXE_CMD <= `EXE_SRA; WB_EN <= 1; end
        6'b001100: begin EXE_CMD <= `EXE_SRL; WB_EN <= 1; end
        // operations using an immediate value embedded in the instruction
        6'b100000: begin EXE_CMD <= 4'b0000; WB_EN <= 1; Is_Imm <= 1; end
        6'b100001: begin EXE_CMD <= 4'b0010; WB_EN <= 1; Is_Imm <= 1; end
        // memory operations
        6'b100100: begin EXE_CMD <= 4'b0000; WB_EN <= 1; Is_Imm <= 1; ST_or_BNE <= 1; MEM_R_EN <= 1; end
        6'b100101: begin EXE_CMD <= 4'b0000; Is_Imm <= 1; MEM_W_EN <= 1; ST_or_BNE <= 1; end
        // branch operations
        6'b101000: begin EXE_CMD <= `EXE_NO_OPERATION; Is_Imm <= 1; Branch_command <= `COND_BEZ; branchEn <= 1; end
        6'b101001: begin EXE_CMD <= `EXE_NO_OPERATION; Is_Imm <= 1; Branch_command <= `COND_BNE; branchEn <= 1; ST_or_BNE <= 1; end
        6'b101010: begin EXE_CMD <= `EXE_NO_OPERATION; Is_Imm <= 1; Branch_command <= `COND_JUMP; branchEn <= 1; end
        default: {branchEn, EXE_CMD, Branch_command, Is_Imm, ST_or_BNE, WB_EN, MEM_R_EN, MEM_W_EN} <= 0;
      endcase
    end

    else if (hazard_detected ==  1) begin
      // preventing any writes to the register file or the memory
      {EXE_CMD, WB_EN, MEM_W_EN} <= 0;
    end
  end
endmodule // controller
