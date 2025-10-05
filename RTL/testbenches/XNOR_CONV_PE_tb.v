`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2025 12:36:40 AM
// Design Name: 
// Module Name: XNOR_CONV_PE_tb
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


module XNOR_CONV_PE_tb();


// Parameters
    parameter PSUM_WIDTH = 4;

    // Signals
    reg clk;
    reg rst;
    reg en;
    reg weight_control;
    reg side_control;
    reg top_control;
    reg start;
    wire valid;

    reg [PSUM_WIDTH-1:0] pcountin;
    reg weight_in;
    reg intop;
    reg inbottom;
    reg inside;

    wire outside;
    wire [PSUM_WIDTH-1:0] pcountout;
    wire weight_out;

    // DUT instance
    XNOR_CONV_PE #(.PSUM_WIDTH(PSUM_WIDTH)) dut (
        .clk(clk),
        .rst(rst),
        .en(en),
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

    // Clock generation (period = 10ns)
    always #5 clk = ~clk;

    // Test procedure
    initial begin

        // Initialize signals
        clk = 1;
        rst = 0;
        en = 0;
        weight_control = 0;
        side_control = 0;
        top_control = 0;
        start = 0;
        pcountin = 0;
        weight_in = 0;
        intop = 0;
        inbottom = 0;
        inside = 0;

        // Apply reset
        #10 rst = 1;
        #10;

        // Load weight
        weight_control = 1;
        weight_in = 1;
        #10 weight_control = 0;weight_in = 0;
        // #10 weight_control = 1;weight_in = 0;

        // Normal operation
        en = 1;
        pcountin = 3;
        inbottom = 1;
        inside = 0;
        side_control = 0;
        top_control = 0;
        #10;

        // Switch to side_control (use 'inside' input)
        side_control = 1;
        inside = 1;
        #10;

        // Switch to top_control (use 'top_reg')
        side_control = 0;
        top_control = 1;
        #10;

        // Change weight and input
        en = 0;
        weight_control = 1;
        weight_in = 0;
        #10;

        // Continue operation with new weight
        en = 1;
        weight_control = 0;
        pcountin = 5;
        inbottom = 1;
        inside = 1;
        side_control = 0;
        top_control = 0;
        #10;

        // End simulation
        #20;
        $display("Simulation complete.");
        $finish;
    end
endmodule
