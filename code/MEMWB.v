module MEMWB(
  input clk,reset,
  input [63:0] read_data_in,
  input [63:0] result_alu_in, //2 bit 2by1 mux input b
  input [4:0]Rd_in, //EX MEM output
  input memtoreg_in, regwrite_in, //ex mem output as mem wb inputs
  output reg [63:0] readdata, //1bit
  output reg [63:0] result_alu_out,//1bit
  output reg [4:0] rd,
  output reg Memtoreg, Regwrite
);
  
  always @(posedge clk)
    begin
      if (reset == 1'b1)
        begin
          readdata = 63'b0;
          result_alu_out = 63'b0;
          rd = 5'b0;
          Memtoreg = 1'b0;
          Regwrite = 1'b0;
          
        end
      else
        begin
         readdata = read_data_in;
          result_alu_out = result_alu_in;
          rd = Rd_in;
          Memtoreg = memtoreg_in;
          Regwrite = regwrite_in;
        end
    end
endmodule


// module passes results from the Memory (MEM) stage to the Write-Back (WB) stage.
// What it stores, Data read from memory (read_data_in), ALU result (result_alu_in), Destination register (rd), Control signals for WB stage
// MemtoReg (choose between memory data or ALU result), RegWrite (enable writing to register file)

// On reset All stored values are set to 0, preventing invalid writes to registers.
// Normal operation: On every rising clock edge: Memory output is saved, ALU output is saved, Control signals and destination register are passed to WB