module top_module (
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
//module add1 ( input a, input b, input cin,   output sum, output cout );
  wire x;
    add16 ad1( .a   (a[15:0]), .b   (b[15:0]),.cin (0), .sum (sum[15:0]), .cout (x) );
			
    add16 ad2(.a   (a[31:16]),.b   (b[31:16]),.cin (x),.sum (sum[31:16]),.cout ());
endmodule
module add1
(
  input  wire a, 
  input  wire b,
  input  wire cin,
  
  output wire sum,
  output wire cout
);

  assign {cout, sum} = a + b + cin;  
  
endmodule