module accum(accum,data,ena,clk1,rst);
output [7:0] accum;
input [7:0] data;
input ena,clk1,rst ;
reg [7:0] accum;
always @(posedge clk1)
if(rst)
	 accum <=8'b0;
else  if (ena)                     //LOAD_ACC
	 accum <=data;
endmodule