//Subject:     CO project 2 - Decoder
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module Decoder(
    instr_op_i,
	RegWrite_o,
	ALU_op_o,
	ALUSrc_o,
	RegDst_o,
	Branch_o,
    sign_o,
    BranchType_o,
    Jump_o,
    MemRead_o,
    MemWrite_o,
    MemtoReg_o,
	);
     
//I/O ports
input  [6-1:0] instr_op_i;

output reg        RegWrite_o;
output reg[3-1:0] ALU_op_o;
output reg        ALUSrc_o;
output reg[2-1:0] RegDst_o;
output reg        Branch_o;
output reg		   sign_o;
output reg[2-1:0] BranchType_o;
output reg		   Jump_o;
output reg		   MemRead_o;
output reg		   MemWrite_o;
output reg[2-1:0] MemtoReg_o;
 
//Internal Signals

//Parameter
reg [14:0]case_result;
always @(*) begin
	{RegWrite_o,Branch_o,RegDst_o,ALU_op_o,sign_o,BranchType_o,Jump_o,MemRead_o,MemWrite_o,MemtoReg_o} <= case_result;
end
//Main function
always @(*) begin
	ALUSrc_o <= (instr_op_i[3]|instr_op_i[5]);

	if (instr_op_i == 0)case_result 	 <= 15'b10_01_000_1_00_000_00;	// R-type; 	000000

	else if(instr_op_i == 8)case_result  <= 15'b10_00_001_0_00_000_00;  // ADDi; 	001000
		
	else if(instr_op_i == 10)case_result <= 15'b10_00_010_1_00_000_00;  // SLTI; 	001010
		
	else if(instr_op_i == 15)case_result <= 15'b10_00_011_1_00_000_00;  // LUI; 	001111
		
	else if(instr_op_i == 13)case_result <= 15'b10_00_100_0_00_000_00; 	// ORI; 	001101

	/*----- branch type -----*/	
	else if(instr_op_i == 4)case_result  <= 15'b01_01_110_0_00_000_00; 	// BEQ; 	000100
		
	else if(instr_op_i == 5)case_result  <= 15'b01_01_110_0_11_000_00; 	// BNE; 	000101

	else if(instr_op_i == 7)case_result  <= 15'b01_01_110_0_01_000_00; 	// BGT;  	000111

	else if(instr_op_i == 1)case_result  <= 15'b01_01_110_0_10_000_00; 	// BGEZ; 	000001

	/*----- data memory access-----*/	
	else if(instr_op_i == 35)case_result <= 15'b10_00_100_1_00_010_01; 	// lw; 		100011
		
	else if(instr_op_i == 43)case_result <= 15'b00_00_100_1_00_001_00; 	// sw; 		101011

	/*----- Jump type -----*/	
	else if(instr_op_i == 2)case_result  <= 15'b01_01_111_1_00_100_00; 	// jump; 	000010

	else if(instr_op_i == 3)case_result  <= 15'b11_11_111_1_00_100_11; 	// JAL:  	000011
	
																		// JR:		

end

endmodule
                    
                    