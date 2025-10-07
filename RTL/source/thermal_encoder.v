`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/07/2025 06:57:59 PM
// Design Name: 
// Module Name: thermal_encoder
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

// pure combinational logic
module thermal_encoder#(
        parameter RESOLUTION = 32,
        parameter INPUT_WIDTH = 8 // 8 bit widtg pixel
    )
    (
    input wire [INPUT_WIDTH-1:0]pixel_in,
    input wire write_en,
    
    output wire [INPUT_WIDTH-1:0] encoded_out,
    output wire [INPUT_WIDTH-1:0] write_enable_out
    );

    localparam THRESHOLD = RESOLUTION/2; // 16

    genvar i;

    generate
        for (i=0; i<INPUT_WIDTH; i=i+1) begin : gen_loop
            assign encoded_out[i] = (pixel_in > (i*RESOLUTION+THRESHOLD)) ? 1'b1 : 1'b0;
        end
    endgenerate

    assign write_enable_out = (write_en)? {INPUT_WIDTH{1'b1}} : {INPUT_WIDTH{1'b0}};

endmodule
