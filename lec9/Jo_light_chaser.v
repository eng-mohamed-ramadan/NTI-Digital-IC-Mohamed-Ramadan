module Jo_light_chaser (
       input wire clk_50MHz,
	   input wire rst_n,
       input wire hold_n,
       output wire [3:0] leds_n
);
      reg clk_2Hz;
	   reg [23:0] counter; 
      reg [3:0]   leds;    
	
	always @(posedge clk_50MHz or negedge rst_n) begin // clk divider
            if (!rst_n) begin
             counter <= 24'd0;
             clk_2Hz <= 1'b0;
           end
	       else if (counter == 24'd3_124_999) begin	//  <-for simulation ------ for for FPGA -> else if (counter == 24'd12499999) begin
             clk_2Hz <= ~clk_2Hz;		 
             counter <= 24'd0;
		   end
     	   else begin
             counter <= counter + 1'b1;
           end
 
        end
	   always @(posedge clk_2Hz or negedge rst_n) begin // light_chaser
	       if (!rst_n) begin
	          leds <= 4'b0001; 
           end
		   else begin  
		      if (hold_n) begin 
			     case (leds)
                     4'b0001: leds <= 4'b0010;
                     4'b0010: leds <= 4'b0100;
                     4'b0100: leds <= 4'b1000;
                     4'b1000: leds <= 4'b0001;
                     default: leds <= 4'b0001;
                   endcase
               end
		   end
       end  
		
	assign 	leds_n = ~ leds;
	
	
  endmodule