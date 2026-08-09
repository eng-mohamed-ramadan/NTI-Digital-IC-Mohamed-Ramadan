`timescale 1ns / 1ps
module d_ff_tb;
  // TB signals
  reg D;
  reg clock;
  reg reset;  // Active High reset
  wire Q;
 
  d_ff D0
  (
    .D(D),
    .clock(clock),
    .reset(reset),  // Active High reset
    .Q(Q)
  );
 
   always  #10 clock=~clock;

  initial 
    begin
	 clock='b0;
	  D = 'b1;
	  reset = 'b0;

	  #15
	  reset = 'b1;
	  #3
	  reset = 'b0;
	  #10
	  D='b1;
	    #10
		$stop

	end
 
endmodule