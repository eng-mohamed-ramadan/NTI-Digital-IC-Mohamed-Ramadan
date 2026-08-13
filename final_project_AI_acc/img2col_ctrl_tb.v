`timescale 1ns/1ps

module img2col_ctrl_tb;

    reg clk;
    reg rst;
    reg start;
    wire [15:0] mem_addr;
    wire valid;
    wire done;

    img2col_ctrl #(
        .ADDR_WIDTH(16), 
        .K(3), 
        .S(1), 
        .IMG_WIDTH(5), 
        .IMG_HEIGHT(5)
    ) uut (
        .in_img2col_clk(clk),
        .in_img2col_rst(rst),
        .in_img2col_start(start),
        .out_img2col_mem_addr(mem_addr),
        .out_img2col_valid(valid),
        .out_img2col_done(done)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("img2col_dump.vcd");
        $dumpvars;
        $monitor("Time:%0t | Start:%b | Valid:%b | Mem_Addr:%d | Done:%b", $time, start, valid, mem_addr, done);


        clk = 0; 
        rst = 0; 
        start = 0;
        #20 rst = 1; 

        @(negedge clk);
        start = 1;
        
        @(negedge clk);
        start = 0; 

        wait(done);
        #50;
        
        $stop;
    end
endmodule