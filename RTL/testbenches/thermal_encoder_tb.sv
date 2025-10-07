`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/07/2025 07:05:10 PM
// Design Name: 
// Module Name: thermal_encoder_tb
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


module thermal_encoder_tb();


    // parameter
    localparam CLK_PERIOD = 10; // clock period in ns
    localparam RESOLUTION = 32; // resolution for encoding
    localparam DATA_WIDTH = 8; // width of the pixel data


    // register and wires
    reg clk;
    reg test_start;
    reg write_en;
    reg [7:0] pixel_in;
    wire [7:0] encoded_out;
    wire [7:0]write_enable_out;


    // initate module
    thermal_encoder #(
        .RESOLUTION(RESOLUTION),
        .DATA_WIDTH(DATA_WIDTH)
    ) uut (
        .write_en(write_en),
        .pixel_in(pixel_in),
        .encoded_out(encoded_out),
        .write_enable_out(write_enable_out)
    );


    // clock generation
    always #(CLK_PERIOD/2) clk <= ~clk;


    // stimulus generation
    always @(posedge clk ) begin
        if (test_start) begin
            write_en <= 1;
            // test pixels
            pixel_in <= pixel_in + 1;
        end
    end

    initial begin
        clk = 1;
        write_en <= 0;
        pixel_in <=0;
        test_start <= 0;
        #20;

        test_start <= 1;
        wait (pixel_in == 8'd255);
        $display("Test done. pixel_in reached %d", pixel_in);
        #10;
        test_start <=0;
        
        pixel_in <= 0;
        #10
        $finish;
    end

endmodule
