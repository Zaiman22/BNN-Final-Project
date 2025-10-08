`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2025 02:00:49 PM
// Design Name: 
// Module Name: IF_controller
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


module IF_controller
    (
        input wire clk,
        input wire rst,
        input wire start,
        input wire [15:0] image_size, // assuming square image
        input wire [5:0] number_channel, // assuming square image
        input wire [3:0] kernel_size, // assuming square kernel
        input wire padding, // assuming square padding
        input wire [1:0] stride, // assuming square stride

        output wire [15:0] address_ifmap,
        output wire [31:0] channel_en,


        // PE register controller
        output wire PE_start,

        output wire last_channel,
        output wire first_channel


        // Weight control signal
    );


    typedef enum logic [1:0] {
    IDLE  = 2'b00,
    START = 2'b01,
    RUN   = 2'b10,
    STOP  = 2'b11
} state_t;


     



    
endmodule
