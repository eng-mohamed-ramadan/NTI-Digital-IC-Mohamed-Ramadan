module PE(
  input wire clk,
  input wire reset,
  input wire hold,
  input wire [7:0] A,
  input wire [7:0] B,
  input wire valid,
  output reg [19:0] Out,
  output reg [7:0] A_Out,
  output reg [7:0] B_Out
);
reg [15:0] mult_out;
reg [19:0] acc_out;

always@(posedge clk or negedge reset) begin
  if(!reset) begin
     Out      <= 20'b0;              
     A_Out    <= 8'b0;
     B_Out    <= 8'b0;
  end else if (!hold) begin
    A_Out <= A;
    B_Out <= B;
    Out   <= acc_out;
  end
end
  
always@(*) begin
  mult_out = A * B;
  case(valid) 
    1'b0:    acc_out = mult_out;
    1'b1:    acc_out = mult_out + Out;
    default: acc_out = mult_out;
  endcase
end
endmodule