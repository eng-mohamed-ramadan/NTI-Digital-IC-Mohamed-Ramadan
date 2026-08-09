`timescale 1ns/1ps
module fsm_2seg_multi_seg_tb;
  reg a;
  reg b;
  reg clk;
  reg rst_n;
  wire y0;
  wire y1;
 
	fsm_2seg_multi_seg fsm (.*);
	 
	always #10 clk = ~clk;
	 
	initial begin
	  clk = 1'b0;
	  rst_n  = 1'b0; // Assign the delay >> Assign & wait for 10 ns
	  //#10; rst_n  = 1'b0; // Delay then assign >> wait for 10 ns After that assign
	  #12; 
      //@(negedge clk);	  
	  // rst_n  = #10 1'b0;
	  rst_n  = 1'b1;
	  {a, b} = 2'b11;
	  #10; // #45;
	 
	  {a, b} = 2'b10;
	  #15;
	 
	  {a, b} = 2'b01;
	  #20;
	 
	  {a, b} = 2'b10;
	  #20;
	 
	  {a, b} = 2'b11;
	  #45;
	 
	  #20; $stop;
	end
endmodule