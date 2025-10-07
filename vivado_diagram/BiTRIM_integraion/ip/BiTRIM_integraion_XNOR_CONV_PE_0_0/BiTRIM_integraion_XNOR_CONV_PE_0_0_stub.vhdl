-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2025.1 (lin64) Build 6140274 Wed May 21 22:58:25 MDT 2025
-- Date        : Tue Oct  7 21:49:52 2025
-- Host        : pop-os running 64-bit Pop!_OS 22.04 LTS
-- Command     : write_vhdl -force -mode synth_stub
--               /home/zaiman22/Documents/new-zaiman22/projek/fpga-cnn-bnn-paper/BNN-Final-Project/vivado_diagram/BiTRIM_integraion/ip/BiTRIM_integraion_XNOR_CONV_PE_0_0/BiTRIM_integraion_XNOR_CONV_PE_0_0_stub.vhdl
-- Design      : BiTRIM_integraion_XNOR_CONV_PE_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BiTRIM_integraion_XNOR_CONV_PE_0_0 is
  Port ( 
    clk : in STD_LOGIC;
    rst : in STD_LOGIC;
    en : in STD_LOGIC;
    weight_control : in STD_LOGIC;
    side_control : in STD_LOGIC;
    top_control : in STD_LOGIC;
    start : in STD_LOGIC;
    top_start : in STD_LOGIC;
    pcountin : in STD_LOGIC_VECTOR ( 3 downto 0 );
    weight_in : in STD_LOGIC;
    intop : in STD_LOGIC;
    inbottom : in STD_LOGIC;
    inside : in STD_LOGIC;
    outside : out STD_LOGIC;
    pcountout : out STD_LOGIC_VECTOR ( 3 downto 0 );
    weight_out : out STD_LOGIC
  );

  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of BiTRIM_integraion_XNOR_CONV_PE_0_0 : entity is "BiTRIM_integraion_XNOR_CONV_PE_0_0,XNOR_CONV_PE,{}";
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of BiTRIM_integraion_XNOR_CONV_PE_0_0 : entity is "BiTRIM_integraion_XNOR_CONV_PE_0_0,XNOR_CONV_PE,{x_ipProduct=Vivado 2025.1,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=XNOR_CONV_PE,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,PSUM_WIDTH=4}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of BiTRIM_integraion_XNOR_CONV_PE_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of BiTRIM_integraion_XNOR_CONV_PE_0_0 : entity is "module_ref";
end BiTRIM_integraion_XNOR_CONV_PE_0_0;

architecture stub of BiTRIM_integraion_XNOR_CONV_PE_0_0 is
  attribute syn_black_box : boolean;
  attribute black_box_pad_pin : string;
  attribute syn_black_box of stub : architecture is true;
  attribute black_box_pad_pin of stub : architecture is "clk,rst,en,weight_control,side_control,top_control,start,top_start,pcountin[3:0],weight_in,intop,inbottom,inside,outside,pcountout[3:0],weight_out";
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of clk : signal is "xilinx.com:signal:clock:1.0 clk CLK";
  attribute X_INTERFACE_MODE : string;
  attribute X_INTERFACE_MODE of clk : signal is "slave";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of clk : signal is "XIL_INTERFACENAME clk, ASSOCIATED_RESET rst, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN BiTRIM_integraion_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of rst : signal is "xilinx.com:signal:reset:1.0 rst RST";
  attribute X_INTERFACE_MODE of rst : signal is "slave";
  attribute X_INTERFACE_PARAMETER of rst : signal is "XIL_INTERFACENAME rst, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of stub : architecture is "XNOR_CONV_PE,Vivado 2025.1";
begin
end;
