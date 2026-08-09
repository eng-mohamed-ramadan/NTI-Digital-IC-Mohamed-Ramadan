module deecpdertb;
    reg a;
    reg b;
    reg en;
    wire[3:0]f; 
	 
	deecpder tb(.a(a),.b(b),.en(en),.f(f));
	
	
	initial begin
	  en=0; a=0;b=0;
	  #10;
	    en=0; a=1;b=1;
	  #10;
	    en=1; a=0;b=0;
	  #10;
	   en=1; a=1;b=0;
	  #10;
	   en=1; a=0;b=1;
	  #10;
	   en=1; a=1;b=1;
	  #10;
	  $stop;
	end
	
	
	endmodule