module CU(
  input [6:0] opcode,
  input stall, 
  
  output reg branch,
  output reg memread,
  output reg memtoreg,
  output reg memwrite,
  output reg aluSrc,
  output reg regwrite,
  output reg [1:0] Aluop);
  
  always @(*)
    begin
      
      if (opcode == 7'b0000011)
        begin
          aluSrc = 1'b1;
          memtoreg = 1'b1;
          regwrite = 1'b1;
          memread = 1'b1;
          memwrite = 1'b0;
          branch = 1'b0;
          Aluop =2'b00;
        end
      
      else if (opcode == 7'b0100011)
        begin
          aluSrc = 1'b1;
          memtoreg = 1'bx;
          regwrite = 1'b0;
          memread = 1'b0;
          memwrite = 1'b1;
          branch = 1'b0;
          Aluop =2'b00;
        end
      
      else if (opcode == 7'b0110011)
        begin
          aluSrc = 1'b0;
          memtoreg = 1'b0;
          regwrite = 1'b1;
          memread = 1'b0;
          memwrite = 1'b0;
          branch = 1'b0;
          Aluop =2'b10;
        end
      
      else if (opcode == 7'b1100011)
        begin
          aluSrc = 1'b0;
          memtoreg = 1'bx;
          regwrite = 1'b0;
          memread = 1'b0;
          memwrite = 1'b0;
          branch = 1'b1;
          Aluop =2'b01;
        end
      else if (opcode == 7'b0010011)
        begin
          aluSrc = 1'b1;
          memtoreg = 1'b0;
          regwrite = 1'b1;
          memread = 1'b0;
          memwrite = 1'b0;
          branch = 1'b0;
          Aluop =2'b00;
        end
      
      else //default case
        begin
          aluSrc = 1'b0;
          memtoreg = 1'b0;
          regwrite = 1'b0;
          memread = 1'b0;
          memwrite = 1'b0;
          branch = 1'b0;
          Aluop =2'b00;
        end
      
      if (stall == 1'b1)
        begin
          aluSrc = 1'b0;
          memtoreg = 1'b0;
          regwrite = 1'b0;
          memread = 1'b0;
          memwrite = 1'b0;
          branch = 1'b0;
          Aluop =2'b00;
        end
 
    end
endmodule



// takes opcode of the instruction and generates all the control signals
// supports 5 instruction types
// Load (opcode = 0000011) Uses immediate, Reads from memory, Writes result into register, ALU performs addition
// Store (opcode = 0100011) Uses immediate , Writes data to memory , ALU performs address calculation
// R-type (opcode = 0110011) Register?register operations, ALU controlled by ALU control (Aluop = 10) ,Writes to register
// Branch (opcode = 1100011) No write, ALU compares registers, Branch signal active
// I-type ALU (opcode = 0010011) Immediate ALU operation ,Writes to register
// If stall = 1, ALL control signals are forced to 0, effectively turning the instruction into a NOP to avoid hazards.
