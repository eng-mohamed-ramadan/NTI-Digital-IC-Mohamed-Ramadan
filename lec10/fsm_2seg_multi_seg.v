`default_nettype none
module fsm_2seg_multi_seg
(
  input wire clk, rst_n,
  input wire a, b,
  
  output reg y0,y1
);

  //1) States assignment (States Encoding: Binary or One-hot).
  localparam S0 = 2'b00,
             S1 = 2'b01,
			 S2 = 2'b10;
  
  //2) Registers/Signals declaration.
  reg [1:0] Present_State, Next_State;
  
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
	        case({a,b})
		     // 2'b00: Next_State = S0;
		     // 2'b01: Next_State = S0;
			  2'b10: Next_State = S1;
			  2'b11: Next_State = S2;
		    endcase
		  end
		S1:
          begin
	        case({a,b})
		     // 2'b00: Next_State = S1;
		     // 2'b01: Next_State = S1;
			  2'b10: Next_State = S0;
			  2'b11: Next_State = S0;
		    endcase              
   		  end
		S2:  Next_State = S0;
	  endcase
	end
  
  //5) Output logic (Moore and Mealy)
  // 5.1) Moore Output
 // assign y1 = (Present_State == S0) || (Present_State == S1);

  always@(*)
    begin: Moore_Output_logic
	  y1 = 1'b1;
      
	  if(Present_State == S2) 
	    y1 = 1'b0;
	end  

  //5.2) Mealy Output
 // assign y0 = (Present_State == S0) && (a & b);


  always@(*)
    begin: Mealy_Output_logic
	  y0 = 1'b0;
	  case(Present_State)
	    S0: 
		  begin
	        case({a,b})
			  2'b11: y0 = 1'b1;
		    endcase
		  end
	  endcase
	end

 /*
  // 2 Segment
  // Next-state logic & Output logic (Moore and Mealy)
  always@(*)
    begin: All_logic
	  Next_State = Present_State;
	  y0 = 1'b0;
	  y1 = 1'b0;
	  case(Present_State)
	    S0: 
		  begin
		    y1 = 1'b1;
	        case({a,b})
			  2'b10: Next_State = S1;
			  2'b11: 
			    begin
				  Next_State = S2;
				  y0 = 1'b1;
				end
		    endcase
		  end
		S1:
          begin
		    y1 = 1'b1;
	        case({a,b})
			  2'b10: Next_State = S0;
			  2'b11: Next_State = S0;
		    endcase              
   		  end
		S2:  Next_State = S0;
	  endcase
	end
*/	
endmodule