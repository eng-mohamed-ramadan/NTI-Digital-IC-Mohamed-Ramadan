module deecpder #(
parameter size=2
(
    input a,
    input b,
    input en,
    output reg [(1<<size)-1:0]f 
	); 
	
	
	always @(*)
	begin
	if(a==0&&b==0 &&en==1)   f=4'b0001;
	else if(a==1&&b==0&&en==1)   f=4'b0010;
	else if(a==0&&b==1&&en==1)   f=4'b0100;
	else  if(a==1&&b==1&&en==1)  f=4'b1000;
	else   f=4'b0000;
	end
	
	
	endmodule