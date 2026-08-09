module FA_Behav
(
  input  wire A, 
  input  wire B,
  input  wire Cin,
  
  output reg sum,
  output reg cout
);
  /*
  //Internal signal FA_reg
  reg [1:0] FA_reg;
  
  //Proc assignment
  always@(*) //always_comb
    begin
	  FA_reg = A + B + Cin;
	end

  //continous assignment
  assign sum = FA_reg[0];
  assign cout = FA_reg[1];
  */
  
  //Internal signal FA_reg
  
  always@(*) //always_comb
    begin
      {cout, sum} = A + B + Cin;  
	end
  
endmodule