module blocking_vs_nonblocking (
    input wire a,
    input wire b,
    input wire c,
   //output reg m,
   // output reg n,
    output reg p,
    output reg q
);

 reg m, n;
 /*
  always @(a, b, c)
    begin
	  m = a;
	  n = b;
	  p = m + n;
	  m = c;
	  q = m + n;
	end
*/
  always @(a, b, c, m, n)
    begin
	  m <=a;
	  n <=b;
	  p <=m +n;
	  m <=c;
	  q <=m +n;
	end

endmodule

