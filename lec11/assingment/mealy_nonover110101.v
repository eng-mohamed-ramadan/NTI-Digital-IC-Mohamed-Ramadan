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
			 S5 = 3'b101;
			
  
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
	    S0: 
		  begin
	        case(a)
			  1'b0: Next_State = S0;
			  1'b1: Next_State = S1;
		    endcase      //Next_State = a ? S1 : S0;
		  end
		S1:
          begin
	        case(a)
			  1'b0: Next_State = S0;
			  1'b1: Next_State = S2;
		    endcase     //Next_State = a ? S2 : S0;         
   		  end
		S2:
          begin
	        case(a)
			  1'b0: Next_State = S3;
			  1'b1: Next_State = S2;
		    endcase      //Next_State = a ? S2 : S3;        
   		  end
		S3:
          begin
	        case(a)
			  1'b0: Next_State = S0;
			  1'b1: Next_State = S4;
		    endcase      //Next_State = a ? S4 : S0;         
   		  end
		 S4:
          begin
	        case(a)
			  1'b0: Next_State = S5;
			  1'b1: Next_State = S2;
		    endcase       //Next_State = a ? S2 : S5;        
   		  end
		 S5:  Next_State =  S0; 
          
	  endcase
	end
  
  //5) Output logic (Moore and Mealy)
   

  // Mealy Output
 


  always@(*)
    begin: Mealy_Output_logic
	  y = 1'b0;
	  case(Present_State)    //can use if (Present_State==s5 && a==1)
	    S5:  y = a? 1 :0;
		// y = (a==1);
	  endcase
	end

	
endmodule