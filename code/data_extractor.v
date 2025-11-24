module data_extractor
 (
    input [31:0] instruction,
    output reg [63:0] imm_data
  );
  
  always @(*)
    begin
      case (instruction[6:5])
       2'b00:
          begin
            imm_data[11:0] = instruction[31:20];
          end
        2'b01:
          begin
            imm_data[11:0] = {instruction[31:25], instruction[11:7]};
          end
        2'b11:
          begin
            imm_data[11:0] = {instruction[31], instruction[7], instruction[30:25], instruction[11:8]};
          end
      endcase
      imm_data = {{52{imm_data[11]}},{imm_data[11:0]}};
    end  
  
endmodule


// This module extracts the immediate value (imm_data) from a 32-bit RISC-V instruction. 
// I-type (instruction[6:5] = 00)
// S-type (instruction[6:5] = 01) 
// B-type (instruction[6:5] = 11) 
// Sign extension After extracting the 12-bit immediate, it sign-extends it to 64 bits:
