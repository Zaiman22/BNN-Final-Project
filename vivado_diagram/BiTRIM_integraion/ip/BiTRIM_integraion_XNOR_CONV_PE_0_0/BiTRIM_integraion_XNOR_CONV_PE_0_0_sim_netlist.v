// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.1 (lin64) Build 6140274 Wed May 21 22:58:25 MDT 2025
// Date        : Tue Oct  7 21:49:52 2025
// Host        : pop-os running 64-bit Pop!_OS 22.04 LTS
// Command     : write_verilog -force -mode funcsim
//               /home/zaiman22/Documents/new-zaiman22/projek/fpga-cnn-bnn-paper/BNN-Final-Project/vivado_diagram/BiTRIM_integraion/ip/BiTRIM_integraion_XNOR_CONV_PE_0_0/BiTRIM_integraion_XNOR_CONV_PE_0_0_sim_netlist.v
// Design      : BiTRIM_integraion_XNOR_CONV_PE_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "BiTRIM_integraion_XNOR_CONV_PE_0_0,XNOR_CONV_PE,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "module_ref" *) 
(* X_CORE_INFO = "XNOR_CONV_PE,Vivado 2025.1" *) 
(* NotValidForBitStream *)
module BiTRIM_integraion_XNOR_CONV_PE_0_0
   (clk,
    rst,
    en,
    weight_control,
    side_control,
    top_control,
    start,
    top_start,
    pcountin,
    weight_in,
    intop,
    inbottom,
    inside,
    outside,
    pcountout,
    weight_out);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, ASSOCIATED_RESET rst, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN BiTRIM_integraion_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0" *) input clk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 rst RST" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME rst, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input rst;
  input en;
  input weight_control;
  input side_control;
  input top_control;
  input start;
  input top_start;
  input [3:0]pcountin;
  input weight_in;
  input intop;
  input inbottom;
  input inside;
  output outside;
  output [3:0]pcountout;
  output weight_out;

  wire clk;
  wire inbottom;
  wire inside;
  wire intop;
  wire outside;
  wire [3:0]pcountin;
  wire [3:0]pcountout;
  wire rst;
  wire side_control;
  wire start;
  wire top_control;
  wire top_start;
  wire weight_control;
  wire weight_in;
  wire weight_out;

  BiTRIM_integraion_XNOR_CONV_PE_0_0_XNOR_CONV_PE inst
       (.clk(clk),
        .inbottom(inbottom),
        .inside(inside),
        .intop(intop),
        .outside(outside),
        .pcountin(pcountin),
        .pcountout(pcountout),
        .rst(rst),
        .side_control(side_control),
        .start(start),
        .top_control(top_control),
        .top_start(top_start),
        .weight_control(weight_control),
        .weight_in(weight_in),
        .weight_out(weight_out));
endmodule

(* ORIG_REF_NAME = "XNOR_CONV_PE" *) 
module BiTRIM_integraion_XNOR_CONV_PE_0_0_XNOR_CONV_PE
   (outside,
    pcountout,
    weight_out,
    start,
    clk,
    pcountin,
    inbottom,
    top_control,
    side_control,
    inside,
    weight_control,
    weight_in,
    rst,
    top_start,
    intop);
  output outside;
  output [3:0]pcountout;
  output weight_out;
  input start;
  input clk;
  input [3:0]pcountin;
  input inbottom;
  input top_control;
  input side_control;
  input inside;
  input weight_control;
  input weight_in;
  input rst;
  input top_start;
  input intop;

  wire clk;
  wire inbottom;
  wire inside;
  wire intop;
  wire outside;
  wire p_0_in;
  wire [3:0]pcount_wire;
  wire [3:0]pcountin;
  wire [3:0]pcountout;
  wire rst;
  wire side_control;
  wire start;
  wire top_control;
  wire top_reg;
  wire top_reg_i_1_n_0;
  wire top_start;
  wire weight_control;
  wire weight_in;
  wire weight_out;
  wire weight_reg_i_1_n_0;
  wire xnor_input;
  wire xnor_out__0;

  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \pcount_reg[0]_i_1 
       (.I0(pcountin[0]),
        .I1(xnor_out__0),
        .O(pcount_wire[0]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \pcount_reg[1]_i_1 
       (.I0(pcountin[0]),
        .I1(xnor_out__0),
        .I2(pcountin[1]),
        .O(pcount_wire[1]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \pcount_reg[2]_i_1 
       (.I0(xnor_out__0),
        .I1(pcountin[0]),
        .I2(pcountin[1]),
        .I3(pcountin[2]),
        .O(pcount_wire[2]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \pcount_reg[3]_i_1 
       (.I0(pcountin[1]),
        .I1(pcountin[0]),
        .I2(xnor_out__0),
        .I3(pcountin[2]),
        .I4(pcountin[3]),
        .O(pcount_wire[3]));
  LUT6 #(
    .INIT(64'hAAAAA9595555A959)) 
    \pcount_reg[3]_i_2 
       (.I0(weight_out),
        .I1(inbottom),
        .I2(top_control),
        .I3(top_reg),
        .I4(side_control),
        .I5(inside),
        .O(xnor_out__0));
  FDRE \pcount_reg_reg[0] 
       (.C(clk),
        .CE(start),
        .D(pcount_wire[0]),
        .Q(pcountout[0]),
        .R(p_0_in));
  FDRE \pcount_reg_reg[1] 
       (.C(clk),
        .CE(start),
        .D(pcount_wire[1]),
        .Q(pcountout[1]),
        .R(p_0_in));
  FDRE \pcount_reg_reg[2] 
       (.C(clk),
        .CE(start),
        .D(pcount_wire[2]),
        .Q(pcountout[2]),
        .R(p_0_in));
  FDRE \pcount_reg_reg[3] 
       (.C(clk),
        .CE(start),
        .D(pcount_wire[3]),
        .Q(pcountout[3]),
        .R(p_0_in));
  LUT1 #(
    .INIT(2'h1)) 
    side_reg_i_1
       (.I0(rst),
        .O(p_0_in));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    side_reg_i_2
       (.I0(inside),
        .I1(side_control),
        .I2(top_reg),
        .I3(top_control),
        .I4(inbottom),
        .O(xnor_input));
  FDRE side_reg_reg
       (.C(clk),
        .CE(start),
        .D(xnor_input),
        .Q(outside),
        .R(p_0_in));
  LUT4 #(
    .INIT(16'hE200)) 
    top_reg_i_1
       (.I0(top_reg),
        .I1(top_start),
        .I2(intop),
        .I3(rst),
        .O(top_reg_i_1_n_0));
  FDRE top_reg_reg
       (.C(clk),
        .CE(1'b1),
        .D(top_reg_i_1_n_0),
        .Q(top_reg),
        .R(1'b0));
  LUT4 #(
    .INIT(16'hE200)) 
    weight_reg_i_1
       (.I0(weight_out),
        .I1(weight_control),
        .I2(weight_in),
        .I3(rst),
        .O(weight_reg_i_1_n_0));
  FDRE weight_reg_reg
       (.C(clk),
        .CE(1'b1),
        .D(weight_reg_i_1_n_0),
        .Q(weight_out),
        .R(1'b0));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
