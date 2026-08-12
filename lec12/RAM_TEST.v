`default_nettype none
`timescale 1ns/1ps

module reg_nti_tb;
parameter WIDTH=32; 
parameter ADDR=6;
reg clk;
reg rst_n;
reg wen;
reg [WIDTH-1:0]wdata;
reg [ADDR-1:0]raddr1;
reg [ADDR-1:0]raddr2;
reg [ADDR-1:0]waddr;
wire [WIDTH-1:0]rdata1;
wire[WIDTH-1:0] rdata2;

reg_nti #(.WIDTH(WIDTH),.ADDR(ADDR)) d1(
    .*
);

always #5 clk=~clk;

initial begin
    clk=0; rst_n=0;wen=0;
    #10;
    rst_n=1;
    wen=1; waddr=6'd0; wdata=32'd31;
    #20
    waddr=6'd2; wdata=32'd120;
    #10
    wen=0; 
    #10
    raddr1=6'd0; raddr2=6'd2; 
    if (rdata1==31) begin
        $display("Test0 Passed");
    end
    else $display("test0 failed");

    if (rdata2==120) begin
        $display("Test1 Passed");
    end
    else $display("test1 failed");
    #10
    //7'b1000000
    wen=1; waddr=64; wdata=60;
    #20
    raddr1=64; wen=0;
    if (rdata1===60) begin
        $display("Test0 Failed");
    end
    else $display("test0 Passed");
    #100
    $stop;
end
endmodule