
module halfadder
(
input wire A,B,
output wire out, 
output wire carry


);
assign out=A^B;
assign carry=A&B;


endmodule