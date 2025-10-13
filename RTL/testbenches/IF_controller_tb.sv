`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/13/2025 04:28:43 PM
// Design Name: 
// Module Name: IF_controller_tb
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


module IF_controller_tb();


    reg clk;
    reg rst;
    reg start;
    reg [15:0] image_size;
    reg [5:0] number_channel;
    reg [3:0] kernel_size;
    reg padding;
    reg [1:0] stride;
    typedef enum logic { 
        BRAM_A,
        BRAM_B
    } port_input_logic;
    port_input_logic port_input;
    wire [15:0]  address_ifmap;
    wire [31:0] channel_en;
    wire PE_start;
    wire last_channel;
    wire first_channel;
    wire [1:0] input_choose;

    IF_controller dut(
        .clk(clk),
        .rst(rst),
        .start(start),
        .image_size(image_size),
        .number_channel(number_channel),
        .kernel_size(kernel_size),
        .padding(padding),
        .stride(stride),
        .port_input(port_input),
        .address_ifmap(address_ifmap),
        .channel_en(channel_en),
        .input_choose(input_choose),
        .PE_start(PE_start),
        .last_channel(last_channel),
        .first_channel(first_channel)
    );

    always #5 clk <= ~clk;


    initial begin
        clk <=1;
        rst <=0;
        image_size <= 0;
        number_channel <= 0;
        padding <= 0;
        stride <= 0;
        kernel_size <= 0;
        port_input <= BRAM_A; // port_input 


        #10
        rst <=1;
        // setting up input feature
        image_size <= 28;
        number_channel <= 1;
        padding <= 1;
        stride <= 1;
        kernel_size <= 3;



        #10
        start <=1;

        #10 start <=0;

        #1000000;

    end

endmodule
