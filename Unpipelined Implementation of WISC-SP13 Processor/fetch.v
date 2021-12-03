module fetch ( clk, rst, halt, pc, nxt_pc, instr);
  
  input clk, rst;
  input [15:0] pc;
  input halt;
  output [15:0] nxt_pc;
  output [15:0] instr;

  wire [15:0] cur_pc; 

/////////////////////////////////////////////////////
// 	 A PC REG HOLDS PC UPON HALT ASSERTION     //
/////////////////////////////////////////////////////
  reg_16 iPC_REG (.clk(clk), .rst(rst), .en_w_or_r(~halt), .in(pc), .out(cur_pc));

/////////////////////////////////////////
// 	   INSTRUCTION MEMORY          //
/////////////////////////////////////////
  memory2c iINSTR_MEM (.data_out(instr), .data_in(16'h0000), .addr(cur_pc), .enable(1'b1), .wr(1'b0), .createdump(halt), .clk(clk), .rst(rst));

/////////////////////////////////////////
// 	     PC = PC +2	   	       //
/////////////////////////////////////////
  cla_16 iPC_INC (.A(cur_pc), .B(16'h0002), .cin(1'b0), .sum(nxt_pc), .cout(), .P_out(), .G_out());


endmodule
