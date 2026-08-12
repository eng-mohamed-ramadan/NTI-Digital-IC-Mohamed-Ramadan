`timescale 1ns / 1ps

module case_comparison_tb;

    reg  [3:0] in;
    
    wire [1:0] out_x;
    wire       valid_x;
    
    wire [1:0] out_z;
    wire       valid_z;

    priority_encoder_casex uut_casex (
        .in(in),
        .out(out_x),
        .valid(valid_x)
    );

    priority_encoder_casez uut_casez (
        .in(in),
        .out(out_z),
        .valid(valid_z)
    );

    initial begin
        $display("Time | Request | casex (Grant, Valid) | casez (Grant, Valid)");
        $display("----------------------------------------------------------");
        $monitor("%4t |  %b   |       (%d, %b)       |       (%d, %b)", 
                 $time, in, out_x, valid_x, out_z, valid_z);

        
		in[2:0] = 3'b100; #10; 
		in = 4'b1000; #10 // Expect out = 3
        in = 4'b0100; #10; // Expect out = 2
        
        in = 4'bx100; #10; 

        in = 4'b00x1; #10;

        $stop;
    end
endmodule