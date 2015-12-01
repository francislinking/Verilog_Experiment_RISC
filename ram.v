module ram(clk,data,addr,ena,read,write);
input clk;
inout [7:0] data;
input [9:0] addr;
input ena;
input read,write;
wire [7:0] temp;
//reg [7:0] ram[10'h3ff:0];

assign data=(read&&ena)?temp[7:0]:8'hzz;

ram_72 U1(
	.clock(clk),
	.data(),
	.rdaddress(addr),
	.rden(read),
	.wraddress(addr),
	.wren(write),
	.q(temp));


endmodule 