
module EXMEM(
  input clk,reset,
  input [63:0] Adder_out, //adder output
  input [63:0] Result_in_alu,//64bit alu output
  input Zero_in,//64bit alu output
  input [63:0] writedata_in, //2 bit mux2by1 output
  input [4:0] Rd_in, //IDEX output
  input branch_in,memread_in,memtoreg_in,memwrite_in,regwrite_in, //IDEXX outputs
  input flush, 
  input addermuxselect_in,
  output reg [63:0] Adderout,
  output reg zero,
  output reg [63:0] result_out_alu,
  output reg [63:0] writedata_out,
  output reg [4:0]rd,
  output reg Branch,Memread,Memtoreg, Memwrite, Regwrite,
  output reg addermuxselect);
  
  always @ (posedge clk)
    begin
      if (reset == 1'b1 || flush == 1'b1)
        begin
          Adderout = 64'b0;
          zero = 1'b0;
          result_out_alu = 63'b0;
          writedata_out = 64'b0;
          rd = 5'b0;
          Branch = 1'b0;
          Memread = 1'b0;
          Memtoreg =1'b0;
          Memwrite = 1'b0;
          Regwrite = 1'b0;
          addermuxselect = 1'b0;
        end
      else
        begin
          Adderout = Adder_out;
          zero = Zero_in;
          result_out_alu = Result_in_alu;
          writedata_out = writedata_in;
          rd = Rd_in;
          Branch = branch_in;
          Memread = memread_in;
          Memtoreg = memtoreg_in;
          Memwrite = memwrite_in;
          Regwrite = regwrite_in;
          addermuxselect = addermuxselect_in;
        end
    end
endmodule

// This module stores all outputs from the Execute (EX) stage and passes them to the Memory (MEM) stage on each clock cycle.
// Branch target address (Adder_out), ALU result (Result_in_alu), Zero flag (for branch decision), Data to write to memory (writedata_in)
// Destination register (rd), Control signals needed in MEM stag ,Branch, MemRead, MemToReg, MemWrite, RegWrite, addermuxselect

// On reset or flush, All stored signals are cleared to 0. Prevents wrong execution after mispredicted branch or reset.
// Normal operation On each positive clock edge, it latches: ALU outputs, Branch info, Memory control signals, Register destination, Data to write to memory