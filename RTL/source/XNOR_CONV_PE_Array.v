`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2025 05:33:45 AM
// Design Name: 
// Module Name: XNOR_CONV_PE_Array
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


module XNOR_CONV_PE_Array#(
        parameter PSUM_WIDTH = 4 // this changes according to the maximum size of the kernel default its 3x3 (kxk) < 2^4 -1
    )
    (
        // control signal
        input wire clk,
        input wire rst,
        input wire en,
        input wire start,


        input wire weight_control,
        input wire [8:0] weight_in,
    );


    // PE 1
    NOR_CONV_PE #(.PSUM_WIDTH(PSUM_WIDTH)) PE1 (
        .clk(clk),
        .rst(rst),
        .weight_control(weight_control),
        .side_control(side_control),
        .top_control(top_control),
        .start(start),
        .valid(valid),
        .pcountin(pcountin),
        .weight_in(weight_in),
        .intop(intop),
        .inbottom(inbottom),
        .inside(inside),
        .outside(outside),
        .pcountout(pcountout),
        .weight_out(weight_out)
    );

    // PE 2
    NOR_CONV_PE #(.PSUM_WIDTH(PSUM_WIDTH)) PE2 (
        .clk(clk),
        .rst(rst),
        .weight_control(weight_control),
        .side_control(side_control),
        .top_control(top_control),
        .start(start),
        .valid(valid),
        .pcountin(pcountin),
        .weight_in(weight_in),
        .intop(intop),
        .inbottom(inbottom),
        .inside(inside),
        .outside(outside),
        .pcountout(pcountout),
        .weight_out(weight_out)
    );

    // PE 3
    NOR_CONV_PE #(.PSUM_WIDTH(PSUM_WIDTH)) PE3 (
        .clk(clk),
        .rst(rst),
        .weight_control(weight_control),
        .side_control(side_control),
        .top_control(top_control),
        .start(start),
        .valid(valid),
        .pcountin(pcountin),
        .weight_in(weight_in),
        .intop(intop),
        .inbottom(inbottom),
        .inside(inside),
        .outside(outside),
        .pcountout(pcountout),
        .weight_out(weight_out)
    );

    // PE 4
    NOR_CONV_PE #(.PSUM_WIDTH(PSUM_WIDTH)) PE4 (
        .clk(clk),
        .rst(rst),
        .weight_control(weight_control),
        .side_control(side_control),
        .top_control(top_control),
        .start(start),
        .valid(valid),
        .pcountin(pcountin),
        .weight_in(weight_in),
        .intop(intop),
        .inbottom(inbottom),
        .inside(inside),
        .outside(outside),
        .pcountout(pcountout),
        .weight_out(weight_out)
    );

    // PE 5
    NOR_CONV_PE #(.PSUM_WIDTH(PSUM_WIDTH)) PE5 (
        .clk(clk),
        .rst(rst),
        .weight_control(weight_control),
        .side_control(side_control),
        .top_control(top_control),
        .start(start),
        .valid(valid),
        .pcountin(pcountin),
        .weight_in(weight_in),
        .intop(intop),
        .inbottom(inbottom),
        .inside(inside),
        .outside(outside),
        .pcountout(pcountout),
        .weight_out(weight_out)
    );

    // PE 6
    NOR_CONV_PE #(.PSUM_WIDTH(PSUM_WIDTH)) PE6 (
        .clk(clk),
        .rst(rst),
        .weight_control(weight_control),
        .side_control(side_control),
        .top_control(top_control),
        .start(start),
        .valid(valid),
        .pcountin(pcountin),
        .weight_in(weight_in),
        .intop(intop),
        .inbottom(inbottom),
        .inside(inside),
        .outside(outside),
        .pcountout(pcountout),
        .weight_out(weight_out)
    );

    // PE 7
    NOR_CONV_PE #(.PSUM_WIDTH(PSUM_WIDTH)) PE7 (
        .clk(clk),
        .rst(rst),
        .weight_control(weight_control),
        .side_control(side_control),
        .top_control(top_control),
        .start(start),
        .valid(valid),
        .pcountin(pcountin),
        .weight_in(weight_in),
        .intop(intop),
        .inbottom(inbottom),
        .inside(inside),
        .outside(outside),
        .pcountout(pcountout),
        .weight_out(weight_out)
    );

    // PE 8
    NOR_CONV_PE #(.PSUM_WIDTH(PSUM_WIDTH)) PE8 (
        .clk(clk),
        .rst(rst),
        .weight_control(weight_control),
        .side_control(side_control),
        .top_control(top_control),
        .start(start),
        .valid(valid),
        .pcountin(pcountin),
        .weight_in(weight_in),
        .intop(intop),
        .inbottom(inbottom),
        .inside(inside),
        .outside(outside),
        .pcountout(pcountout),
        .weight_out(weight_out)
    );

    // PE 9
    NOR_CONV_PE #(.PSUM_WIDTH(PSUM_WIDTH)) PE9 (
        .clk(clk),
        .rst(rst),
        .weight_control(weight_control),
        .side_control(side_control),
        .top_control(top_control),
        .start(start),
        .valid(valid),
        .pcountin(pcountin),
        .weight_in(weight_in),
        .intop(intop),
        .inbottom(inbottom),
        .inside(inside),
        .outside(outside),
        .pcountout(pcountout),
        .weight_out(weight_out)
    );

endmodule
