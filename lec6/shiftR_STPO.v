module shiftR_SIPO
#(parameter   size=4)
 (
    input clk,
    input reset,
    input sin,
    output reg [size-1:0]sout
);
  //reg[2:0]  s.shift;
  always@(posedge clk, negedge clk)
    begin
      if (reset)  sout<= {size{1'b0}};    
	  else        
	    begin
		 //1101
		// s.shift<=(sout>>1);
		  sout<= (sin<<3)|(sout>>1); //sout[size-1:1]
		end
	end	
endmodule
