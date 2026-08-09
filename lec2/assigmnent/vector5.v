module top_module (
    input a, b, c, d, e,
    output [24:0] out
	);

   
     assign out = ~{ a,a,a,a,a,b,b,b,b,b,c,c,c,c,c,d,d,d,d,d,e,e,e,e,e } ^ {a,b,c,d,e,a,b,c,d,e,a,b,c,d,e,a,b,c,d,e,a,b,c,d,e };

endmodule
