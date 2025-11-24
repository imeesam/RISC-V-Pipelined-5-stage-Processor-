module IFID
  (
    input clk,
    input reset,
    input [31:0] instruction,
    input [63:0] A, //a
    input flush, 
    input IFIDWrite, 
    output reg [31:0] inst,//instruction out,
    output reg [63:0] a_out
  );
  always @(posedge clk)
    begin
      if (reset == 1'b1 || flush == 1'b1)
        begin
          inst = 32'b0;
          a_out = 64'b0;
        end
      else if (IFIDWrite == 1'b0)
        begin
          inst = instruction;
          a_out = A;
        end
    end
endmodule


// IF/ID module is a pipeline register that stores outputs from the Instruction Fetch (IF) stage and passes them to the Instruction Decode (ID) stage on the next clock.
// mainly holds: The fetched instruction , The incremented PC value (A), usually PC+4
// On reset or flush, Clears the stored instruction (inst = 0), Clears PC value (a_out = 0) , Prevents wrong instructions after branch misprediction or system reset.
// When IFIDWrite == 0 Latches the new instruction, Latches PC value, This is the normal operation. 
// IFIDWrite signal is used by the hazard detection unit to freeze/stall the pipeline.
// If a stall happens (IFIDWrite = 1), this register does not update, keeping the previous instruction.