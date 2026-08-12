`timescale 1ns/1ps
`default_nettype none
module Mealy_edge (
    input wire clk,rst_n,level,
    output reg tick
);
localparam 
ZERO = 1'b0,
ONE = 1'b1
;   
reg  cs,ns; 
reg level_reg;
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        cs<=0; level_reg<=0;
    end
    else begin
     cs<=ns; level_reg<=level; end
end
always @(*) begin
   ns=cs; tick=0;
    case (cs)
       ZERO : begin 
        if(level_reg==!level) begin 
        ns=ONE; tick=1; end 
       end
       ONE : begin 
        ns=ZERO;
        end
    endcase
end
endmodule