module reg_nti #(
    parameter WIDTH = 32, ADDR=6
)(
input wen,clk,rst_n,
input [WIDTH-1:0] wdata,
input [ADDR-1:0] raddr1,
input [ADDR-1:0] raddr2,
input [ADDR-1:0] waddr,
output wire [WIDTH-1:0] rdata1,
output wire [WIDTH-1:0] rdata2
);
localparam log = 1<<ADDR;
reg [WIDTH-1:0]file[0:(1<<log)-1];
integer k;
always @(posedge clk or negedge rst_n)
begin
 if(!rst_n)
   begin
   for (k =0 ;k<log ;k=k+1 ) begin
    file[k]={WIDTH{1'b0}};
   end
   end 
else if(wen)
begin
 file[waddr]<=wdata;
 end
end 
assign rdata1=file[raddr1];
assign rdata2=file[raddr2];
endmodule