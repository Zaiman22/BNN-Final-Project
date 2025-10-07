-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2025.1 (lin64) Build 6140274 Wed May 21 22:58:25 MDT 2025
-- Date        : Tue Oct  7 21:49:52 2025
-- Host        : pop-os running 64-bit Pop!_OS 22.04 LTS
-- Command     : write_vhdl -force -mode funcsim
--               /home/zaiman22/Documents/new-zaiman22/projek/fpga-cnn-bnn-paper/BNN-Final-Project/vivado_diagram/BiTRIM_integraion/ip/BiTRIM_integraion_XNOR_CONV_PE_0_0/BiTRIM_integraion_XNOR_CONV_PE_0_0_sim_netlist.vhdl
-- Design      : BiTRIM_integraion_XNOR_CONV_PE_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z020clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity BiTRIM_integraion_XNOR_CONV_PE_0_0_XNOR_CONV_PE is
  port (
    outside : out STD_LOGIC;
    pcountout : out STD_LOGIC_VECTOR ( 3 downto 0 );
    weight_out : out STD_LOGIC;
    start : in STD_LOGIC;
    clk : in STD_LOGIC;
    pcountin : in STD_LOGIC_VECTOR ( 3 downto 0 );
    inbottom : in STD_LOGIC;
    top_control : in STD_LOGIC;
    side_control : in STD_LOGIC;
    inside : in STD_LOGIC;
    weight_control : in STD_LOGIC;
    weight_in : in STD_LOGIC;
    rst : in STD_LOGIC;
    top_start : in STD_LOGIC;
    intop : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of BiTRIM_integraion_XNOR_CONV_PE_0_0_XNOR_CONV_PE : entity is "XNOR_CONV_PE";
end BiTRIM_integraion_XNOR_CONV_PE_0_0_XNOR_CONV_PE;

architecture STRUCTURE of BiTRIM_integraion_XNOR_CONV_PE_0_0_XNOR_CONV_PE is
  signal p_0_in : STD_LOGIC;
  signal pcount_wire : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal top_reg : STD_LOGIC;
  signal top_reg_i_1_n_0 : STD_LOGIC;
  signal \^weight_out\ : STD_LOGIC;
  signal weight_reg_i_1_n_0 : STD_LOGIC;
  signal xnor_input : STD_LOGIC;
  signal \xnor_out__0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \pcount_reg[0]_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \pcount_reg[1]_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \pcount_reg[2]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \pcount_reg[3]_i_1\ : label is "soft_lutpair0";
begin
  weight_out <= \^weight_out\;
\pcount_reg[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => pcountin(0),
      I1 => \xnor_out__0\,
      O => pcount_wire(0)
    );
\pcount_reg[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => pcountin(0),
      I1 => \xnor_out__0\,
      I2 => pcountin(1),
      O => pcount_wire(1)
    );
\pcount_reg[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7F80"
    )
        port map (
      I0 => \xnor_out__0\,
      I1 => pcountin(0),
      I2 => pcountin(1),
      I3 => pcountin(2),
      O => pcount_wire(2)
    );
\pcount_reg[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFF8000"
    )
        port map (
      I0 => pcountin(1),
      I1 => pcountin(0),
      I2 => \xnor_out__0\,
      I3 => pcountin(2),
      I4 => pcountin(3),
      O => pcount_wire(3)
    );
\pcount_reg[3]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAA9595555A959"
    )
        port map (
      I0 => \^weight_out\,
      I1 => inbottom,
      I2 => top_control,
      I3 => top_reg,
      I4 => side_control,
      I5 => inside,
      O => \xnor_out__0\
    );
\pcount_reg_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => start,
      D => pcount_wire(0),
      Q => pcountout(0),
      R => p_0_in
    );
\pcount_reg_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => start,
      D => pcount_wire(1),
      Q => pcountout(1),
      R => p_0_in
    );
\pcount_reg_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => start,
      D => pcount_wire(2),
      Q => pcountout(2),
      R => p_0_in
    );
\pcount_reg_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => start,
      D => pcount_wire(3),
      Q => pcountout(3),
      R => p_0_in
    );
side_reg_i_1: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => rst,
      O => p_0_in
    );
side_reg_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => inside,
      I1 => side_control,
      I2 => top_reg,
      I3 => top_control,
      I4 => inbottom,
      O => xnor_input
    );
side_reg_reg: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => start,
      D => xnor_input,
      Q => outside,
      R => p_0_in
    );
top_reg_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"E200"
    )
        port map (
      I0 => top_reg,
      I1 => top_start,
      I2 => intop,
      I3 => rst,
      O => top_reg_i_1_n_0
    );
top_reg_reg: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => top_reg_i_1_n_0,
      Q => top_reg,
      R => '0'
    );
weight_reg_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"E200"
    )
        port map (
      I0 => \^weight_out\,
      I1 => weight_control,
      I2 => weight_in,
      I3 => rst,
      O => weight_reg_i_1_n_0
    );
weight_reg_reg: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => '1',
      D => weight_reg_i_1_n_0,
      Q => \^weight_out\,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity BiTRIM_integraion_XNOR_CONV_PE_0_0 is
  port (
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
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of BiTRIM_integraion_XNOR_CONV_PE_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of BiTRIM_integraion_XNOR_CONV_PE_0_0 : entity is "BiTRIM_integraion_XNOR_CONV_PE_0_0,XNOR_CONV_PE,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of BiTRIM_integraion_XNOR_CONV_PE_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of BiTRIM_integraion_XNOR_CONV_PE_0_0 : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of BiTRIM_integraion_XNOR_CONV_PE_0_0 : entity is "XNOR_CONV_PE,Vivado 2025.1";
end BiTRIM_integraion_XNOR_CONV_PE_0_0;

architecture STRUCTURE of BiTRIM_integraion_XNOR_CONV_PE_0_0 is
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of clk : signal is "xilinx.com:signal:clock:1.0 clk CLK";
  attribute X_INTERFACE_MODE : string;
  attribute X_INTERFACE_MODE of clk : signal is "slave";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of clk : signal is "XIL_INTERFACENAME clk, ASSOCIATED_RESET rst, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN BiTRIM_integraion_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of rst : signal is "xilinx.com:signal:reset:1.0 rst RST";
  attribute X_INTERFACE_MODE of rst : signal is "slave";
  attribute X_INTERFACE_PARAMETER of rst : signal is "XIL_INTERFACENAME rst, POLARITY ACTIVE_LOW, INSERT_VIP 0";
begin
inst: entity work.BiTRIM_integraion_XNOR_CONV_PE_0_0_XNOR_CONV_PE
     port map (
      clk => clk,
      inbottom => inbottom,
      inside => inside,
      intop => intop,
      outside => outside,
      pcountin(3 downto 0) => pcountin(3 downto 0),
      pcountout(3 downto 0) => pcountout(3 downto 0),
      rst => rst,
      side_control => side_control,
      start => start,
      top_control => top_control,
      top_start => top_start,
      weight_control => weight_control,
      weight_in => weight_in,
      weight_out => weight_out
    );
end STRUCTURE;
