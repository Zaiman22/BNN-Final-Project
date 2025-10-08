`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2025 12:52:59 AM
// Design Name: 
// Module Name: XNOR_CONV_PE_Array_tb
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


module XNOR_CONV_PE_Array_tb();


    localparam box1 = 9'b000000001;
    localparam box2 = 9'b000000010;
    localparam box3 = 9'b000000100;
    localparam box4 = 9'b000001000;
    localparam box5 = 9'b000010000;
    localparam box6 = 9'b000100000;
    localparam box7 = 9'b001000000;
    localparam box8 = 9'b010000000;
    localparam box9 = 9'b100000000;


    reg clk;
    reg rst;
    reg en;
    reg start;
    reg weight_control;
    reg [8:0] weight_in;
    reg [8:0] top_start;
    reg [8:0] top_control;
    reg [8:0] side_control;
    reg intop;
    wire signed [4:0]partial_sum_out;
    wire valid;

XNOR_CONV_PE_Array dut(
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
    .valid(valid)
);


// clock generator
always #5 clk = ~clk;


// Test Sequence
initial begin
    clk <=1;
    rst <=0;
    start <=0;
    weight_control <=0;
    weight_in <=0;
    top_start <=0;
    top_control <=1;
    side_control <=0;
    intop <=0;
    #10;
    rst <=1;
    #10 weight_control <=1 ; weight_in <=9'b101110000; top_start <=9'b000000001; intop <=1;
    #10 top_start <=9'b000000010; intop <=0;
    #10 top_start <=9'b000000100; intop <=1;
    #10 start <=1;top_control <= 9'b111111111; side_control <=9'b000000000; top_start <=9'b000001000;intop <=1; //4
    #10 start <=0; top_start <=9'b000010000; intop <=1; // 5
    #10 start <=0; top_start <=9'b000100000; intop <=0; // 6
    #10 start <=0; top_start <=9'b000000100; intop <=0; // 3 for the 4
    #10 start <=1;top_control <= 9'b111111100; side_control <=9'b000000011; top_start <=9'b001000000;intop <=1; //4
    #10 start <=0; top_start <=9'b010000000; intop <=1; // 5
    #10 start <=0; top_start <=9'b100000000; intop <=0; // 6
    #10 start <=0; top_start <=9'b000000100; intop <=0; // 3 for the 5th pixel
    #10 start <=0; top_start <=9'b000100000; intop <=0; // 3 for the 9th pixel
    #10 start <=1;top_control <= 9'b111100100; side_control <=9'b000011011; top_start <=box6 ;intop <=0; //6
    #10 start <=0; top_start <=box9 ; intop <=0; // 5
    #10 start <=1;top_control <= 9'b100100000; side_control <=9'b011011000; top_start <=box9 ;intop <=0; //6


    #30;
    $finish;

end


endmodule
