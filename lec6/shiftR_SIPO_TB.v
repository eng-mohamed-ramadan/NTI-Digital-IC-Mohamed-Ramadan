`timescale 1ns / 1ps

module shiftR_SIPO_TB;

  localparam size=4;
   reg clk;
   reg reset;
    reg sin;
    wire [size-1:0]sout;
shiftR_SIPO
 #(
    .size ( size )
   )
   TB(.clk(clk),.reset(reset),.sin(sin),.sout(sout));
   always #5 clk=~clk;
    initial begin
     clk=1'b0;
	 #5;
	 sin=1'b1;
	  #5;
	   clk=1'b1; #5;
	   sin=1'b0; #5;
	   clk=1'b0; #5;
	   sin=1'b1; #5;
	   clk=1'b1; #5;
	   sin=1'b1; #5;
	   clk=1'b0; #5;
	   sin=1'b0; #5;
	 reset=1'b1; #5;
	 clk=1'b1; #5;
	 sin=1'b1; #5;
	   clk=1'b0; #5;
	  
    $stop;
  end

 
endmodule
