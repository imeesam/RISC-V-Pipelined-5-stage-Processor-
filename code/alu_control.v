
module alu_control(
  input [1:0] Aluop,
  input [3:0] funct,
  output reg [3:0] operation);
  
  always @ (*)
    begin
      if (Aluop==2'b01)
        begin
          operation = 4'b0110;
        end
      if (Aluop==2'b00)
        begin
          operation = 4'b0010;
        end
      if (Aluop==2'b10)
        begin
          if (funct == 4'b0000)
            begin
              operation = 4'b0010;
            end
          if (funct == 4'b0111)
            begin
              operation = 4'b0000;
            end
          if (funct == 4'b1000)
            begin
              operation = 4'b0110;
            end
          if (funct == 4'b0110)
            begin
              operation = 4'b0001;
            end
        end
    end
endmodule


// generates the specific ALU operation code based on, The ALUOp sent by the main Control Unit, The funct field from the instruction (funct3 + funct7 bits).
// ALUOp = 01 ? Branch instruction Set operation = 0110 (subtract)
// ALUOp = 00 ? Load/Store instruction,  Set operation = 0010 (add)
// ALUOp = 10 ? R-type instruction Use funct to choose: 0000 ? ADD 1000 ? SUB 0111 ? AND 0110 ? OR

