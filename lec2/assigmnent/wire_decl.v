module top_module(
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n 
); 

	wire outand1;
	wire outand2;
	wire outor;
	
	
	  assign outand1=a&b;
	assign outand2=c&d;
	assign out=outand1|outand2;
   assign outor=outand1|outand2;
	assign out_n=~outor;
	
	
endmodule