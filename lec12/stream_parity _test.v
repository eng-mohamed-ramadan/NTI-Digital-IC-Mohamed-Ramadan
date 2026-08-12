`default_nettype none
`timescale 1ns/1ps

module stream_parity_tb;
parameter   size=8;
 
    reg clk;
    reg reset;
    reg s_in;
    wire p_out;

  integer  i;
  
  stream_parity #(.size(size)) 
  TB (.*);
  
 always #5 clk=~clk;
 
 initial begin
   clk=0;
   reset=0;
   #10;
   reset=1;
	   for(i=0;i<size;i=i+1)
	   begin
		 s_in=1'b1;
		  #10;
		  s_in=1'b0;
		  #10;
	   end
	 for(i=0;i<size;i=i+1)
	   begin
		 s_in=1'b1;
		  #10;
		  s_in=1'b1;
		 #10;
		  s_in=1'b0;
		  #10;
	   end
   $stop;
 end
   
endmodule









