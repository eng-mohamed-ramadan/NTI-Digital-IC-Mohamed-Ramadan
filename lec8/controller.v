module controller
(
    input  wire [2:0] opcode  ,
    input  wire [2:0] phase   ,
    input  wire       zero    , // accumulator is zero
    output reg        sel     , // select instruction address to memory
    output reg        rd      , // enable memory output onto data bus
    output reg        ld_ir   , // load instruction register
    output reg        inc_pc  , // increment program counter
    output reg        halt    , // halt machine
    output reg        ld_pc   , // load program counter
    output reg        data_e  , // enable accumulator output onto data bus
    output reg        ld_ac   , // load accumulator from data bus
    output reg        wr        // write data bus to memory
);
			reg HALT=0,
			    ALUOP=0,
				jmp=0,
				sto=0,
				s_z=0;
// Opcode Encoding
localparam integer HLT=0,
                   SKZ=1,
                   ADD=2,
                   AND=3,
                   XOR=4,
                   LDA=5,
                   STO=6,
                   JMP=7;

// Phase Encoding
localparam integer INST_ADDR=0,
                   INST_FETCH=1,
                   INST_LOAD=2,
                   IDLE=3,
                   OP_ADDR=4,
                   OP_FETCH=5,
                   ALU_OP=6,
                   STORE=7;
				   
				   
        always@(*)
			begin
			HALT=0;
			    ALUOP=0;
				jmp=0;
				sto=0;
				s_z=0;
				
				 {sel,rd , ld_ir,halt,inc_pc, ld_ac,ld_pc,wr ,data_e}=9'b000000000;
				
				
				
				
				
			if(phase ==INST_ADDR)
			         {sel,rd , ld_ir,halt,inc_pc, ld_ac,ld_pc,wr ,data_e}=9'b100000000;
			else if(phase ==INST_FETCH)
					 {sel,rd , ld_ir,halt,inc_pc, ld_ac,ld_pc,wr ,data_e}=9'b110000000;
			else if(phase ==INST_LOAD)
					 {sel,rd , ld_ir,halt,inc_pc, ld_ac,ld_pc,wr ,data_e}=9'b111000000;
		    else if(phase ==IDLE)
					 {sel,rd , ld_ir,halt,inc_pc, ld_ac,ld_pc,wr ,data_e}=9'b111000000;
			else if(phase ==OP_ADDR)
					begin
					  if(opcode==HLT)
			             HALT=1'b1;
					  else
					     HALT=1'b0;
					 {sel,rd , ld_ir,halt,inc_pc, ld_ac,ld_pc,wr ,data_e}={3'b000,HALT,5'b10000};		 
					end
			else if(phase ==OP_FETCH)
					begin
					  if(opcode<=LDA && opcode>=ADD )
			             ALUOP=1'b1;
					  else
					    ALUOP=1'b0;
					 {sel,rd , ld_ir,halt,inc_pc, ld_ac,ld_pc,wr ,data_e}={1'b0, ALUOP,7'b0000000};		 
					end
			else if(phase == ALU_OP)
					begin
					  if(opcode<=LDA && opcode>=ADD )
			           begin  ALUOP=1; jmp=0; sto=0; s_z=0; end
					  else if (  (opcode==SKZ) && zero)
					     begin  s_z=1; ALUOP=0;  jmp=0; sto=0;  end
                      else if (opcode== JMP)
					     begin  s_z=0; ALUOP=0;  jmp=1; sto=0;  end
					  else if (opcode== STO)
					     begin  s_z=0; ALUOP=0;  jmp=0; sto=1;  end
					 {sel,rd , ld_ir,halt,inc_pc, ld_ac,ld_pc,wr ,data_e}={1'b0, ALUOP,2'b00,s_z,1'b0,jmp,1'b0,sto};		 
					end
	        else if(phase == STORE)
					begin
					  if(opcode<=LDA && opcode>=ADD )
			           begin  ALUOP=1; jmp=0; sto=0; s_z=0; end
					 // else if (  (opcode==SKZ) && zero)
					  //   begin  s_z=1; ALUOP=0;  jmp=0; sto=0;  end
                      else if (opcode== JMP)
					     begin  s_z=0; ALUOP=0;  jmp=1; sto=0;  end
					  else if (opcode== STO)
					     begin  s_z=0; ALUOP=0;  jmp=0; sto=1;  end
					 {sel,rd , ld_ir,halt,inc_pc, ld_ac,ld_pc,wr ,data_e}={1'b0, ALUOP,3'b000,ALUOP,jmp,sto,sto};		 
					end
            end
endmodule




			
	    