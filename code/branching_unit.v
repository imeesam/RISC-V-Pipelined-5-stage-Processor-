module branching_unit
  (
   input [2:0] funct3,
    input [63:0] readData1,
    input [63:0] b,
   output reg addermuxselect
  );
  
  initial
    begin
      addermuxselect = 1'b0;
    end
  
  always @(*)
	begin
      case (funct3)
        3'b000:
          begin
            if (readData1 == b)
              addermuxselect = 1'b1;
            else
              addermuxselect = 1'b0;
            end
         3'b100:
    		begin
              if (readData1 < b)
              addermuxselect = 1'b1;
            else
              addermuxselect = 1'b0;
            end
        3'b101:
          begin
            if (readData1 > b)
          	addermuxselect = 1'b1;
           else
              addermuxselect = 1'b0;
          end    
      endcase
     end
endmodule

// a branch should be taken based on a branch instruction.
// funct3 ? branch type (BEQ, BLT, BGT, etc.)
// readData1 ? value from first register
// b ? value from second register 

//BEQ (funct3 = 000): branch if readData1 == b
// BLT (funct3 = 100): branch if readData1 < b
//BGT (funct3 = 101): branch if readData1 > b 

// addermuxselect = 1 ? branch taken, addermuxselect = 0 ? branch not taken
// program counter to jump to the correct target when a branch condition is true