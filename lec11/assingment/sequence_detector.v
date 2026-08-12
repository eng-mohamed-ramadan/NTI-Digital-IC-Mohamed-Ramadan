`default_nettype none
module sequence_detector_test;

  reg clk;
  reg  rst_n;
  reg a;
  wire y;

moore_nonover110101 TB1 (.*);
//moore_over110101  TB2(.*);
//mealy_nonover110101   TB3(.*);
//mealy_over110101  TB4(.*);
	
	 always #5 clk=~clk;
	 
 initial begin
   clk=0;
   rst_n=0;
   #10;
   rst_n=1;
   a=1'b1;
   #10;
   a=1'b1;
   #10;
   a=1'b0;
   #10;
   a=1'b1;
   #10;
   a=1'b0;
   #10;
   a=1'b1;
   #10;
   a=1'b1;
   #10;
   a=1'b1;
   #10;
   a=1'b1;
   #10;
   a=1'b1;
   #10;
   $stop;
endmodule