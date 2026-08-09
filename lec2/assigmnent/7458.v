module top_module 
( 
    input wire p1a, p1b, p1c, p1d, p1e, p1f,
    output wire p1y,
    input wire p2a, p2b, p2c, p2d,
    output wire p2y 
);

	wire outin1;
	wire outin2;
	wire outin3;
	wire outin4;
	
	
	and  and1(outin1,p2a,p2b);
	and  and2(outin2,p2c,p2d);
	and  and3(outin3,p1f,p1e,p1d);
	and  and4(outin4,p1a,p1b,p1c);
	
	
	or or1(p2y,outin1,outin2);
	or or2(p1y,outin3,outin4);
endmodule