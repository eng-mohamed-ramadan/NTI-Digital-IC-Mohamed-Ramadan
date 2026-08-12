`default_nettype none
module Debouncing_circiut
#(parameter CLK_FPGA=50_000_000,
            waitingtime=300*10**-9
 )
(
  input wire clk, rst_n,
  input wire sw,
  
  output reg db
);

     localparam [3:0] COUNT_MAX = 4'b1111; //wait 300ns  //(CLK_FPGA*waitingtime) =count_max
	 // localparam [$clog2(CLK_FPGA*waitingtime)-1:0] COUNT_MAX =CLK_FPGA*waitingtime) ;
    reg [4:0] counter;
	//  reg [$clog2(CLK_FPGA*waitingtime):0] counter;
	wire m_tick;

 always@(posedge clk, negedge rst_n)
    begin
	 if(rst_n==0)
	     begin
            counter<=5'b0;			
		 end
	 else 
	     begin
            if(counter==COUNT_MAX)
				counter=5'b0;	
			else 
			   counter<=counter+1'b1;
		 end
      
	end	

assign m_tick=(counter==COUNT_MAX);



  //1) States assignment (States Encoding: Binary or One-hot).
  localparam zero = 3'b000,
             wait1_1 =3'b001,
			wait1_2 = 3'b010,
            wait1_3 =3'b011,
			
			one     =3'b100,
			wait0_1 =3'b101,
			wait0_2 =3'b110,
			wait0_3 =3'b111;
  //2) Registers/Signals declaration.
  reg [1:0] Present_State, Next_State;
  
  //3) State register.
  always@(posedge clk, negedge rst_n)
    begin: State_register
	  if(~rst_n)
	    Present_State <=  zero;
	  else
	    Present_State <= Next_State;
	end
  
  // Multi-segment
  //4) Next-state logic. 
  always@(*)
    begin: Next_state_logic  // Block Name
	  Next_State = Present_State;
	  case(Present_State)
	    zero: Next_State = sw ? wait1_1: zero;
		 
		wait1_1:
          begin
	        case({sw,m_tick})
		      2'b00: Next_State = zero;
		      2'b01: Next_State = zero;
			 // 2'b10: Next_State = wait1_1;
			  2'b11: Next_State = wait1_2;
		    endcase              
   		  end
		wait1_2:
          begin
	        case({sw,m_tick})
		      2'b00: Next_State = zero;
		      2'b01: Next_State = zero;
			 // 2'b10: Next_State = wait1_2;
			  2'b11: Next_State = wait1_3;
		    endcase              
   		  end
		  wait1_3:
          begin
	        case({sw,m_tick})
		      2'b00: Next_State = zero;
		      2'b01: Next_State = zero;
			 // 2'b10: Next_State = wait1_3;
			  2'b11: Next_State = one ;
		    endcase              
   		  end
		  one:     Next_State = sw ? one: wait0_1 ;
		  
		   wait0_1:
          begin
	        case({sw,m_tick})
		     // 2'b00: Next_State =  wait0_1;
		      2'b01: Next_State = wait0_2;
			  2'b10: Next_State = one;
			  2'b11: Next_State = one ;
		    endcase              
   		  end
		   wait0_2:
          begin
	        case({sw,m_tick})
		     // 2'b00: Next_State =wait0_2;
		      2'b01: Next_State = wait0_3;
			  2'b10: Next_State = one;
			  2'b11: Next_State = one ;
		    endcase              
   		  end
		    wait0_3:
          begin
	        case({sw,m_tick})
		     // 2'b00: Next_State =wait0_3;
		      2'b01: Next_State =zero ;
			  2'b10: Next_State = one;
			  2'b11: Next_State = one ;
		    endcase              
   		  end
	  endcase
	end
  
  //5) Output logic (Moore and Mealy)
  // 5.1) Moore Output

  always@(*)
    begin: Moore_Output_logic
	  if((Present_State ==one) ||(Present_State ==wait0_1) ||(Present_State ==wait0_2) ||(Present_State ==wait0_3) ) 
	    db = 1'b1;
	 else    db = 1'b0;
	end  

  
 
endmodule


