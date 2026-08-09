module tb_multiple_values;
  reg clk;
  reg [7:0] a_blocking, b_blocking;
  reg [7:0] a_nonblocking, b_nonblocking;

  always #5 clk = ~clk;

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_multiple_values);

    clk = 0;
    a_blocking = 0; b_blocking = 0;
    a_nonblocking = 0; b_nonblocking = 0;

    $display("Time | Blocking (a->b) | Non-Blocking (a->b)");
    $display("-------------------------------------------");

    $monitor("%4t | a=%3d, b=%3d  | a=%3d, b=%3d",
             $time, a_blocking, b_blocking, a_nonblocking, b_nonblocking);
    #50 $stop;
  end

  always @(posedge clk) begin
    b_blocking = a_blocking;
  end  

  always @(posedge clk) begin
    a_blocking = a_blocking + 10;
  end
/*
  always @(posedge clk) begin
    b_blocking = a_blocking;
  end
*/
  always @(posedge clk) begin
    a_nonblocking <= a_nonblocking + 10;
    b_nonblocking <= a_nonblocking;
  end
/*
  always @(posedge clk) begin
    b_nonblocking <= a_nonblocking;
  end
*/
endmodule