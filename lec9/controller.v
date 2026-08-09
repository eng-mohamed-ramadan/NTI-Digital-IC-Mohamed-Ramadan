module controller
(
  input  wire [2:0] opcode ,
  input  wire [2:0] phase  ,
  input  wire       zero   , // accumulator is zero
  output wire        sel    , // select instruction address to memory
  output wire        rd     , // enable memory output onto data bus
  output wire        ld_ir  , // load instruction register
  output wire        inc_pc , // increment program counter
  output wire        halt   , // halt machine
  output wire        ld_pc  , // load program counter
  output wire        data_e , // enable accumulator output onto data bus
  output wire        ld_ac  , // load accumulator from data bus
  output wire        wr       // write data bus to memory
);
  
  // Opcode Encoding
  localparam [2:0]   HLT = 3'b000, 
                     SKZ = 3'b001, 
					 ADD = 3'b010, 
					 AND = 3'b011, 
					 XOR = 3'b100, 
					 LDA = 3'b101, 
					 STO = 3'b110, 
					 JMP = 3'b111;
					 
  // Phase Encoding
  localparam [2:0]   INST_ADDR  = 3'b000, 
                     INST_FETCH = 3'b001, 
					 INST_LOAD  = 3'b010, 
					 IDLE       = 3'b011, 
					 OP_ADDR    = 3'b100, 
					 OP_FETCH   = 3'b101, 
					 ALU_OP     = 3'b110, 
					 STORE      = 3'b111;					 


  wire HALT, ALUOP, SKIP, JUMP, STORE_L;
  
  reg [8:0] Outs;
  
  assign HALT     = (opcode == HLT);
  assign ALUOP    = (opcode == ADD) || (opcode == AND) || (opcode == XOR) || (opcode == LDA);
  assign SKIP     = zero && (opcode == SKZ);
  assign JUMP     = (opcode == JMP);
  assign STORE_L  = (opcode == STO);
 
/* 
  always@(*)
    begin
	  {sel, rd, ld_ir, halt, inc_pc, ld_ac, ld_pc, wr, data_e} = 9'b0000_0000_0;
	
	  case(phase)
	    INST_ADDR:  sel = 1'b1;
	    INST_FETCH: {sel, rd} = 2'b11;
	    INST_LOAD:  {sel, rd, ld_ir} = 3'b111;
	    IDLE:       {sel, rd, ld_ir} = 3'b111;
		OP_ADDR:    {halt, inc_pc}   = {{HALT}, 1'b1};
		OP_FETCH:   rd = ALUOP; 
		ALU_OP:     {rd, inc_pc, ld_pc, data_e} = {ALUOP, SKIP, JUMP, STORE_L};
		STORE:      {rd, ld_ac, ld_pc, wr, data_e} =  {{2{ALUOP}}, JUMP, {2{STORE_L}}};
		default:    {sel, rd, ld_ir, halt, inc_pc, ld_ac, ld_pc, wr, data_e} = 9'b0000_0000_0;
	  endcase
	end
*/

  always@(*)
    begin
	  Outs = 9'b0000_0000_0;
	
	  case(phase)
	    INST_ADDR:  Outs[8] = 1'b1;
	    INST_FETCH: Outs[8:7] = 2'b11;
	    INST_LOAD:  Outs[8:6] = 3'b111;
	    IDLE:       Outs[8:6] = 3'b111;
		OP_ADDR:    Outs[5:4] = {{HALT}, 1'b1};
		OP_FETCH:   Outs[7] = ALUOP; 
		ALU_OP:     {Outs[7], Outs[4], Outs[2], Outs[0]} = {ALUOP, SKIP, JUMP, STORE_L};
		STORE:      {Outs[7], Outs[3:0]} =  {{2{ALUOP}}, JUMP, {2{STORE_L}}};
		default:    Outs = 9'b0000_0000_0;
	  endcase
	end
  
  
  //     In this case outs must be defined as wire 
  //	  8     7    6     5      4      3        2    1    0
  assign {sel, rd, ld_ir, halt, inc_pc, ld_ac, ld_pc, wr, data_e} = Outs;

	
endmodule	