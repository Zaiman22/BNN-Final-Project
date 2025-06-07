`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: Zaiman Aufar Purnama
//
// Create Date:    05/21/2025 06:56:06 AM
// Design Name:
// Module Name:    FPconv3_top
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//   3×3 convolution, sequential over 9 cycles.
//   Fixes so that conv_output is zeroed at state=1, and dinb=0 until the first write.
//
// Dependencies:
//
// Revision:
// Revision 0.02 - Fixed conv_output roll-back & dinb initial value
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

module FPconv3_top(
    input  wire        clk,
    input  wire        rst_n,
    // *** Control and status port ***
    output wire        ready,
    input  wire        start,
    // *** Data input port for image input ***
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK"  *) output wire [0:0] clka, // single-bit clk
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORTA RST"  *) output wire [0:0] rsta,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN"   *) output wire [0:0] ena,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) output wire [31:0] addra,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN"  *) output wire [31:0] dina,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE"   *) output wire [3:0]  wea,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) input  wire [31:0] douta,
    //*** Data input port for kernel input ***
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORTC CLK"  *) output wire [0:0] clkc,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORTC RST"  *) output wire [0:0] rstc,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORTC EN"   *) output wire [0:0] enc,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORTC ADDR" *) output wire [31:0] addrc,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORTC DIN"  *) output wire [31:0] dinc,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORTC WE"   *) output wire [3:0]  wec,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORTC DOUT" *) input  wire [31:0] doutc,
    // *** Data output port convolution output ***
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK"  *) output wire [0:0]  clkb,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORTB RST"  *) output wire [0:0]  rstb,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORTB EN"   *) output wire [0:0]  enb,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) output wire [31:0] addrb,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORTB DIN"  *) output wire [31:0] dinb,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORTB WE"   *) output wire [3:0]  web,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) input  wire [31:0] doutb,
    // Address control
    input  wire [31:0] input_addr,   // Base address for the 3x3 window in BRAM A
    input  wire [31:0] output_addr,  // Output address in BRAM B
    //for debuging
    output wire [31:0] debug 
);

//==============================================================================
// 1) START edge-detection & FSM
//==============================================================================

wire start_reg;
wire start_rising;
register #(.WIDTH(1)) start_reg_inst (
    .clk  (clk),
    .rst_n(rst_n),
    .d    (start),
    .q    (start_reg)
);
// start_rising pulses for exactly one cycle when start goes 0→1
assign start_rising = start & ~start_reg;

reg [3:0] fsm_state;
always @(posedge clk) begin
    if (!rst_n) begin
        fsm_state <= 4'd0;
    end else if (start_rising) begin
        fsm_state <= 4'd1;
    end else if (fsm_state >= 4'd1 && fsm_state <= 4'd12) begin
        fsm_state <= fsm_state + 1;
    end else if (fsm_state == 4'd13) begin
        fsm_state <= 4'd0;
    end
end

// ready=1 when FSM is idle (state=0)
assign ready = (fsm_state == 4'd0) ? 1'b1 : 1'b0;


//==============================================================================
// 2) BRAM C: Fetch kernel input in 1 word (states 2)
//==============================================================================
reg [8:0] kernel;

assign clkc = clk;
assign rstc = ~rst_n;
assign enc  = (fsm_state == 4'd1) ? 1'b1 : 1'b0; // Enable BRAM C only in state=1
assign addrc = 32'd0; // Always read from address 0
assign dinc  = 32'd0; // We never write to BRAM C in this module
assign wec   = 4'd0; // No write enable, since we only read
// Read kernel input from BRAM C in state=1
always @(posedge clk) begin
    if (!rst_n) begin
        kernel <= 9'd0;
    end else if (fsm_state == 4'd1) begin
        kernel <= doutc[8:0]; // Read the first 9 bits of doutc as the kernel
    end else begin
        kernel <= kernel; // Hold the value in other states
    end
end




//==============================================================================
// 3) BRAM A: Fetch image pixels one-by-one over 9 cycles (states 2..10)
//==============================================================================

wire signed [31:0] temp_douta;
assign clka = clk;
assign rsta = ~rst_n;
assign ena  = (fsm_state >= 4'd2 && fsm_state <= 4'd10) ? 1'b1 : 1'b0;
assign addra = (fsm_state >= 4'd2 && fsm_state <= 4'd10)
               ? (fsm_state - 4'd2) * 32'h00000004
               : 32'd0;
assign temp_douta = douta;

// We never write back to Port A here, so:
assign dina = 32'd0;
assign wea  = 4'd0;

//==============================================================================
// 4) Kernel bit & single "multiplier"
//==============================================================================
// Hardwired 3×3 binary kernel:

// Current tap's kernel bit (only valid in 1..9)
wire kernel_bit = (fsm_state >= 4'd3 && fsm_state <= 4'd11)
                  ? kernel[fsm_state - 4'd3]
                  : 1'b0;

// Compute "+pixel" or "-pixel":
wire signed [31:0] multiplier_output;
assign multiplier_output = (kernel_bit)
                           ? $signed(temp_douta)
                           : -$signed(temp_douta);

//==============================================================================
// 5) conv_output accumulator, but only begin accumulating at state=2
//==============================================================================

reg signed [31:0] conv_output;
reg               do_accumulate;

always @(posedge clk) begin
    if (!rst_n) begin
        conv_output   <= 32'd0;
        do_accumulate <= 1'b0;
    end else begin
        if (fsm_state == 4'd2) begin
            // As soon as we enter state=2, force sum back to 0
            conv_output   <= 32'd0;
            do_accumulate <= 1'b1;
        end else if (fsm_state >= 4'd3 && fsm_state <= 4'd11) begin
            if (do_accumulate) begin
                conv_output <= conv_output + multiplier_output;
            end
        end else begin
            // Outside 1..9, hold/clear everything
            conv_output   <= 32'd0;
            do_accumulate <= 1'b0;
        end
    end
end

//==============================================================================
// 6) BRAM B: Write conv_output into consecutive addresses 0..8 over states 2..10
//==============================================================================

assign clkb = clk;
assign rstb = ~rst_n;

// Must be enabled in exactly the cycles where we want to write:
assign enb = (fsm_state == 4'd12) ? 1'b1 : 1'b0;

// Address for BRAM B = (fsm_state-2)*4 in bytes
assign addrb = 0;

// Only drive dinb when we actually intend to write:
assign dinb = (fsm_state == 4'd12) 
              ? conv_output 
              : 32'd0;

// Write enable lanes (all 4 bytes) for states 2..10:
assign web = (fsm_state == 4'd12)
             ? 4'b1111
             : 4'b0000;

// We never read Port B in this module, so:
 // assign doutb is unused
assign debug = kernel_bit;

endmodule