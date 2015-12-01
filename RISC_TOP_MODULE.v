module RISC_TOP_MODULE(clk1,fetch,zero,clk,reset,halt,rd,wr,ir_addr,pc_addr,addr,data,inc_pc,rom_sel,ram_sel, accum,load_acc,datactl_ena,opcode,alu_clk);
input clk,reset;
output zero,rd,wr, halt,inc_pc,rom_sel,ram_sel,load_acc,datactl_ena,alu_clk,/**/clk1,fetch,pc_addr;
output[12:0]ir_addr,addr;
output[2:0]opcode;
output [7:0]data,accum;
wire clk,reset,halt;
wire [7:0] data;
wire [12:0] addr;
wire rd,wr;
wire clk1,fetch,alu_clk;
wire [2:0] opcode;
wire [12:0] ir_addr,pc_addr;
wire [7:0] alu_out,accum;
wire zero,inc_pc,load_acc,load_pc,load_ir,data_ena,contr_ena;
wire [15:0]opc_iraddr;



assign opcode=opc_iraddr[15:13];
assign ir_addr=opc_iraddr[12:0];


clk_gen 	m_clk_gen(.clk(clk),.reset(reset),.clk1(clk1),.clk2(clk2),.clk4(clk4),.fetch(fetch),.alu_clk(alu_clk));

register 	m_register(.opc_iraddr(opc_iraddr),.data(data) ,.ena(load_ir),.clk1(clk1),.rst(reset));

accum  		m_accum(.accum(accum),.data(alu_out),.ena(load_acc),.clk1(clk1),.rst(reset));

alu 		m_alu(.alu_out(alu_out),.zero(zero),.opcode(opcode),.data(data),.accum(accum),.alu_clk(alu_clk));

machinectl 	m_machinectl(.ena(ena),.fetch(fetch),.rst(reset));

machine 	m_machine(.inc_pc(inc_pc), .load_acc(load_acc ), .load_pc(load_pc ),.rd(rd),.wr(wr),.load_ir(load_ir ),.datactl_ena(datactl_ena ),.halt (halt), .clk1 (clk1), .zero (zero), .ena (ena ),.opcode(opcode));

datactl		m_datactl(.data(data),.in (alu_out),.data_ena(datactl_ena));

counter 	m_counter(.pc_addr(pc_addr ),.ir_addr(ir_addr ),.load(load_pc),.clock(inc_pc),.rst(reset));//.op(opcode) .op(opc_iraddr[12:0]),

adr 		m_adr(.addr (addr),.fetch (fetch),.ir_addr (ir_addr ),.pc_addr (pc_addr ));

addr_decode addr_decode1(addr,rom_sel,ram_sel);

ram 		ram1(.clk(clk),.data(data),.addr(addr),.ena(ram_sel),.read(rd),.write(wr));

rom 		rom1(.data(data),.addr(addr),.read(rd),.ena(rom_sel));

endmodule