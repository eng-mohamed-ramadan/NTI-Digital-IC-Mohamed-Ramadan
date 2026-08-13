module systolic_array #(
    parameter WIDTH = 8 
)(
    input wire in_systolic_array_clk,
    input wire in_systolic_array_rst,
    input wire in_systolic_array_valid,
    input wire in_systolic_array_hold,
    input wire [1:0] in_systolic_array_ctrl1, in_systolic_array_ctrl2, in_systolic_array_ctrl3, 
    input wire [WIDTH-1:0] in_systolic_array_a_r0,	
    input wire [WIDTH-1:0] in_systolic_array_a_r1,
    input wire [WIDTH-1:0] in_systolic_array_a_r2,	
    input wire [WIDTH-1:0] in_systolic_array_b_c0,
    input wire [WIDTH-1:0] in_systolic_array_b_c1,	
    input wire [WIDTH-1:0] in_systolic_array_b_c2,    
    output reg [19:0] out_systolic_array_out1, out_systolic_array_out2, out_systolic_array_out3 
);
    localparam n_n = 3;
    
    wire [WIDTH-1:0] wire_a [0:n_n-1] [0:n_n];
    wire [WIDTH-1:0] wire_b [0:n_n] [0:n_n-1];
    wire [19:0] out [0:n_n-1] [0:n_n-1];
    reg [1:0] cnt1, cnt2, cnt3;
    
    assign wire_a[0][0] = in_systolic_array_a_r0;
    assign wire_b[0][0] = in_systolic_array_b_c0;
    
    DELAY #(.WIDTH(WIDTH), .DELAY_CYCLE(1)) d_a1(
        .in_DELAY_clk(in_systolic_array_clk),
        .in_DELAY_rst(in_systolic_array_rst),
        .out_DELAY_before(in_systolic_array_a_r1),
        .out_DELAY_after(wire_a[1][0]) 
    );
    
    DELAY #(.WIDTH(WIDTH), .DELAY_CYCLE(1)) d_b1(
        .in_DELAY_clk(in_systolic_array_clk),
        .in_DELAY_rst(in_systolic_array_rst),
        .out_DELAY_before(in_systolic_array_b_c1),
        .out_DELAY_after(wire_b[0][1])
    );
    
    DELAY #(.WIDTH(WIDTH), .DELAY_CYCLE(2)) d_a2(
        .in_DELAY_clk(in_systolic_array_clk),
        .in_DELAY_rst(in_systolic_array_rst),
        .out_DELAY_before(in_systolic_array_a_r2),
        .out_DELAY_after(wire_a[2][0]) 
    );
    
    DELAY #(.WIDTH(WIDTH), .DELAY_CYCLE(2)) d_b2(
        .in_DELAY_clk(in_systolic_array_clk),
        .in_DELAY_rst(in_systolic_array_rst),
        .out_DELAY_before(in_systolic_array_b_c2),
        .out_DELAY_after(wire_b[0][2])
    );
    
    genvar r, c;
    generate
        for (r = 0; r < 3; r = r + 1) begin : ROW
            for (c = 0; c < 3; c = c + 1) begin : COL
                PE pe (
                    .clk(in_systolic_array_clk),
                    .reset(in_systolic_array_rst),
                    .hold(in_systolic_array_hold),
                    .valid(in_systolic_array_valid),
                    .A(wire_a[r][c]),          
                    .B(wire_b[r][c]),          
                    .A_Out(wire_a[r][c+1]),    
                    .B_Out(wire_b[r+1][c]),    
                    .Out(out[r][c])
                );
            end
        end	
    endgenerate	

    always @(*) begin
        case (in_systolic_array_ctrl1)
            2'd0: out_systolic_array_out1 = out[0][0];
            2'd1: out_systolic_array_out1 = out[0][1];
            2'd2: out_systolic_array_out1 = out[0][2];
            default: out_systolic_array_out1 = 0;
        endcase

        case (in_systolic_array_ctrl2)
            2'd0: out_systolic_array_out2 = out[1][0];
            2'd1: out_systolic_array_out2 = out[1][1];
            2'd2: out_systolic_array_out2 = out[1][2];
            default: out_systolic_array_out2 = 0;
        endcase

        case (in_systolic_array_ctrl3)
            2'd0: out_systolic_array_out3 = out[2][0];
            2'd1: out_systolic_array_out3 = out[2][1];
            2'd2: out_systolic_array_out3 = out[2][2];
            default: out_systolic_array_out3 = 0;
        endcase
    end
endmodule