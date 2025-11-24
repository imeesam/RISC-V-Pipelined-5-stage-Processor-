module program_counter(
  input [63:0] PC_in,
  input clk,
  input reset,
  input stall, 
  output reg [63:0] PC_out);


// On reset: Sets PC_out to 0 This makes the processor start executing from address 0.
// On each clock edge (posedge clk):
// If stall = 0, the PC updates normally using PC_in.
// If stall = 1, the PC holds its current value (does not update).
  
  always @(posedge clk or posedge reset)
    begin
      if (reset==1'b1)
        begin        
          PC_out = 64'd0;
        end
      else if (stall == 1'b0) 
        begin 
          PC_out = PC_in;
        end
    end
endmodule