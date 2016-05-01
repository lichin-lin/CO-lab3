//Subject:     CO project 2 - Register File
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
module Reg_File(
    clk_i,
	rst_i,
    RSaddr_i,
    RTaddr_i,
    RDaddr_i,
    RDdata_i,
    RegWrite_i,
	R0  ,
	R1  ,
	R2  ,
	R3  ,
	R4  ,
	R5  ,
	R6  ,
	R7  ,
	R8  ,
	R9  ,
	R10 ,
	R11 ,
	R12 ,
	R13 ,
	R14 ,
	R15 ,
	R16 ,
	R17 ,
	R18 ,
	R19 ,
	R20 ,
	R21 ,
	R22 ,
	R23 ,
	R24 ,
	R25 ,
	R26 ,
	R27 ,
	R28 ,
	R29 ,
	R30 ,
	R31 ,
    RSdata_o,
    RTdata_o
    );
          
//I/O ports
input           clk_i;
input           rst_i;
input           RegWrite_i;
input  [5-1:0]  RSaddr_i;
input  [5-1:0]  RTaddr_i;
input  [5-1:0]  RDaddr_i;
input  [32-1:0] RDdata_i;
output [32-1:0]	R0 ;
output [32-1:0]	R1 ;
output [32-1:0]	R2 ;
output [32-1:0]	R3 ;
output [32-1:0]	R4 ;
output [32-1:0]	R5 ;
output [32-1:0]	R6 ;
output [32-1:0]	R7 ;
output [32-1:0]	R8 ;
output [32-1:0]	R9 ;
output [32-1:0]	R10;
output [32-1:0]	R11;
output [32-1:0]	R12;
output [32-1:0]	R13;
output [32-1:0]	R14;
output [32-1:0]	R15;
output [32-1:0]	R16;
output [32-1:0]	R17;
output [32-1:0]	R18;
output [32-1:0]	R19;
output [32-1:0]	R20;
output [32-1:0]	R21;
output [32-1:0]	R22;
output [32-1:0]	R23;
output [32-1:0]	R24;
output [32-1:0]	R25;
output [32-1:0]	R26;
output [32-1:0]	R27;
output [32-1:0]	R28;
output [32-1:0]	R29;
output [32-1:0]	R30;
output [32-1:0]	R31;


output [32-1:0] RSdata_o;
output [32-1:0] RTdata_o;   

//Internal signals/registers           
reg  signed [32-1:0] Reg_File [0:32-1];     //32 word registers
wire        [32-1:0] RSdata_o;
wire        [32-1:0] RTdata_o;

//Read the data
assign RSdata_o = Reg_File[RSaddr_i] ;
assign RTdata_o = Reg_File[RTaddr_i] ;   

//Writing data when positive edge clk_i and RegWrite_i was set.
always @(negedge rst_i or posedge clk_i  ) begin
    if(rst_i == 0) begin
	    Reg_File[0]  <= 0; Reg_File[1]  <= 0; Reg_File[2]  <= 0; Reg_File[3]  <= 0;
	    Reg_File[4]  <= 0; Reg_File[5]  <= 0; Reg_File[6]  <= 0; Reg_File[7]  <= 0;
        Reg_File[8]  <= 0; Reg_File[9]  <= 0; Reg_File[10] <= 0; Reg_File[11] <= 0;
	    Reg_File[12] <= 0; Reg_File[13] <= 0; Reg_File[14] <= 0; Reg_File[15] <= 0;
        Reg_File[16] <= 0; Reg_File[17] <= 0; Reg_File[18] <= 0; Reg_File[19] <= 0;      
        Reg_File[20] <= 0; Reg_File[21] <= 0; Reg_File[22] <= 0; Reg_File[23] <= 0;
        Reg_File[24] <= 0; Reg_File[25] <= 0; Reg_File[26] <= 0; Reg_File[27] <= 0;
        Reg_File[28] <= 0; Reg_File[29] <= 128; Reg_File[30] <= 0; Reg_File[31] <= 0;
	end
    else begin
        if(RegWrite_i) 
            Reg_File[RDaddr_i] <= RDdata_i;	
		else 
		    Reg_File[RDaddr_i] <= Reg_File[RDaddr_i];
	end
end

assign R0  = Reg_File[0];
assign R1  = Reg_File[1];
assign R2  = Reg_File[2];
assign R3  = Reg_File[3];
assign R4  = Reg_File[4];
assign R5  = Reg_File[5];
assign R6  = Reg_File[6];
assign R7  = Reg_File[7];
assign R8  = Reg_File[8];
assign R9  = Reg_File[9];
assign R10 = Reg_File[10];
assign R11 = Reg_File[11];
assign R12 = Reg_File[12];
assign R13 = Reg_File[13];
assign R14 = Reg_File[14];
assign R15 = Reg_File[15];
assign R16 = Reg_File[16];
assign R17 = Reg_File[17];
assign R18 = Reg_File[18];
assign R19 = Reg_File[19];
assign R20 = Reg_File[20];
assign R21 = Reg_File[21];
assign R22 = Reg_File[22];
assign R23 = Reg_File[23];
assign R24 = Reg_File[24];
assign R25 = Reg_File[25];
assign R26 = Reg_File[26];
assign R27 = Reg_File[27];
assign R28 = Reg_File[28];
assign R29 = Reg_File[29];
assign R30 = Reg_File[30];
assign R31 = Reg_File[31];

endmodule     





                    
                    