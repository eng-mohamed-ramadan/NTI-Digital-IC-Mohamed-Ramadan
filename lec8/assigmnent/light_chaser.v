`timescale 1ns/1ps
module light_chaser
 (
    input wire clk,
    input wire reset,  
	 input wire hold,  
    output reg [3:0]sout
);
       
  wire new_clk;
    clk_divider  TB(.clkin(clk),.reset(reset),.clkout(new_clk));
	  
  always@(posedge new_clk, negedge reset)
    begin
	if(reset==0)    sout<=4'b1011;
	else if(hold==0)   sout<=sout;
	else 
	   begin
	   sout<=(sout>>1)|(sout<<3);
	   
	   
	   end
	end	
endmodule
