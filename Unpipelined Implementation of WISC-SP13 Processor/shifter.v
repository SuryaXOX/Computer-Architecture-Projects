module shifter (In, Cnt, Op, Out);
   
   input [15:0] In;
   input [3:0]  Cnt;
   input [1:0]  Op;
   output [15:0] Out;

//////////////////////////////////////////////////////////
//		00 Rotate Left				//
//		01 Shift Right Logical			//
//		10 Shift Right Arithmetic		//
//		11 Shift Left Logical			//
//////////////////////////////////////////////////////////

   wire [15:0] firstMuxInput1, firstMuxOut, secondMuxInput1, secondMuxOut, thirdMuxInput1, thirdMuxOut, fourthMuxInput1, fourthMuxOut;

   mux4_1_16 i4to1MUX1(.S(Op), .out(firstMuxInput1), .A({In[14:0], In[15]}), .B({In[14:0], 1'b0}), .C({In[0], In[15:1]}), .D({1'b0, In[15:1]}));
   mux2_1_16 i2to1MUX1(.S(Cnt[0]), .out(firstMuxOut), .A(In), .B(firstMuxInput1));

   mux4_1_16 i4to1MUX2(.S(Op), .out(secondMuxInput1), .A({firstMuxOut[13:0], firstMuxOut[15:14]}), .B({firstMuxOut[13:0], 2'b00}), .C({firstMuxOut[1:0], firstMuxOut[15:2]}), .D({2'b00, firstMuxOut[15:2]}));
   mux2_1_16 i2to1MUX2(.S(Cnt[1]), .out(secondMuxOut), .A(firstMuxOut), .B(secondMuxInput1));

   mux4_1_16 i4to1MUX3(.S(Op), .out(thirdMuxInput1), .A({secondMuxOut[11:0], secondMuxOut[15:12]}), .B({secondMuxOut[11:0], 4'h0}), .C({secondMuxOut[3:0], secondMuxOut[15:4]}), .D({4'h0, secondMuxOut[15:4]}));
   mux2_1_16 i2to1MUX3(.S(Cnt[2]), .out(thirdMuxOut), .A(secondMuxOut), .B(thirdMuxInput1));

   mux4_1_16 i4to1MUX4(.S(Op), .out(fourthMuxInput1), .A({thirdMuxOut[7:0], thirdMuxOut[15:8]}), .B({thirdMuxOut[7:0], 8'h00}), .C({thirdMuxOut[7:0], thirdMuxOut[15:8]}), .D({8'h00, thirdMuxOut[15:8]}));
   mux2_1_16 i2to1MUX4(.S(Cnt[3]), .out(fourthMuxOut), .A(thirdMuxOut), .B(fourthMuxInput1));

   assign Out = fourthMuxOut;
endmodule


