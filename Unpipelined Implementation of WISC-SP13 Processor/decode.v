module decode (instr, writeData, clk, rst, se_5, ze_5, se_8, ze_8, se_11, se, A, B, srcALU, memWrite, memtoreg, inv_A, inv_B, cin, halt);

  input clk, rst;
  input [15:0] instr;
  input [15:0] writeData;
  output [15:0] A, B;
  output inv_A, inv_B;
  output cin;
  output halt;
  output [1:0] srcALU;
  output memWrite, memtoreg;
  output [15:0] se_5, ze_5, se_8, ze_8, se_11;
  output se;

  wire RegWrite;
  wire [1:0] RegDst;
  wire [2:0] writeregsel;

//////////////////////////////////////////////////
// 	     WRITE REGISTER SELECT              //
//////////////////////////////////////////////////
  mux4_1_3 SEL_REG (.A(instr[4:2]), .B(instr[7:5]), .C(instr[10:8]), .D(3'b111), .S(RegDst), .out(writeregsel));


//////////////////////////////////////////////////
// 	 	 SIGN EXTEND LOGIC              //
//////////////////////////////////////////////////
  assign se_5 = {{11{instr[4]}}, instr[4:0]};
  assign ze_5 = {{11{1'b0}}, instr[4:0]};
  assign se_8 = {{8{instr[7]}}, instr[7:0]};
  assign ze_8 = {{8{1'b0}}, instr[7:0]};
  assign se_11 = {{5{instr[10]}}, instr[10:0]};


//////////////////////////////////////////////////
// 	  	 CONTROL LOGIC                  //
//////////////////////////////////////////////////
  control iCNTRL (.instr(instr), .srcALU(srcALU), .RegDst(RegDst), .memWrite(memWrite), .RegWrite(RegWrite), .memtoreg(memtoreg), .inv_A(inv_A), .inv_B(inv_B), .Cin(cin), .se(se), .halt(halt));


///////////////////////////////////////////////////
// 	   READ1DATA, READ2DATA, WRITEDATA       //
///////////////////////////////////////////////////
  rf regFile0 (.read1data(A), .read2data(B), .clk(clk), .rst(rst), .read1regsel(instr[10:8]), .read2regsel(instr[7:5]), .writeregsel(writeregsel), .writedata(writeData), .write(RegWrite));


endmodule
