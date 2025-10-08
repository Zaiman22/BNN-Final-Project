`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2025 04:04:00 AM
// Design Name: 
// Module Name: XNOR_conv_core
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module XNOR_conv_core #(
        parameter channel_out_width = $clog2(2*9*254)
    )
    (
        input wire clk,
        input wire rst,
        // FIFO control signal
        input wire first_channel,
        input wire last_channel,
        // Array control signal
        input wire start,
        input wire [8:0]top_start, // ctrl signal for inserting top input register
        input wire [8:0]top_control, // ctrl signal for inserting top input register
        input wire [8:0]side_control, // ctrl signal for inserting top input register

        // input data

        input wire [8:0] weight_in,
        input wire intop,
        input wire [8:0] inbottom,

        // threshold
        input wire [7:0] threshold,
        input wire start_threshold,

        // output data
        output wire valid,
        output wire binary_out
    );


    wire signed [channel_out_width:0] channel_out;

    wire valid_array;
    wire signed [4:0] partial_sum_out;


    XNOR_CONV_PE_Array PE_array(
    .clk(clk),
    .rst(rst),
    .start(start),
    .weight_control(weight_control),
    .weight_in(weight_in),
    .top_start(top_start), 
    .top_control(top_control),
    .side_control(side_control), 
    .intop(intop),
    .partial_sum_out(partial_sum_out),
    .valid(valid_array)
    );


    // FIFO PSUM
    xpm_fifo_sync #(
      .CASCADE_HEIGHT(0),            // DECIMAL
      .DOUT_RESET_VALUE("0"),        // String
      .ECC_MODE("no_ecc"),           // String
      .EN_SIM_ASSERT_ERR("warning"), // String
      .FIFO_MEMORY_TYPE("auto"),     // String
      .FIFO_READ_LATENCY(1),         // DECIMAL
      .FIFO_WRITE_DEPTH(32*32),       // DECIMAL
      .FULL_RESET_VALUE(0),          // DECIMAL
      .PROG_EMPTY_THRESH(10),        // DECIMAL
      .PROG_FULL_THRESH(10),         // DECIMAL
      .RD_DATA_COUNT_WIDTH(1),       // DECIMAL
      .READ_DATA_WIDTH(channel_out_width),          // DECIMAL
      .READ_MODE("std"),             // String
      .SIM_ASSERT_CHK(0),            // DECIMAL; 0=disable simulation messages, 1=enable simulation messages
      .USE_ADV_FEATURES("0707"),     // String
      .WAKEUP_TIME(0),               // DECIMAL
      .WRITE_DATA_WIDTH(channel_out_width),         // DECIMAL
      .WR_DATA_COUNT_WIDTH(1)        // DECIMAL
   )
   fifo1 (
    .dout(dout),
    .din(din),
    .rd_en(rd_en),
    .rst(~rst),
    .wr_clk(clk),
    .wr_en(wr_en) 
   );

   wire signed [channel_out_width:0] din, dout;

    assign rd_en = valid_array & first_channel;
    assign valid = write_reg & last_channel;
    assign binary_out = (channel_out > threshold) ? 1 : 0;
    reg write_reg;
    reg signed [4:0] partial_sum_out_reg;
    assign din = channel_out;
    assign channel_out = (first_channel) ? partial_sum_out_reg : partial_sum_out_reg + dout;


   always @(posedge clk ) begin
        if (!rst) begin
            partial_sum_out_reg <=0;
        end
        else begin
            write_reg <= valid_array;
            // psum 
            partial_sum_out_reg <= partial_sum_out;
        end
   end


endmodule
