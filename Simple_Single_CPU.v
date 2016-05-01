//Subject:     CO project 2 - Simple Single CPU
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
module Simple_Single_CPU(
        clk_i,
        rst_i
);
		
//I/O port
input         clk_i;
input         rst_i;

//Internal Signles

//MUX_2to1 #(.size(32)) Mux_Return
wire [2:0] BonusControl;
//ProgramCounter PC
wire [31:0] pc_init,pc_output;

//Adder Adder1
wire [31:0] pc_output_Add_Four;

//Instr_Memory IM
wire [31:0] instr_init;

//MUX_2to1 Mux_Write_Reg(size5)
wire [4:0] Reg_to_write;
wire [1:0] Reg_write_For_Mux;

//Reg_File RF
wire [31:0] write_data,Read_data_1,Read_data_2;
wire Reg_write_For_Rg;

//Decoder Decoder
wire [2:0] Decoder_ALU_opcode;  //change from 3bit -> 4bit.
wire [1:0] BranchType_output,MemtoReg_output;
wire Decoder_ALU_Src,Decoder_branch;
wire MemRead_output,MemWrite_output,Jump_output,sign_output;

//ALU_Ctrl AC
wire [3:0] ALU_ctrl_output;

//Sign_Extend SE
wire [15:0] Sign_Extend_16bit;
wire [31:0] Sign_Extend_32bit;
assign Sign_Extend_16bit = instr_init[15:0];

//MUX_2to1 Mux_ALUSrc(size32)
wire [31:0] Sign_Extend_Read_data_select_one;

//ALU ALU
wire ALU_zero;

//Data_Memory DM
wire [31:0] Data_Memory_output;

//MUX_4to1 #(.size(32)) Mux_Write_back_Reg_Src
wire [31:0] Data_Memory_Mux_select_to_Write_back;

//Result_Zero_Mux
wire four_to_one_zero_select;

//Adder Adder2
wire [31:0] ready_go_back;

//Shift_Left_Two_32 Shifter
wire [31:0] Sign_Extend_32bit_After_Shift2;

//MUX_2to1 Mux_PC_Source(size32)

//Mux_jump
wire [31:0] pc_finally_go_back;
wire [31:0] pc_select_with_jump;
wire [31:0] PCout_Or_WriteData;
wire [31:0] pc_JR;
wire [31:0] pc_in_concidered_JR;
wire 		THIS_IS_JR            ;
wire 		THIS_IS_ADD         ;
wire 		THIS_IS_ADDI        ;
wire 		THIS_IS_JAL         ;
wire 		THIS_IS_J            ;
wire 		THIS_IS_SW          ;
wire 		THIS_IS_BEQ           ;
wire 		THIS_IS_LW         ;

