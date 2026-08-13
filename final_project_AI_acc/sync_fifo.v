module sync_fifo #(
    parameter DATA_WIDTH = 20,
    parameter DEPTH = 16       
)(
    input wire in_fifo_clk,
    input wire in_fifo_rst,
    input wire in_fifo_wr_en,
    input wire in_fifo_rd_en,
    input wire [DATA_WIDTH-1:0] in_fifo_wdata,
    output reg [DATA_WIDTH-1:0] out_fifo_rdata,
    output wire out_fifo_empty,
    output wire out_fifo_full
);
    
    localparam ADDR_WIDTH = $clog2(DEPTH);
    
    reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];
    reg [ADDR_WIDTH-1:0] wr_ptr;          
    reg [ADDR_WIDTH-1:0] rd_ptr;         
    reg [ADDR_WIDTH:0] count;           
    
    assign out_fifo_full  = (count == DEPTH);
    assign out_fifo_empty = (count == 0);

    always @(posedge in_fifo_clk or negedge in_fifo_rst) begin
        if (!in_fifo_rst) begin
            wr_ptr <= 0;
            rd_ptr <= 0;
            count  <= 0;
            out_fifo_rdata <= 0;
        end else begin
            if (in_fifo_wr_en && !out_fifo_full) begin
                mem[wr_ptr] <= in_fifo_wdata;
                wr_ptr <= wr_ptr + 1'b1;
            end
            
            if (in_fifo_rd_en && !out_fifo_empty) begin
                out_fifo_rdata <= mem[rd_ptr];
                rd_ptr <= rd_ptr + 1'b1;
            end
            
            case ({in_fifo_wr_en && !out_fifo_full, in_fifo_rd_en && !out_fifo_empty})
                2'b10: count <= count + 1'b1;
                2'b01: count <= count - 1'b1;
                default: count <= count;    
            endcase
        end
    end
endmodule