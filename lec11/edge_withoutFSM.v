`timescale 1ns/1ps
`default_nettype none
module Edge_seq (
    input wire clk,rst_n,level,
    output wire tick
);
reg level_reg;
wire trig;
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        level_reg<=0;
    end
        else begin
     level_reg<=level; end
end

reg trig1;
always @(*) begin
 trig1=level_reg;
 tick = level^trig1; 
end

endmodule