`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2025 02:00:49 PM
// Design Name: 
// Module Name: accelerator_top
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


module accelerator_top
    (
        // AXI4-Lite Slave Interface
        input  s_axi_aclk,
        input  s_axi_aresetn,

        // Write Address Channel
        input  [7:0]  s_axi_awaddr, // in axi_lite the memory is incremeted by 4 so by +2 it will make it correct
        input         s_axi_awvalid,
        output        s_axi_awready,

        // Write Data Channel
        input  [31:0] s_axi_wdata,
        input         s_axi_wvalid,
        output        s_axi_wready,

        // Write Response Channel
        output [1:0]  s_axi_bresp,
        input         s_axi_bready,
        output        s_axi_bvalid,


        // DMA recieve

         // dma port input for image
        output wire       s_axis_tready,
        input  wire [7:0] s_axis_tdata,
        input  wire       s_axis_tvalid,
        input  wire       s_axis_tlast,



        // DMA send
        // dma port output for comparator output
        input  wire       m_axis_tready,
        output wire [7:0] m_axis_tdata,
        output wire       m_axis_tvalid,
        output wire       m_axis_tlast


    );

    wire clk;
    wire rst;
    assign clk = s_axi_aclk;
    assign rst = s_axi_aresetn;

    // controller and register



    // AXI-write logic
    axi_write_logic  #(
        .number_of_register(256)
    )wrinst
    (
        .axi_clk       (s_axi_aclk),
        .rstn          (s_axi_aresetn),

        // Write Address Channel
        .write_addr        (s_axi_awaddr),
        .write_addr_valid  (s_axi_awvalid),
        .write_addr_ready  (s_axi_awready),

        // Write Data Channel
        .write_data        (s_axi_wdata),
        .write_data_valid  (s_axi_wvalid),
        .write_data_ready  (s_axi_wready),

        // Write Response Channel
        .write_resp        (s_axi_bresp),   // <-- make sure axi_write_logic expects 2 bits here
        .write_resp_ready  (s_axi_bready),
        .write_resp_valid  (s_axi_bvalid),

        // Output to register file
        .data_out   (rdata_in),
        .addr_out   (wraddr),
        .data_valid (write_en)
    );



    // thermal encoder


endmodule
