module top_module(
    input a,
    input b,
    input sel_b1,
    input sel_b2,
    output wire out_assign,
    output reg out_always  
	); 
	
	always @(*)
	begin
    if (sel_b1==1 &&sel_b2==1) 
	begin
        out_always = b;
    end
    else
	begin
        out_always = a;
    end
  end
 assign out_assign= out_always ;

endmodule