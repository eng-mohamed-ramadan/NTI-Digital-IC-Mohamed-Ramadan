module control_system (
    input wire in_cs_clk,
    input wire in_cs_rst,
    input wire in_cs_full1,
    input wire in_cs_full2,
    input wire in_cs_full3,
    input wire in_cs_data_en,
    input wire [2:0] in_cs_size,
    output reg out_cs_winc1,
    output reg out_cs_winc2,
    output reg out_cs_winc3,
    output reg out_cs_valid,
    output reg out_cs_hold,
    output reg [1:0] out_cs_ctrl1,
    output reg [1:0] out_cs_ctrl2,
    output reg [1:0] out_cs_ctrl3
);

    localparam STATE_IDLE      = 3'd0;
    localparam STATE_CALC      = 3'd1;
    localparam STATE_READ_COL0 = 3'd2;
    localparam STATE_READ_COL1 = 3'd3;
    localparam STATE_READ_COL2 = 3'd4;

    reg [2:0] current_state, next_state;
    reg [4:0] calc_timer;
    localparam CALC_CYCLES = 5'd10;

    always @(posedge in_cs_clk or negedge in_cs_rst) begin
        if (!in_cs_rst) begin
            current_state <= STATE_IDLE;
            calc_timer    <= 5'd0;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_CALC) begin
                calc_timer <= calc_timer + 1'b1;
            end else begin
                calc_timer <= 5'd0;
            end
        end
    end

    always @(*) begin
        next_state   = current_state;
        out_cs_valid = 1'b0;
        out_cs_hold  = 1'b0;
        out_cs_winc1 = 1'b0;
        out_cs_winc2 = 1'b0;
        out_cs_winc3 = 1'b0;
        out_cs_ctrl1 = 2'd0;
        out_cs_ctrl2 = 2'd0;
        out_cs_ctrl3 = 2'd0;

        case (current_state)
            STATE_IDLE: begin
                if (in_cs_data_en) next_state = STATE_CALC;
            end
            STATE_CALC: begin
                out_cs_valid = 1'b1;
                if (calc_timer == CALC_CYCLES) next_state = STATE_READ_COL0;
            end
            STATE_READ_COL0: begin
                out_cs_hold  = 1'b1;
                out_cs_ctrl1 = 2'd0;
                out_cs_ctrl2 = 2'd0;
                out_cs_ctrl3 = 2'd0;
                if (!in_cs_full1 && !in_cs_full2 && !in_cs_full3) begin
                    out_cs_winc1 = 1'b1;
                    out_cs_winc2 = 1'b1;
                    out_cs_winc3 = 1'b1;
                    next_state   = STATE_READ_COL1;
                end
            end
            STATE_READ_COL1: begin
                out_cs_hold  = 1'b1;
                out_cs_ctrl1 = 2'd1;
                out_cs_ctrl2 = 2'd1;
                out_cs_ctrl3 = 2'd1;
                if (!in_cs_full1 && !in_cs_full2 && !in_cs_full3) begin
                    out_cs_winc1 = 1'b1;
                    out_cs_winc2 = 1'b1;
                    out_cs_winc3 = 1'b1;
                    next_state   = STATE_READ_COL2;
                end
            end
            STATE_READ_COL2: begin
                out_cs_hold  = 1'b1;
                out_cs_ctrl1 = 2'd2;
                out_cs_ctrl2 = 2'd2;
                out_cs_ctrl3 = 2'd2;
                if (!in_cs_full1 && !in_cs_full2 && !in_cs_full3) begin
                    out_cs_winc1 = 1'b1;
                    out_cs_winc2 = 1'b1;
                    out_cs_winc3 = 1'b1;
                    next_state   = STATE_IDLE;
                end
            end
            default: next_state = STATE_IDLE;
        endcase
    end
endmodule