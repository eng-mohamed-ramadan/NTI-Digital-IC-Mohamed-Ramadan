`default_nettype none
module mealy_nonover110101
(
  input wire clk, rst_n,
  input wire a,
  
  output reg y
);

  //1) States assignment (States Encoding: Binary or One-hot).
  localparam S0 = 3'b000,
             S1 = 3'b001,
			 S2 = 3'b010,
             S3 = 3'b011,
			 S4 = 3'b100,
			 S5 = 3'b101,
			 S6 = 3'b110;
  
  //2) Registers/Signals declaration.
  reg [2:0] Present_State, Next_State;
  
  //3) State register.
  always@(posedge clk, negedge rst_n)
    begin: State_register
	  if(~rst_n)
	    Present_State <= S0;
	  else
	    Present_State <= Next_State;
	end
 
  
  // Multi-segment
  //4) Next-state logic. 
  always@(*)
    begin: Next_state_logic  // Block Name
	  Next_State = Present_State;
	  case(Present_State)
	    S0: Next_State = a ? S1 : S0;  
		S1: Next_State = a ? S2 : S0;  
		S2: Next_State = a ? S2 : S3;     
		S3: Next_State = a ? S4 : S0;	 
		S4: Next_State = a ? S2 : S5;    
		S5: Next_State = a ? S6 : S0; 
		S6: Next_State = a ? S1 : S0;
          
	  endcase
	end
  
  //5) Output logic (Moore and Mealy)
   

  // Meare Output
 


  always@(*)
    begin: Mealy_Output_logic
	y= (Present_State==s6);
	end

	
endmodule