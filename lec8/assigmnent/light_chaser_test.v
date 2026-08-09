`timescale 1ns/1ps
module light_chaser_test;

reg   clk;
reg   reset; 
reg   hold;  
wire [3:0]sout;



light_chaser  TB(.clk(clk),.reset(reset),.hold(hold),.sout(sout));

always #10 clk=~clk;
     
    initial begin
	  reset=0; 
	  clk=0;
	 #50;
     hold=0;
     #10;
     hold=1; 
  	 #10;
     reset=0; 
	 #10;
	 reset=1;
	
  #100
 $stop
 
 
    end
	
	
	
endmodule