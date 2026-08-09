`timescale 1ns/1ps
module clk_divider
 (
    input wire clkin,
    input wire reset,  
    output reg clkout
);
  // localparam COUNT_MAX = 25'd12499999;     //[0.5(clkin/clkout)]-1
  localparam [2:0] COUNT_MAX = 3'b101;
  
    reg [3:0] counter;
	
  always@(posedge clkin, negedge reset)
    begin
	 if(reset==0)
	     begin
            counter<=25'b0;
            clkout<=1'b0;			
		 end
	 else 
	     begin
            if(counter==COUNT_MAX)
				begin
				clkout=~clkout;
				counter=1'b0;
				end
			else 
			   counter<=counter+1'b1;
		 end
      
	end	
endmodule
