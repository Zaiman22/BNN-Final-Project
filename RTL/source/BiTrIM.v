`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2025 02:37:43 AM
// Design Name: 
// Module Name: BiTrIM
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


module BiTrIM
    (
        input wire clk,
        input wire rst,


        // weight insert
        input wire [15:0] write_weight_addres,
        input wire [5:0] weight_insert_channel, // max channel is 64 -> 2^6 = 64
        input wire [8:0] weight_value,
        input wire write_weight,

        // threshold/bias in
        input wire [15:0] write_threshold_addres,
        input wire [5:0] threshold_insert_channel, // max channel is 64 -> 2^6 = 64
        input wire [8:0] threshold_value,
        input wire write_threshold,

        // input feature 
        input wire intop,
        input wire [8:0] top_control,
        input wire [8:0] side_control,


        // control signal
        input wire first_channel,
        input wire last_channel,

        // output signal
        output valid,
        output [63:0] binary_out

    );

    // BRAM for weight
    genvar w;
    localparam max_channel = 64;
    wire [63:0] write_channel;
    wire [9:0] weight_read [max_channel-1:0];
    wire read_weight;
    
    generate
        for (w=0; w < max_channel; w = w+1) begin

            assign write_channel[w] = ((weight_insert_channel == w) && write_weight);
            
            xpm_memory_tdpram // 
                            #(
                                // Common module parameters
                                .MEMORY_SIZE(65536),                   // DECIMAL, size: 9 x 64 x 64 -> 16x64x64 = 
                                .MEMORY_PRIMITIVE("auto"),           // String
                                .CLOCKING_MODE("common_clock"),      // String, "common_clock"
                                .MEMORY_INIT_FILE("none"),           // String
                                .MEMORY_INIT_PARAM("0"),             // String      
                                .USE_MEM_INIT(1),                    // DECIMAL
                                .WAKEUP_TIME("disable_sleep"),       // String
                                .MESSAGE_CONTROL(0),                 // DECIMAL
                                .AUTO_SLEEP_TIME(0),                 // DECIMAL          
                                .ECC_MODE("no_ecc"),                 // String
                                .MEMORY_OPTIMIZATION("true"),        // String              
                                .USE_EMBEDDED_CONSTRAINT(0),         // DECIMAL
                                
                                // Port A module parameters
                                .WRITE_DATA_WIDTH_A(9),             // DECIMAL, data width: 64-bit
                                .READ_DATA_WIDTH_A(9),              // DECIMAL, data width: 64-bit
                                .BYTE_WRITE_WIDTH_A(8),              // DECIMAL
                                .ADDR_WIDTH_A(16),                    // DECIMAL, clog2(102400/8)=clog2(12800) around 14
                                .READ_RESET_VALUE_A("0"),            // String
                                .READ_LATENCY_A(1),                  // DECIMAL
                                .WRITE_MODE_A("write_first"),        // String
                                .RST_MODE_A("SYNC"),                 // String
                                
                                // Port B module parameters  
                                .WRITE_DATA_WIDTH_B(9),             // DECIMAL, data width: 64-bit
                                .READ_DATA_WIDTH_B(9),              // DECIMAL, data width: 64-bit
                                .BYTE_WRITE_WIDTH_B(8),              // DECIMAL
                                .ADDR_WIDTH_B(16),                    // DECIMAL, clog2(256/64)=clog2(8)= 2
                                .READ_RESET_VALUE_B("0"),            // String
                                .READ_LATENCY_B(1),                  // DECIMAL
                                .WRITE_MODE_B("write_first"),        // String
                                .RST_MODE_B("SYNC")                  // String
                            )
                            xpm_memory_weight
                            (
                                .sleep(1'b0),
                                .regcea(1'b1), //do not change
                                .injectsbiterra(1'b0), //do not change
                                .injectdbiterra(1'b0), //do not change   
                                .sbiterra(), //do not change
                                .dbiterra(), //do not change
                                .regceb(1'b1), //do not change
                                .injectsbiterrb(1'b0), //do not change
                                .injectdbiterrb(1'b0), //do not change              
                                .sbiterrb(), //do not change
                                .dbiterrb(), //do not change
                                
                                // Port A module ports
                                .clka(clk),
                                .rsta(~rst),
                                .ena(write_channel[w]),
                                .wea(write_channel[w]),
                                .addra(write_weight_addres),
                                .dina(weight_value),
                                .douta(),
                                
                                // Port B module ports
                                .clkb(clk),
                                .rstb(~rst),
                                .enb(read_weight),
                                .web(0),
                                .addrb(read_weight_addres),
                                .dinb(0),
                                .doutb(weight_read[w])
                            );
        

        XNOR_conv_core core
    (
        .clk(clk),
        .rst(rst),
        // FIFO control signal
        .first_channel(first_channel),
        .last_channel(last_channel),
        // Array control signal
        .start(start),
        .top_start(top_start), // ctrl signal for inserting top input register
        .top_control(top_control), 
        .side_control(side_control), 

        // input data

        .weight_in(weight_read[w]),
        .weight_control(weight_control),
        .intop(intop),
        .inbottom(inbottom),

        // threshold
        .threshold(threshold[w]),
        .start_threshold(start_threshold),

        // output data
        .valid(valid),
        .binary_out(binary_out)
    );

        
        end
    endgenerate

    // SBR and bottom data
    wire [8:0] inbottom;



    // pipeline for BRAM weight response and the weight control signal
    // cycle 1 -> req to bram
    // cycle 2 -> weight control goes up and also there response from bram
    reg weight_control;
    always @(posedge clk ) begin
        if (!rst) begin
            weight_control <=0;
        end
        else begin
            weight_control <= read_weight;
        end
    end


    // theshold BRAM
    wire [7:0] threshold [63:0];
    wire start_threshold;




endmodule
