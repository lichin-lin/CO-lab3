//Subject:     CO project 2 - ALU
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer: lichin,lin     
//----------------------------------------------
//Date: 2016/04/20     
//----------------------------------------------
//Description: implement all function for simple ALU.
//--------------------------------------------------------------------------------

module ALU(
	//rst_n,  //here is reset. 
    src1_i,	//32-bit input 1
	src2_i,	//32-bit input 2
	ctrl_i, //ALU-controller
	bonus_i,
	result_o, //32-bit output
	zero_o	//set zero
	);
     
//I/O ports
//input rst_n;
input  [32-1:0]  src1_i;
input  [32-1:0]  src2_i;
input  [4-1:0]   ctrl_i;
input  [3-1:0]   bonus_i;
output [32-1:0]  result_o;
output           zero_o;

//Internal signals
wire             zero_o;
reg[32-1:0]  	 result_o;

//Parameter
parameter ALU_AND = 4'b0000, ALU_OR = 4'b0001, ALU_ADD  = 4'b0010, ALU_SUB = 4'b0011,  ALU_SLT = 4'b0100, ALU_SLL = 4'b0101, ALU_SRLV = 4'b0110,ALU_LUI= 4'b0111;
parameter ALU_MUL = 4'b1001, ALU_JR = 4'b1010;
assign zero_o = (result_o == 0);

//Main function
always @(*) begin
	case (ctrl_i)
		ALU_AND : 	 result_o <= src1_i & src2_i;
		ALU_OR  : 	 result_o <= src1_i | src2_i;
		ALU_ADD : 	 result_o <= src1_i + src2_i;
		ALU_SUB : 	 result_o <= (src1_i - src2_i);
		ALU_SLL : 	 result_o <= src2_i<<src1_i;
		ALU_SRLV: 	 result_o <= src2_i>>src1_i;
		ALU_SLT : 	 result_o <= (src1_i < src2_i) ? 1 : 0;
		ALU_LUI : 	 result_o <= src2_i<<16;
		ALU_MUL :	 result_o <= src1_i * src2_i;
		//ALU_JR:;

		default : result_o <= result_o;
	endcase
end
endmodule


                    
                    