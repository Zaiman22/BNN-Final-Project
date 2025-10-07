// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.1 (lin64) Build 6140274 Wed May 21 22:58:25 MDT 2025
// Date        : Tue Oct  7 21:49:52 2025
// Host        : pop-os running 64-bit Pop!_OS 22.04 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/zaiman22/Documents/new-zaiman22/projek/fpga-cnn-bnn-paper/BNN-Final-Project/vivado_diagram/BiTRIM_integraion/ip/BiTRIM_integraion_XNOR_CONV_PE_0_0/BiTRIM_integraion_XNOR_CONV_PE_0_0_stub.v
// Design      : BiTRIM_integraion_XNOR_CONV_PE_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* CHECK_LICENSE_TYPE = "BiTRIM_integraion_XNOR_CONV_PE_0_0,XNOR_CONV_PE,{}" *) (* CORE_GENERATION_INFO = "BiTRIM_integraion_XNOR_CONV_PE_0_0,XNOR_CONV_PE,{x_ipProduct=Vivado 2025.1,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=XNOR_CONV_PE,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,PSUM_WIDTH=4}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) 
(* IP_DEFINITION_SOURCE = "module_ref" *) (* X_CORE_INFO = "XNOR_CONV_PE,Vivado 2025.1" *) 
module BiTRIM_integraion_XNOR_CONV_PE_0_0(clk, rst, en, weight_control, side_control, 
  top_control, start, top_start, pcountin, weight_in, intop, inbottom, inside, outside, pcountout, 
  weight_out)
/* synthesis syn_black_box black_box_pad_pin="rst,en,weight_control,side_control,top_control,start,top_start,pcountin[3:0],weight_in,intop,inbottom,inside,outside,pcountout[3:0],weight_out" */
/* synthesis syn_force_seq_prim="clk" */;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, ASSOCIATED_RESET rst, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN BiTRIM_integraion_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0" *) input clk /* synthesis syn_isclock = 1 */;
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
endmodule
