module DELAY #(
    parameter WIDTH = 8,
    parameter DELAY_CYCLE = 0 	
)(
    input wire in_DELAY_clk,
    input wire in_DELAY_rst, 
    input wire [WIDTH-1:0] out_DELAY_before,	
    output wire [WIDTH-1:0] out_DELAY_after   
);
    reg [WIDTH-1:0] register[0:DELAY_CYCLE-1];
    integer i;
    
    always @(posedge in_DELAY_clk or negedge in_DELAY_rst) begin 
        if(!in_DELAY_rst) begin
            for(i=0; i<DELAY_CYCLE; i=i+1)
                register[i] <= 0; 
        end else begin  
            register[0] <= out_DELAY_before;
            for(i=1; i<DELAY_CYCLE; i=i+1)
                register[i] <= register[i-1]; 
        end
    end
    
    assign out_DELAY_after = (DELAY_CYCLE==0) ? out_DELAY_before : register[DELAY_CYCLE-1];
endmodule