`default_nettype none
`timescale 1ns/1ps

module stream_parity
#(parameter   size=8)
 (
    input wire clk,
    input wire reset,
    input wire s_in,
    output reg p_out
);

  reg [size-1:0] s_shift;
  
  
  function parity
        (input  [size-1:0]data);
		begin
		 parity=^data;
		end
	endfunction 
  
  always@(posedge clk, negedge reset)
    begin
      if (~reset)
	  begin 
	    s_shift<= {size{1'b0}}; 
	    p_out=1'b0;
	  end
    	  
	  else        
	    begin
		
		 s_shift<={ s_shift[size-2:0], s_in};
		 p_out<= ({s_shift[size-2:0],s_in});
		end
	end	
endmodule









