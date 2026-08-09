module blocking_vs_nonblocking_2 (
    input wire clk,
    input wire a,      
    output reg d
);
  reg b, c;
 /*
  always @(posedge clk)
	begin
	  d = c;
	  c = b;
	  b = a;
    end

  always @(posedge clk)
	begin
	  d = c;
	  c = b;
	  b = a;
	end
*//*
  always @(posedge clk)
	begin
	  b <=a;
	  c <=b;
	  d <=c;
	end
*/
  always @(posedge clk)
	begin
	  d <=c;
	  c <=b;
	  b <=a;
    end

endmodule