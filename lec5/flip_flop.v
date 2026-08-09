// Modeling seq. circuits
module d_ff
(
  input wire D,
  input wire clock,
  input wire reset,  // Active High reset
  output reg Q
);
  // Asynchronous, Active High reset
  // NBA for Seq & BA for combinational
  always@(posedge clock or posedge reset)
    begin
      if (reset)  Q <= 1'b0;  // Non-blocking assignment (NBA) vs (=) Blocking assignment (BA)
	  else        
	    begin
		  Q <= D;        // Evaluation of RHS & Assignment to LHS
		end
	end
/*
  // Synchronous reset, Active High reset
  // NBA for Seq & BA for combinational
  always@(posedge clock)
    begin
      if (reset)  Q <= 1'b0;  // Non-blocking assignment (NBA) vs (=) Blocking assignment (BA)
	  else        
	    begin
		  Q <= D;        // Evaluation of RHS & Assignment to LHS
		end
	end	
 
  // Asynchronous, Active low reset
  // NBA for Seq & BA for combinational
  always@(posedge clock or negedge reset)
    begin
      if (!reset)  Q <= 1'b0;  // Non-blocking assignment (NBA) vs (=) Blocking assignment (BA)
	  else        
	    begin
		  Q <= D;        // Evaluation of RHS & Assignment to LHS
		end
	end
 
  // Synchronous reset, Active low reset
  // NBA for Seq & BA for combinational
  always@(posedge clock)
    begin
      if (!reset)  Q <= 1'b0;  // Non-blocking assignment (NBA) vs (=) Blocking assignment (BA)
	  else        
	    begin
		  Q <= D;        // Evaluation of RHS & Assignment to LHS
		end
	end	
*/
endmodule