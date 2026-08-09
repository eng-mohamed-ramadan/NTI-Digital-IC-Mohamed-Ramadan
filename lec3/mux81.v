module top_module(
    input a1,
    input a2,
    input a3,
    input a4,
	input s1,
	input s2,
    output out

); 

assign out = (~s2 & ~s1 & a1) |(~s2 &  s1 & a2) |( s2 & ~s1 & a3) |( s2 & s1 & a4);

endmodule

/*module top_module(
    input a1,
    input a2,
    input a3,
    input a4,
    input s1,
    input s2,
    output out
);

always @(*)
begin
    if (~s2 && ~s1)
        out = a1;
    else if (~s2 && s1)
        out = a2;
    else if (s2 && ~s1)
        out = a3;
    else
        out = a4;
end

endmodule
*/