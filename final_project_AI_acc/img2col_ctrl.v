module img2col_ctrl #(
    parameter ADDR_WIDTH = 16, 
    parameter K = 3,           
    parameter S = 1,           
    parameter IMG_WIDTH = 32,
    parameter IMG_HEIGHT = 32  
)(
    input wire in_img2col_clk,
    input wire in_img2col_rst,
    input wire in_img2col_start,

    output reg [ADDR_WIDTH-1:0] out_img2col_mem_addr,
    output reg out_img2col_valid, 
    output reg out_img2col_done    
);

    localparam STATE_IDLE = 2'd0,
               STATE_CALC = 2'd1,
               STATE_DONE = 2'd2;

    reg [1:0] current_state, next_state;
    reg [15:0] x, y;
    reg [3:0] i, j;

    always @(posedge in_img2col_clk or negedge in_img2col_rst) begin
        if (!in_img2col_rst) begin
            current_state <= STATE_IDLE;
            x <= 0;
            y <= 0;
            i <= 0;
            j <= 0;
        end else begin
            current_state <= next_state;
            
            if (current_state == STATE_CALC) begin
                if (i == K - 1) begin
                    i <= 0;
                    if (j == K - 1) begin
                        j <= 0;
                        if (x + S > IMG_WIDTH - K) begin
                            x <= 0;
                            if (y + S > IMG_HEIGHT - K) begin
                                y <= 0; 
                            end else begin
                                y <= y + S;
                            end
                        end else begin
                            x <= x + S;
                        end
                    end else begin
                        j <= j + 1;
                    end
                end else begin
                    i <= i + 1;
                end
            end else if (current_state == STATE_IDLE) begin
                x <= 0;
                y <= 0;
                i <= 0;
                j <= 0;
            end
        end
    end

    always @(*) begin
        next_state = current_state;
        out_img2col_valid = 1'b0;
        out_img2col_done = 1'b0;
        out_img2col_mem_addr = 0;

        case (current_state)
            STATE_IDLE: begin
                if (in_img2col_start)
                    next_state = STATE_CALC;
            end

            STATE_CALC: begin
                out_img2col_valid = 1'b1;
                out_img2col_mem_addr = (y + j) * IMG_WIDTH + (x + i);
                
                if (i == K - 1 && j == K - 1 && (x + S > IMG_WIDTH - K) && (y + S > IMG_HEIGHT - K)) begin
                    next_state = STATE_DONE;
                end
            end

            STATE_DONE: begin
                out_img2col_done = 1'b1;
                if (!in_img2col_start)
                    next_state = STATE_IDLE;
            end

            default: next_state = STATE_IDLE;
        endcase
    end
endmodule