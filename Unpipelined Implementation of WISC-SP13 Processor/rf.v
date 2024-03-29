module rf (read1data, read2data,clk, rst, read1regsel, read2regsel, writeregsel, writedata, write);

  input clk, rst;
  input [15:0] writedata;
  input [2:0] read1regsel;
  input [2:0] read2regsel;
  input [2:0] writeregsel;
  input write;
  output [15:0] read1data;
  output [15:0] read2data;

  wire [7:0] wr_sel;
  wire [7:0] wr_tmp;
  wire [15:0] rd_0, rd_1, rd_2, rd_3, rd_4, rd_5, rd_6, rd_7;

//////////////////////////////////////////////////
// 	 3:8 DECODER FOR WRITEREGSEL            //
////////////////////////////////////////////////// 
 decoder3_8 iDEC3_8 (.S(writeregsel), .out(wr_tmp));

//////////////////////////////////////////////////
// 	  	 READ1DATA/READ2DATA            //
//////////////////////////////////////////////////
  mux8_1 iMUX_1[15:0] (.A(rd_0), .B(rd_1), .C(rd_2), .D(rd_3), .E(rd_4), .F(rd_5), .G(rd_6), .H(rd_7), .S(read1regsel), .out(read1data));
  mux8_1 iMUX_2[15:0] (.A(rd_0), .B(rd_1), .C(rd_2), .D(rd_3), .E(rd_4), .F(rd_5), .G(rd_6), .H(rd_7), .S(read2regsel), .out(read2data));
 

//////////////////////////////////////////////////
// 	  	 WRITE SEL 	                //
//////////////////////////////////////////////////
  assign wr_sel[0] = wr_tmp[0] & write;
  assign wr_sel[1] = wr_tmp[1] & write;
  assign wr_sel[2] = wr_tmp[2] & write;
  assign wr_sel[3] = wr_tmp[3] & write;
  assign wr_sel[4] = wr_tmp[4] & write;
  assign wr_sel[5] = wr_tmp[5] & write;
  assign wr_sel[6] = wr_tmp[6] & write;
  assign wr_sel[7] = wr_tmp[7] & write;

//////////////////////////////////////////////////
// 	  	 8 16-BIT REGISTERS	        //
//////////////////////////////////////////////////
  reg_16 iREG16_1 (.clk(clk), .rst(rst), .en_w_or_r(wr_sel[0]), .in(writedata[15:0]), .out(rd_0[15:0]));
  reg_16 iREG16_2 (.clk(clk), .rst(rst), .en_w_or_r(wr_sel[1]), .in(writedata[15:0]), .out(rd_1[15:0]));
  reg_16 iREG16_3 (.clk(clk), .rst(rst), .en_w_or_r(wr_sel[2]), .in(writedata[15:0]), .out(rd_2[15:0]));
  reg_16 iREG16_4 (.clk(clk), .rst(rst), .en_w_or_r(wr_sel[3]), .in(writedata[15:0]), .out(rd_3[15:0]));
  reg_16 iREG16_5 (.clk(clk), .rst(rst), .en_w_or_r(wr_sel[4]), .in(writedata[15:0]), .out(rd_4[15:0]));
  reg_16 iREG16_6 (.clk(clk), .rst(rst), .en_w_or_r(wr_sel[5]), .in(writedata[15:0]), .out(rd_5[15:0]));
  reg_16 iREG16_7 (.clk(clk), .rst(rst), .en_w_or_r(wr_sel[6]), .in(writedata[15:0]), .out(rd_6[15:0]));
  reg_16 iREG16_8 (.clk(clk), .rst(rst), .en_w_or_r(wr_sel[7]), .in(writedata[15:0]), .out(rd_7[15:0]));





endmodule
