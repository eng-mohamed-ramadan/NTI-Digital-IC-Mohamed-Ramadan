module systolic_array_top #(
    parameter WIDTH = 8
) (
    input wire in_systolic_array_clk,
    input wire in_systolic_array_rst,
    input wire [2:0] in_systolic_array_ai_size,
    input wire in_systolic_array_ai_data_en,
    input wire in_systolic_array_rinc1,
    input wire in_systolic_array_rinc2,
    input wire in_systolic_array_rinc3,
    input wire in_systolic_array_start,
    output wire empty1, empty2, empty3,
    output wire out_img2col_sys_valid,
    output wire out_systolic_array_done,
    input wire [WIDTH-1:0] in_systolic_array_a_r0,	
    input wire [WIDTH-1:0] in_systolic_array_a_r1,
    input wire [WIDTH-1:0] in_systolic_array_a_r2,	
    input wire [WIDTH-1:0] in_systolic_array_b_c0,
    input wire [WIDTH-1:0] in_systolic_array_b_c1,	
    input wire [WIDTH-1:0] in_systolic_array_b_c2,
    output wire [19:0] out_systolic_array_ai_out1,
    output wire [19:0] out_systolic_array_ai_out2,
    output wire [19:0] out_systolic_array_ai_out3,
    output wire [15:0] out_systolic_array_ai_img

);

    wire [1:0] in_systolic_array_ctrl1, in_systolic_array_ctrl2, in_systolic_array_ctrl3; 
    wire [19:0] out_systolic_array_out1, out_systolic_array_out2, out_systolic_array_out3; 
    wire full1, full2, full3; 
    wire winc1, winc2, winc3; 
    wire valid, hold; 

    systolic_array #(.WIDTH(WIDTH)) s1 (
        .in_systolic_array_clk(in_systolic_array_clk),
        .in_systolic_array_rst(in_systolic_array_rst),
        .in_systolic_array_valid(valid),
        .in_systolic_array_hold(hold),  
        .in_systolic_array_ctrl1(in_systolic_array_ctrl1),
        .in_systolic_array_ctrl2(in_systolic_array_ctrl2),
        .in_systolic_array_ctrl3(in_systolic_array_ctrl3), 
        .in_systolic_array_a_r0(in_systolic_array_a_r0),	
        .in_systolic_array_a_r1(in_systolic_array_a_r1),
        .in_systolic_array_a_r2(in_systolic_array_a_r2),	
        .in_systolic_array_b_c0(in_systolic_array_b_c0),
        .in_systolic_array_b_c1(in_systolic_array_b_c1),	
        .in_systolic_array_b_c2(in_systolic_array_b_c2),    
        .out_systolic_array_out1(out_systolic_array_out1),
        .out_systolic_array_out2(out_systolic_array_out2),
        .out_systolic_array_out3(out_systolic_array_out3) 
    );

    sync_fifo #(.DATA_WIDTH(20), .DEPTH(16)) sync1 (
        .in_fifo_clk(in_systolic_array_clk),
        .in_fifo_rst(in_systolic_array_rst),
        .in_fifo_wr_en(winc1),
        .in_fifo_rd_en(in_systolic_array_rinc1),
        .in_fifo_wdata(out_systolic_array_out1),
        .out_fifo_rdata(out_systolic_array_ai_out1),
        .out_fifo_empty(empty1),
        .out_fifo_full(full1)
    );

    sync_fifo #(.DATA_WIDTH(20), .DEPTH(16)) sync2 (
        .in_fifo_clk(in_systolic_array_clk),
        .in_fifo_rst(in_systolic_array_rst),
        .in_fifo_wr_en(winc2),
        .in_fifo_rd_en(in_systolic_array_rinc2),
        .in_fifo_wdata(out_systolic_array_out2),
        .out_fifo_rdata(out_systolic_array_ai_out2),
        .out_fifo_empty(empty2),
        .out_fifo_full(full2)
    );

    sync_fifo #(.DATA_WIDTH(20), .DEPTH(16)) sync3 (
        .in_fifo_clk(in_systolic_array_clk),
        .in_fifo_rst(in_systolic_array_rst),
        .in_fifo_wr_en(winc3),
        .in_fifo_rd_en(in_systolic_array_rinc3),
        .in_fifo_wdata(out_systolic_array_out3),
        .out_fifo_rdata(out_systolic_array_ai_out3),
        .out_fifo_empty(empty3),
        .out_fifo_full(full3)
    );

    control_system control (
        .in_cs_clk(in_systolic_array_clk),
        .in_cs_rst(in_systolic_array_rst),
        .in_cs_full1(full1),
        .in_cs_full2(full2),
        .in_cs_full3(full3),
        .in_cs_data_en(in_systolic_array_ai_data_en),
        .in_cs_size(in_systolic_array_ai_size),
        .out_cs_winc1(winc1),
        .out_cs_winc2(winc2),
        .out_cs_winc3(winc3),
        .out_cs_valid(valid),
        .out_cs_hold(hold),
        .out_cs_ctrl1(in_systolic_array_ctrl1),
        .out_cs_ctrl2(in_systolic_array_ctrl2),
        .out_cs_ctrl3(in_systolic_array_ctrl3)
    );
    img2col_ctrl #(.ADDR_WIDTH(16),.K(3),.IMG_HEIGHT(5), .IMG_WIDTH(5), .S(1))d1 (
    .in_img2col_clk(in_systolic_array_clk),
    .in_img2col_rst(in_systolic_array_rst),
    .in_img2col_start(in_systolic_array_start),

    .out_img2col_mem_addr(out_systolic_array_ai_img),
    .out_img2col_valid(out_img2col_sys_valid), 
    .out_img2col_done(out_systolic_array_done)  
        );

endmodule