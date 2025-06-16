`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/06/2025 10:27:58 PM
// Design Name: 
// Module Name: DMA_to_BRAM
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


module DMA_to_BRAM(
    // *** General purpose interface ***
    input wire         clk,        // system clock
    input wire         rst,        // system reset

    // *** Output to control BRAM ***
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) output wire        clka,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORTA RST" *) output wire        rsta,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *)  output wire        ena,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *)output wire [31:0] addra,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *)output wire [31:0] dina,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *)output wire [3:0]  wea,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *)input wire  [31:0] douta,

    // *** Input from DMA controller ***
    // *** AXIS slave port ***
    // Setting for the HP AXIS interface is 64 in the PL configuration for 32 data width
    output wire        s_axis_tready,
    input wire [31:0]  s_axis_tdata,
    input wire         s_axis_tvalid,
    input wire         s_axis_tlast

    );


    
    // we want to write data to BRAM with incremental address, so let's use a counter
    reg [31:0] addr_counter;
    always @(posedge clk) begin
        if (!rst || addr_counter == 32'd4096 || s_axis_tlast) begin
            addr_counter <= 32'd0;
        end else if (s_axis_tvalid && addr_counter<=32'd2048) begin // write depth is 2048, therefore we can write 512 words of 32 bits
            addr_counter <= addr_counter + 32'd4; // Increment address by 4 bytes for each write
        end
    end

    assign s_axis_tready=1;

    // Assign BRAM interface
    assign clka  = clk;
    assign rsta  = rst;
    assign ena = s_axis_tvalid;
    assign addra = addr_counter;        // 
    assign dina  = s_axis_tdata;      // Replace with real data if needed
    assign wea = (s_axis_tvalid) ? 4'hF : 4'h0;      // Write all bytes

    // BRAM write logic

endmodule
