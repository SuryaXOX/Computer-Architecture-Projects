module WB (ALUres, readData, memtoreg, writeData, nxt_pc, enJAL,);

  input [15:0] ALUres;
  input [15:0] readData;
  input [15:0] nxt_pc;
  input enJAL;
  input memtoreg;
  output [15:0] writeData;

  mux4_1_16 iWB (.A(ALUres), .B(readData), .C(nxt_pc), .D(16'hXXXX), .S({enJAL, memtoreg}), .out(writeData));

endmodule

