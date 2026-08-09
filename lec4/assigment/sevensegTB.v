module sevensegTB;
    reg [3:0] num;
    wire[3:0]s; 
	 
	 sevenseg  tb(.num(num),.s(s));
	
	
	initial begin
	 num= 4'b0000;
	  #10;
	   num=4'b0001;
	  #10;
	    num=4'b0010;
	  #10;
	  num= 4'b0011;
	  #10;
	    num= 4'b0100;
	  #10;
	   num=4'b0101;
	  #10;
	     num=4'b0110;
	  #10;
	     num=4'b0111;
	  #10;
	     num=4'b1000;
	  #10;
	     num=4'b1001;
	  #10;
	    num=4'b1111;
	  #10;
	  $stop;
	end
	
	
	endmodule