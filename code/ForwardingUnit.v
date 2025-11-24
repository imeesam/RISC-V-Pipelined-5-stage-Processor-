module ForwardingUnit
  (
    input [4:0] RS_1, //ID/EX.RegisterRs1
    input [4:0] RS_2, //ID/EX.RegisterRs2
    input [4:0] rdMem, //EX/MEM.Register Rd
    input [4:0] rdWb, //MEM/WB.RegisterRd
    // flags
    input regWrite_Wb, //MEM/WB.RegWrite
    input regWrite_Mem, // EX/MEM.RegWrite

    output reg [1:0] Forward_A,
    output reg [1:0] Forward_B
 );
  
  always @(*)
    begin
    	if ( (rdMem == RS_1) & (regWrite_Mem != 0 & rdMem !=0))
          begin
          	Forward_A = 2'b10;
          end
      	else
          begin 
            // Not condition for MEM hazard 
            if ((rdWb== RS_1) & (regWrite_Wb != 0 & rdWb != 0) & ~((rdMem == RS_1) &(regWrite_Mem != 0 & rdMem !=0)  )  )
              begin
                Forward_A = 2'b01;
              end
            else
              begin
                Forward_A = 2'b00;
              end
          end
      
        if ( (rdMem == RS_2) & (regWrite_Mem != 0 & rdMem !=0) )
          begin
            Forward_B = 2'b10;
          end
        else
          begin
            // Not condition for MEM Hazard 
            if ( (rdWb == RS_2) & (regWrite_Wb != 0 & rdWb != 0) &  ~((regWrite_Mem != 0 & rdMem !=0 ) & (rdMem == RS_2) ) )
              begin
                Forward_B = 2'b01;
              end
            else
              begin
                Forward_B = 2'b00;
              end
          end
    end
endmodule

// logic 2
// EX Hazard (highest priority)
// If the EX/MEM destination register (rdMem) matches the current instruction?s source register (RS) and EX/MEM will write back
// Forward from EX/MEM stage (2'b10)

// MEM Hazard (lower priority)
// If MEM/WB destination register (rdWb) matches the source register (RS), and EX hazard is not already true,
// Forward from MEM/WB stage (2'b01)
// If none of these conditions match ? use register file normally (2'b00).
// Without forwarding, the ALU might read old/stale values, because the previous instruction hasn?t written them back yet.


// module detects data hazards in a pipelined processor and decides where the ALU should get its operands from to avoid stalls.
// Inputs
// RS_1, RS_2 ? source registers from ID/EX stage
// rdMem ? destination register from EX/MEM stage
// rdWb ? destination register from MEM/WB stage
// regWrite_Mem, regWrite_Wb ? indicate if those stages will write to registers
// outputs
// Forward_A ? controls where operand A for ALU comes from
// Forward_B ? controls where operand B comes from
// logic 
// forwarding based on hazard type
// EX hazard (prefer highest priority) If EX/MEM.rd == RS Forward from EX/MEM Forward = 2'b10
// MEM hazard (next priority) If MEM/WB.rd == RS (and EX hazard isn't there) Forward from MEM/WB Forward = 2'b01
//No hazard  Use normal register values Forward = 2'b00