assign pc_JR = Read_data_1;
assign THIS_IS_JR    = (instr_init[5:0]==6'b001000 && instr_init[31:26]==0)?1:0;
assign THIS_IS_ADD   = (instr_init[5:0]==6'b100000 && instr_init[31:26]==0)?1:0;
assign THIS_IS_ADDI  = (instr_init[31:26]==6'b001000)?1:0;
assign THIS_IS_JAL   = (instr_init[31:26]==6'b000011)?1:0;
assign THIS_IS_J     = (instr_init[31:26]==6'b000010)?1:0;
assign THIS_IS_SW    = (instr_init[31:26]==6'b101011)?1:0;
assign THIS_IS_BEQ   = (instr_init[31:26]==6'b000100)?1:0;
assign THIS_IS_LW    = (instr_init[31:26]==6'b100011)?1:0;

//For Debug
wire	[5:0]	InstrToDecoder;
assign InstrToDecoder = instr_init[31:26];
wire	[5:0] Reg1, Reg2;
assign Reg1 = instr_init[25:21];
assign Reg2 = instr_init[20:16];

wire [31:0]  R0_zero ;
wire [31:0]  R1_at    ;
wire [31:0]  R2_v0    ;
wire [31:0]  R3_v1    ;
wire [31:0]  R4_a0    ;
wire [31:0]  R5_a1    ;
wire [31:0]  R6_a2    ;
wire [31:0]  R7_a3    ;
wire [31:0]  R8_t0    ;
wire [31:0]  R9_t1    ;
wire [31:0] R10_t2   ;
wire [31:0] R11_t3   ;
wire [31:0] R12_t4   ;
wire [31:0] R13_t5   ;
wire [31:0] R14_t6   ;
wire [31:0] R15_t7   ;
wire [31:0] R16_s0   ;
wire [31:0] R17_s1   ;
wire [31:0] R18_s2   ;
wire [31:0] R19_s3   ;
wire [31:0] R20_s4   ;
wire [31:0] R21_s5   ;
wire [31:0] R22_s6   ;
wire [31:0] R23_s7   ;
wire [31:0] R24_t8   ;
wire [31:0] R25_t9   ;
wire [31:0] R26_k0   ;
wire [31:0] R27_k1   ;
wire [31:0] R28_gp   ;
wire [31:0] R29_sp   ;
wire [31:0] R30_fp   ;
wire [31:0] R31_ra   ;
wire [31:0] memory0 ;
wire [31:0] memory1 ;
wire [31:0] memory2 ;
wire [31:0] memory3 ;
wire [31:0] memory4 ;
wire [31:0] memory5 ;
wire [31:0] memory6 ;
wire [31:0] memory7 ;
wire [31:0] memory8 ;
wire [31:0] memory9 ;
wire [31:0] memory10;
wire [31:0] memory11;
wire [31:0] memory12;
wire [31:0] memory13;
wire [31:0] memory14;
wire [31:0] memory15;
wire [31:0] memory16;
wire [31:0] memory17;
wire [31:0] memory18;
wire [31:0] memory19;
wire [31:0] memory20;
wire [31:0] memory21;
wire [31:0] memory22;
wire [31:0] memory23;
wire [31:0] memory24;
wire [31:0] memory25;
wire [31:0] memory26;
wire [31:0] memory27;
wire [31:0] memory28;
wire [31:0] memory29;
wire [31:0] memory30;
wire [31:0] memory31;
//Main function
MUX_2to1 #(.size(32)) Mux_Return(
        .data0_i(pc_finally_go_back),
        .data1_i(Read_data_1),
        .select_i(BonusControl[2]),
        .data_o(pc_init)
        );
		
MUX_2to1 #(.size(32)) Mux_Return_FOR_JR(
        .data0_i(pc_init),
        .data1_i(pc_JR),
        .select_i(THIS_IS_JR),
        .data_o(pc_in_concidered_JR)
        );
		
ProgramCounter PC(
        .clk_i(clk_i),      
	    .rst_i (rst_i),     
	    .pc_in_i(pc_in_concidered_JR) ,   
	    .pc_out_o(pc_output) 
	    );
	
Adder Adder1(
        .src1_i(32'd4),     
	    .src2_i(pc_output),     
	    .sum_o(pc_output_Add_Four)    
	    );
	
Instr_Memory IM(
        .pc_addr_i(pc_output),  
	    .instr_o(instr_init)    
	    );

MUX_4to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(instr_init[20:16]),
        .data1_i(instr_init[15:11]),
        .data2_i(32'd31),
        .data3_i(32'd31),
        .select_i(Reg_write_For_Mux),
        .data_o(Reg_to_write)
        );	

wire Reg_write_For_Rg_considered_JR;
assign Reg_write_For_Rg_considered_JR = (THIS_IS_JR)?0:Reg_write_For_Rg;
Reg_File RF(
        .clk_i(clk_i),      
	    .rst_i(rst_i) ,     
        .RSaddr_i(instr_init[25:21]) ,  
        .RTaddr_i(instr_init[20:16]) ,  
        .RDaddr_i(Reg_to_write) ,  
        .RDdata_i(PCout_Or_WriteData), 
        .RegWrite_i (Reg_write_For_Rg_considered_JR),
		.R0 ( R0_zero ),
		.R1 ( R1_at   ),
		.R2 ( R2_v0   ),
		.R3 ( R3_v1   ),
		.R4 ( R4_a0   ),
		.R5 ( R5_a1   ),
		.R6 ( R6_a2   ),
		.R7 ( R7_a3   ),
		.R8 ( R8_t0   ),
		.R9 ( R9_t1   ),
		.R10(R10_t2   ),
		.R11(R11_t3   ),
		.R12(R12_t4   ),
		.R13(R13_t5   ),
		.R14(R14_t6   ),
		.R15(R15_t7   ),
		.R16(R16_s0   ),
		.R17(R17_s1   ),
		.R18(R18_s2   ),
		.R19(R19_s3   ),
		.R20(R20_s4   ),
		.R21(R21_s5   ),
		.R22(R22_s6   ),
		.R23(R23_s7   ),
		.R24(R24_t8   ),
		.R25(R25_t9   ),
		.R26(R26_k0   ),
		.R27(R27_k1   ),
		.R28(R28_gp   ),
		.R29(R29_sp   ),
		.R30(R30_fp   ),
		.R31(R31_ra   ),
        .RSdata_o(Read_data_1) ,  
        .RTdata_o(Read_data_2)   
        );
	
Decoder Decoder(
        .instr_op_i(InstrToDecoder), 
	    .RegWrite_o(Reg_write_For_Rg), 
	    .ALU_op_o(Decoder_ALU_opcode),   
	    .ALUSrc_o(Decoder_ALU_Src),   
	    .RegDst_o(Reg_write_For_Mux),   
	    .Branch_o(Decoder_branch),
            .sign_o(sign_output),
            .BranchType_o(BranchType_output),
            .Jump_o(Jump_output),
            .MemRead_o(MemRead_output),
            .MemWrite_o(MemWrite_output),
            .MemtoReg_o(MemtoReg_output)
	    );

MUX_2to1 #(.size(32)) Mux_WriteData_FOR_JAL(
        .data0_i(Data_Memory_Mux_select_to_Write_back),
        .data1_i(pc_output_Add_Four),
        .select_i(Reg_write_For_Mux[1]),
        .data_o(PCout_Or_WriteData)
        );	
		
		
ALU_Ctrl AC(
        .funct_i(instr_init[5:0]),   
        .ALUOp_i(Decoder_ALU_opcode),   
        .Bonus_o(BonusControl),
        .ALUCtrl_o(ALU_ctrl_output) 
        );
		
Sign_Extend SE(
        .data_i(Sign_Extend_16bit),
        .sign_i(sign_output),
        .data_o(Sign_Extend_32bit)
        );

MUX_2to1 #(.size(32)) Mux_ALUSrc(
        .data0_i(Read_data_2),
        .data1_i(Sign_Extend_32bit),
        .select_i(Decoder_ALU_Src),
        .data_o(Sign_Extend_Read_data_select_one)
        );	

wire [32-1:0] ALU_normal_case;	
ALU ALU(
        .src1_i(ALU_normal_case),
	    .src2_i(Sign_Extend_Read_data_select_one),
	    .ctrl_i(ALU_ctrl_output),
        .bonus_i(BonusControl),
	    .result_o(write_data),
		.zero_o(ALU_zero)
	    );

		
		
Data_Memory DM(
    .clk_i(clk_i),
    .addr_i(write_data),
    .data_i(Read_data_2),
    .MemRead_i(MemRead_output),
    .MemWrite_i(MemWrite_output),
	.memory0 (memory0 ),
	.memory1 (memory1 ),
	.memory2 (memory2 ),
	.memory3 (memory3 ),
	.memory4 (memory4 ),
	.memory5 (memory5 ),
	.memory6 (memory6 ),
	.memory7 (memory7 ),
	.memory8 (memory8 ),
	.memory9 (memory9 ),
	.memory10(memory10),
	.memory11(memory11),
	.memory12(memory12),
	.memory13(memory13),
	.memory14(memory14),
	.memory15(memory15),
	.memory16(memory16),
	.memory17(memory17),
	.memory18(memory18),
	.memory19(memory19),
	.memory20(memory20),
	.memory21(memory21),
	.memory22(memory22),
	.memory23(memory23),
	.memory24(memory24),
	.memory25(memory25),
	.memory26(memory26),
	.memory27(memory27),
	.memory28(memory28),
	.memory29(memory29),
	.memory30(memory30),
	.memory31(memory31),
    .data_o(Data_Memory_output)
    );

//select one to write back Reg.
MUX_4to1 #(.size(32)) Mux_Write_back_Reg_Src(
        .data0_i(write_data),
        .data1_i(Data_Memory_output),
        .data2_i(Sign_Extend_32bit),
        .data3_i(pc_output_Add_Four),
        .select_i(MemtoReg_output),
        .data_o(Data_Memory_Mux_select_to_Write_back)
        );

MUX_4to1 #(.size(1)) Result_Zero_Mux(
        .data0_i(ALU_zero),
        .data1_i(~(ALU_zero | write_data[31])),
        .data2_i(~write_data[31]),
        .data3_i(~ALU_zero),
        .select_i(BranchType_output),
        .data_o(four_to_one_zero_select)
        );

Shift_Left_Two_32 Shifter(
        .data_i(Sign_Extend_32bit),
        .data_o(Sign_Extend_32bit_After_Shift2)
        );      

Adder Adder2(
        .src1_i(pc_output_Add_Four),     
	    .src2_i(Sign_Extend_32bit_After_Shift2),     
	    .sum_o(ready_go_back)      
	    );	
		
MUX_2to1 #(.size(32)) Mux_PC_Source(
        .data0_i(pc_output_Add_Four),
        .data1_i(ready_go_back),
        .select_i(Decoder_branch & four_to_one_zero_select),
        .data_o(pc_select_with_jump)
        );	
//Jump select
MUX_2to1 #(.size(32)) Mux_Jump(
        .data0_i(pc_select_with_jump),
        .data1_i({pc_output_Add_Four[31:28], instr_init[25:0], 2'b00}),
        .select_i(Jump_output),
        .data_o(pc_finally_go_back)
        );

//case:SLL rt ts sa
wire SLL_case;
wire [32-1:0] sa_for_SLL;

assign sa_for_SLL = instr_init[10:6];
assign SLL_case = (ALU_ctrl_output == 4'b1100);

MUX_2to1 #(.size(32)) ALU_case_if_SLL(
        .data0_i(Read_data_1),
        .data1_i(sa_for_SLL),
        .select_i(SLL_case),
        .data_o(ALU_normal_case)
        );

endmodule
		  


