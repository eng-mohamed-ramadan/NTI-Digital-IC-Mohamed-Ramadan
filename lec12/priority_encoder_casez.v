module priority_encoder_casez (
    input  [3:0] in,
    output reg [1:0] out,
    output reg       valid
);

    always @(*) begin
        valid = 1'b1;
        casez (in)
            4'b1???: out = 2'd3; 
            4'b01??: out = 2'd2;
            4'b001?: out = 2'd1;
            4'b0001: out = 2'd0;
            default: begin
                out = 2'd0;
                valid = 1'b0;
            end
        endcase
    end

endmodule