`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2025 05:57:57 PM
// Design Name: 
// Module Name: SRB
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


module SRB
    (
        input wire clk,
        input wire rst,
        input wire start,
        input wire in1, // this is for shifted
        input wire in2, // this is for shortcut
        input wire toggle,

        output wire out1
    );

    // register
    reg value_register;
    assign out1 = value_register;

    always @(posedge clk ) begin
        if (!rst) begin
            value_register <=0;
        end
        else begin
            if (start) begin
                value_register <= (toggle) ? in2 : in1;
            end
        end
    end



endmodule
