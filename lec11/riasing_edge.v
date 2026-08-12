`timescale 1ns/1ps
`default_nettype none
module Moore_edge (
    input wire clk,rst_n,level,
    output reg tick
);
localparam 
ZERO = 2'b00,
EDGE = 2'b01,
ONE = 2'b10 
;   
reg [1:0] cs,ns; 
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        tick<=0;cs<=0;
    end
    else 
     cs<=ns;
end
always @(*) begin
   ns=cs;
    case (cs)
       ZERO : begin if(level) ns=EDGE;  end
       EDGE : begin #2; tick=1;  ns=ONE; end
       ONE : begin ns=ZERO; tick=0; end
    endcase
end
endmodule