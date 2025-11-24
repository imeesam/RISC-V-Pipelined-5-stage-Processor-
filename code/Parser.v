module Parser(
  input [31:0] instruction,
  output [6:0] opcode,
  output [4:0] rd,
  output [2:0] funct3,
  output [4:0] rs1,
  output [4:0] rs2,
  output [6:0] funct7
  );
  
  assign opcode = instruction[6:0];
  assign rd = instruction[11:7];
  assign funct3 = instruction[14:12];
  assign rs1 = instruction[19:15];
  assign rs2 = instruction[24:20];
  assign funct7 = instruction[31:25];
  
endmodule

// extracts all instruction fields from a 32-bit RISC-V instruction.
// splits the instruction into: 
// opcode ? bits [6:0]
// rd ? bits [11:7]
// funct3 ? bits [14:12]
// rs1 ? bits [19:15]
// rs2 ? bits [24:20]
// funct7 ? bits [31:25]
// decodes the raw instruction into its meaningful components so that the control unit, ALU control, register file, and immediate generator
