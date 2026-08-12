`default_nettype none
`timescale 1ns/1ps
module Edge_tb;
reg clk;
reg rst_n;
reg level;
wire tick;
Mealy_edge d1(
    .*
);
Moore_edge d2(
    .*
);
Edge_seq d3(
    .*
);
always #5 clk=~clk;
initial begin
    rst_n=0;clk=0;level=0;
    #5
    rst_n=1;
    #7
    level=1;
    #20
    level=0;
    #100
    $stop; 

end


endmodule    
