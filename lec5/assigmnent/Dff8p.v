module top_module (
    input clk,
    input reset,
    input [7:0] d,
    output reg [7:0] q
);

  always@(negedge clk)
    begin
      if (reset)  q <= 8'b00110100;     //0x34
	  else        
	    begin
		  q <= d;
		end
	end	
endmodule
