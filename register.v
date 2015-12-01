module register(opc_iraddr,data ,ena,clk1,rst);
output [15:0] opc_iraddr;
input [7:0] data;
input ena, clk1,rst;

reg [15:0] opc_iraddr;
reg state;

always @(posedge clk1)
if(rst)
	begin 
		opc_iraddr =16'h0000;
		state<=0;
    end
else 
begin 
	if(ena) //LOAD_IR
	case(state)
		1'b0: 
			begin 
				opc_iraddr[15:8]<=data;
				state=1;
			end
		1'b1: 
			begin 
				opc_iraddr[7:0]<=data;
				state=0;
			end
		default: 
			begin 
				opc_iraddr[15:0]<=16'hxxxx;
				state=1'bx;
			end
	endcase
	else
		state <=0;
end
endmodule