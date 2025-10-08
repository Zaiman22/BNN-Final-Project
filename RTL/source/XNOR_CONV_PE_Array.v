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
        input wire start,


        input wire weight_control,
        input wire [8:0] weight_in,
        input wire [8:0]top_start, // ctrl signal for inserting top input register
        input wire [8:0]top_control, // ctrl signal for inserting top input register
        input wire [8:0]side_control, // ctrl signal for inserting top input register
        input wire intop,
        input wire [8:0] inbottom,
        output wire signed [4:0] partial_sum_out,
        output wire valid
    );

    localparam NUMBER_OF_PE = 9;
    wire signed [PSUM_WIDTH-1:0] pcountin  [8:0];
    wire signed [PSUM_WIDTH-1:0] pcountout [8:0];
    wire [8:0] inside;
    wire [8:0] outside;

   genvar i;
    generate
        for (i = 0; i < NUMBER_OF_PE; i = i + 1) begin : PE_GEN
            XNOR_CONV_PE XNOR_CONV_PE (
                .clk(clk),
                .rst(rst),
                .weight_control(weight_control),
                .side_control(side_control[i]),
                .top_control(top_control[i]),
                .start(start),
                .pcountin(pcountin[i]),
                .weight_in(weight_in[i]),
                .top_start(top_start[i]),
                .intop(intop),
                .inbottom(inbottom[i]),
                .inside(inside[i]),
                .outside(outside[i]),
                .pcountout(pcountout[i])    
            );
        end
    endgenerate


    // connecting pcount
    assign pcountin[0] = 0;
    assign pcountin[1] = 0;
    assign pcountin[2] = 0;

    assign pcountin[3] = pcountout[0];
    assign pcountin[4] = pcountout[1];
    assign pcountin[5] = pcountout[2];

    assign pcountin[6] = pcountout[3];
    assign pcountin[7] = pcountout[4];
    assign pcountin[8] = pcountout[5];

    // connecting inside
    assign inside[0] = outside[1];
    assign inside[1] = outside[2];
    assign inside[2] = 0;


    assign inside[3] = outside[4];
    assign inside[4] = outside[5];
    assign inside[5] = 0;


    assign inside[6] = outside[7];
    assign inside[7] = outside[8];
    assign inside[8] = 0;

    // popocunt
    assign partial_sum_out = (pcountout[6] + pcountout[7] + pcountout[8])*2 + minimum_value;
    assign valid = (start_count ==3)?1:0;
    localparam minimum_value = -9;

    reg [1:0] start_count;
    always @(posedge clk ) begin
        if (!rst) begin
            start_count <=0;
            // valid <=0;
        end
        else begin
            

            if (start_count == 3) begin
                // valid <= 1;
                start_count <=2;
            end
            else begin
                if (start) begin
                    start_count <= start_count + 1;
                end
                // valid <=0;
            end
        end
    end

endmodule
