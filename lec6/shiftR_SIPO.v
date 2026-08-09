module shiftR_SIPO
#(parameter   size=4)
 (
    input clk,
    input reset,
    input sin,
    output reg [size-1:0]sout
);
  
  always@(posedge clk)
    begin
      if (reset)  sout<= {size{1'b0}};    
	  else        
	    begin
		 
		  sout<= {sin,(sout>>1)};
		end
	end	
endmodule
