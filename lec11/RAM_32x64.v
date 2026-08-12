`default_nettype none
module RAM_32x64
#(parameter ADD_WIDTH = 6, DATA_WIDTH = 32)
(
  input wire                    clk,
  input wire                    rst_n,
  input wire                    we,     // Write enable, 1 >> write, 0 >> read  
  input wire [DATA_WIDTH-1 : 0] wdata,  // Synch. write
  input wire [ADD_WIDTH-1 : 0]  waddr,
  input wire [ADD_WIDTH-1 : 0]  raddr1,
  input wire [ADD_WIDTH-1 : 0]  raddr2,
  
  output wire [DATA_WIDTH-1 : 0] rdata1, // Asynch read 1
  output wire [DATA_WIDTH-1 : 0] rdata2  // Asynch read 2
);
  
  localparam DEPTH = (1 << ADD_WIDTH);
  //   DATA width               Depth
  reg [DATA_WIDTH-1 : 0] RAM [0: DEPTH-1];
  
  integer i;
  
  always@(posedge clock or negedge rst_n)  // Static signals >>  reset
    begin
	  if(~rst_n)
	    begin
		  for (i = 0; i < DEPTH ; i = i + 1)
		    begin
		      RAM[i] <= {DATA_WIDTH{1'b0}};
            end
		  // RAM[0] <= {DATA_WIDTH{1'b0}};  // Equivalent to the for loop 
		  // RAM[1] <= {DATA_WIDTH{1'b0}};
          // RAM[2] <= {DATA_WIDTH{1'b0}};		  
		end
	  else if(we)
	    RAM[waddr] <= wdata;
	end  

  assign rdata1 = RAM[raddr1];

  assign rdata2 = RAM[raddr2];

endmodule