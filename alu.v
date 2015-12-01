module alu(alu_out,zero,opcode,data,accum,alu_clk);
input [2:0] opcode;
input [7:0] data,accum;
input alu_clk;
output [7:0] alu_out;
output zero;
reg [7:0] alu_out;

parameter	HLT=3'b000,
			SKZ=3'b001,
			ADD=3'b010,
			ANDD=3'b011,
			XORR=3'b100,
			LDA=3'b101,
			STO=3'b110,
			JMP=3'b111;

assign zero=!accum;

always @(posedge alu_clk)
begin
	case(opcode)
		HLT:alu_out<=accum; //HLT
		SKZ:alu_out=accum;   //SKZ
		ADD:alu_out=data+accum; //ADD
		ANDD:alu_out= data&accum; //ANDD
		XORR:alu_out=data^accum; //XORR
		LDA:alu_out= data; //LDA
		STO: alu_out= accum; //STO
		JMP: alu_out= accum; //JMP
		default:alu_out=8'bxxxxxxxx;
	endcase
end
	
endmodule