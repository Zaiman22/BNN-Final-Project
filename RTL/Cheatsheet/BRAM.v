`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/25/2025 06:19:06 PM
// Design Name: 
// Module Name: BRAM_write
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Performs one BRAM write when 'start' is asserted
//
//////////////////////////////////////////////////////////////////////////////////

module BRAM_write(
    // ### General purpose interface ###
    input wire         clk,        // system clock
    input wire         rst,        // system reset

    
     // * Data input port for image input *
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK"  *) output wire [0:0] clka, // single-bit clk
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORTA RST"  *) output wire [0:0] rsta,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN"   *) output wire [0:0] ena,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) output wire [31:0] addra,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN"  *) output wire [31:0] dina,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE"   *) output wire [3:0]  wea,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) input  wire [31:0] douta,
    
    // ### Output to control BRAM ###
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) output wire        clkb,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORTB RST" *) output wire        rstb,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORTB EN" *)  output wire        enb,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *)output wire [31:0] addrb,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORTB DIN" *)output wire [31:0] dinb,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORTB WE" *)output wire [3:0]  web,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *)input wire  [31:0] doutb,

    // ### IP control ###
    input wire         start,
    output reg         ready
);

    // Internal signal to latch start event
    register #(
        .WIDTH(1)
    ) start_latch (
        .clk(clk),
        .rst_n(~rst),
        .en(1'b1),
        .clr(1'b0),
        .d(start),
        .q(start_latched)
    );

    wire start_latched; // Latch the start signal
    reg start_edge; // Edge detection for start signal
    assign start_edge = ~start_latched & start;
    reg write_enable, read_enable; // Control signals for BRAM operations

    // Simple one-shot write FSM
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            write_enable <= 1'b0;
            read_enable <= 1'b0;
            ready <= 1'b1;
        end else begin
            if (start_edge && ready) begin
                read_enable <= 1'b1;  // One-shot trigger
                ready <= 1'b0;
            end else begin
                if (read_enable) begin
                    write_enable <= 1'b1; // Enable write operation
                    ready <= 1'b0;        // Not ready until write is done
                end else begin
                    write_enable <= 1'b0; // Disable write operation
                    read_enable <= 1'b0; // Disable read operation
                    ready <= 1'b1;       // Ready for next operation
                end
            end
        end
    end


    // Assign BRAM input interface for Port A
    wire [31:0] temp_douta; // temporary input data from Port A
    assign clka = clk;
    assign rsta = ~rst_n;
    assign ena  = read_enable; // Enable Port A
    assign addra = 32'd0;        // Read address 0
    assign temp_douta = douta;


    // Assign BRAM output interface
    assign clkb  = clk;
    assign rstb  = rst;
    assign enb   = write_enable; // Enable Port B when writing
    assign addrb = 32'd0; // Write address 0
    assign dinb  = (write_enable) ? 32'hDEADBEEF : 32'd0;      // Replace with real data if needed
    assign web   = (write_enable) ? 4'hF       : 4'b0000;      // Write all bytes

endmodule
