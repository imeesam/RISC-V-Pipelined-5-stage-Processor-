module pipeline_flush
  (
    input branch,
    output reg flush
  );
  
  initial
    begin
      flush = 1'b0;
    end
  
  always @(*)
    begin
      if (branch == 1'b1)
        flush = 1'b1;
      else
        flush = 1'b0;
    end
  
endmodule

// module generates a flush signal for the pipeline.
// a branch is taken (branch = 1) flush becomes 1 ? meaning invalidate/clear the next pipeline stage.
// If no branch, flush becomes 0.

// wrong-path instructions are removed from the pipeline after a branch decision