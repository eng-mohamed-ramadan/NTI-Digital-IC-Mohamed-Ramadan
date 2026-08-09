`default_nettype none
module cloc_div 
#(parameter DIV_RATIO = 10)
(
  input wire i_cloc_div_clock_in,  //Direction(I/O)_Module Name_ signal or port name 
  input wire i_cloc_div_reset_n,
  output reg o_cloc_div_clock_out
);
  
  localparam WIDTH = $clog2(DIV_RATIO);
  
  reg [WIDTH-1 : 0] counter; //3:0

  always@(posedge i_cloc_div_clock_in or negedge i_cloc_div_reset_n)
    begin
	  if(!i_cloc_div_reset_n)
	    begin
		  counter <= {WIDTH{1'b0}};
		  o_cloc_div_clock_out <= 1'b0;
		end
	  else 
	    begin
		  if(counter == ((DIV_RATIO/2)-1) )
		    begin
		      counter <= {WIDTH{1'b0}};
		      o_cloc_div_clock_out <= ~o_cloc_div_clock_out;			  
			end
		  else 
		    counter <= counter + 1'b1;
		end
	end

endmodule