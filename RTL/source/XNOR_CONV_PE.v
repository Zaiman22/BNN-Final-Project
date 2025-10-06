`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2025 10:56:24 PM
// Design Name: 
// Module Name: XNOR_CONV_PE
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


module XNOR_CONV_PE#(
        parameter PSUM_WIDTH = 4 // this changes according to the maximum size of the kernel default its 3x3 (kxk) < 2^4 -1
    )
    (
        // control signal
        input wire clk,
        input wire rst,
        input wire en,
        input wire weight_control,
        input wire side_control,
        input wire top_control,
        input wire start,
        output wire valid,

        // input data
        input wire [PSUM_WIDTH-1:0] pcountin,
        input wire weight_in,
        input wire intop,
        input wire inbottom,
        input wire inside,

        // output data
        output wire outside,
        output wire [PSUM_WIDTH-1:0] pcountout,
        output wire weight_out
    );



    // creating register
    reg [PSUM_WIDTH-1:0]pcount_reg;
    reg weight_reg;
    reg side_reg, top_reg;

    wire xnor_input, xnor_weight, xnor_out;
    wire [PSUM_WIDTH-1:0]pcount_wire;

    assign xnor_input = (side_control)?inside:(top_control)? top_reg:inbottom;
    assign xnor_weight = weight_reg;
    assign xnor_out = ~(xnor_input ^ xnor_weight); // XNOR operation
    assign pcount_wire = pcountin + xnor_out;
    assign pcountout = pcount_reg;
    assign outside = side_reg;


    assign weight_out = weight_reg;


    // output logic
    always @(posedge clk ) begin
        if (!rst) begin
            pcount_reg <=0;
            side_reg <=0;
            top_reg <=0;
        end
        else if (en) begin
            if (start) begin
                top_reg <= intop;
                side_reg <= xnor_input;
                pcount_reg <= pcount_wire;
            end
        end
    end

    // weight logic

    always @(posedge clk ) begin
        if (!rst) begin
            weight_reg <=0;
        end
        else if (weight_control)begin
            weight_reg <= weight_in;
        end
    end


    // valid signal logci
    reg valid_reg1,valid_reg2;
    assign valid = valid_reg2;

    always @(posedge clk ) begin
        if (!rst) begin
            valid_reg1 <=0;
            valid_reg2 <=0;
        end
        else if (en) begin
                valid_reg1 <= start;
                valid_reg2 <= valid_reg1;
        end
    end

    

endmodule
