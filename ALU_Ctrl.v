//Subject:     CO project 2 - ALU Controller
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module ALU_Ctrl(
          funct_i,
          ALUOp_i,
          Bonus_o,
          ALUCtrl_o
          );
          
//I/O ports 
input      [6-1:0] funct_i;
input      [3-1:0] ALUOp_i;
output     [3-1:0] Bonus_o;
output     [4-1:0] ALUCtrl_o;    
     
//Internal Signals
reg        [4-1:0] ALUCtrl_o;
reg		   [3-1:0] Bonus_o;

//--- 4bit-Parameter from decoder -----
parameter R_type 		= 3'b000;
parameter JUMP_TYPE 	= 3'b111;
parameter Branch_type 	= 3'b110;
parameter DM_type		= 3'b100;
parameter ADDI 			= 3'b001;
parameter SLTI 			= 3'b010;
parameter LUI 			= 3'b011;
parameter ORI 			= 3'b100;

/*parameter ADDI = 4'b0001;
parameter SLTI = 4'b0010;
parameter LUI = 4'b0011;
parameter ORI = 4'b0100;
parameter BEQ = 4'b0101;
parameter BNE = 4'b0110;
parameter BGT = 4'b0111;
parameter BGEZ = 4'b1000;
parameter LW = 4'b1001;
parameter SW = 4'b1010;*/


//---4bit-Parameter sending to ALU-----
parameter op_AND 	 = 4'b0000;
parameter op_OR  	 = 4'b0001;
parameter op_ADD  	 = 4'b0010;
parameter op_SUB  	 = 4'b0011;
parameter op_SLT  	 = 4'b0100;
parameter op_SLL  	 = 4'b0101;
parameter op_SRLV 	 = 4'b0110;
parameter op_LUI 	 = 4'b0111;
parameter op_MUL	 = 4'b1001;
parameter op_JUMP 	 = 4'b1010;

//---6bit-Parameter-----
parameter ADD = 6'b100000;
parameter SUB = 6'b100010;
parameter AND = 6'b100100;
parameter OR = 6'b100101;
parameter SLT = 6'b101010;
parameter SLL = 6'b000000;
parameter SRLV = 6'b000110;
parameter MUL = 6'b011000;
parameter JR = 6'b001000;

//Select exact operation
always @(*) begin
	Bonus_o <= 3'b000;
	case (ALUOp_i)
		//jump x, JA o
		R_type:begin
			case (funct_i)
				ADD: 	ALUCtrl_o <= op_ADD;
				SUB: 	ALUCtrl_o <= op_SUB;
				AND: 	ALUCtrl_o <= op_AND;
				OR: 	ALUCtrl_o <= op_OR;
				SLT: 	ALUCtrl_o <= op_SLT;
				SLL: 	ALUCtrl_o <= op_SLL;
				SRLV: 	ALUCtrl_o <= op_SRLV;
				MUL: 	ALUCtrl_o <= op_MUL;
				JR:begin
					ALUCtrl_o <= op_JUMP;
					Bonus_o <= 3'b100;
				end	
			endcase
		end
		ADDI: 			ALUCtrl_o <= op_ADD;
		SLTI: 			ALUCtrl_o <= op_SLT;
		LUI: 			ALUCtrl_o <= op_LUI;
		//ORI: 			ALUCtrl_o <= op_OR;
		Branch_type:	ALUCtrl_o <= op_SUB;
		DM_type:		ALUCtrl_o <= op_ADD;
		JUMP_TYPE:		ALUCtrl_o <= op_JUMP;

		default: ALUCtrl_o <= ALUCtrl_o;
		
	endcase
end
endmodule     




		/*BEQ: ALUCtrl_o <= op_SUB;
		BNE: ALUCtrl_o <= op_SUB;
		BGT: ALUCtrl_o <= op_SUB;
		BGEZ: ALUCtrl_o<= op_SUB;

		LW: ALUCtrl_o<= op_ADD;
		SW: ALUCtrl_o<= op_ADD;

		JUMP:ALUCtrl_o<=op_JUMP;*/


                    
                    