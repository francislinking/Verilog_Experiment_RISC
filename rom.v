module rom(data,addr,read,ena);
output [7:0] data;
input [12:0] addr;
input read,ena;
//reg [7:0] memory[13'h1fff:0];

wire [7:0] temp;
assign data=(read&&ena)?temp[7:0]:8'bzzzz_zzzz;

rom_72 U1(
	.address(addr),
	.q(temp));
	
endmodule 