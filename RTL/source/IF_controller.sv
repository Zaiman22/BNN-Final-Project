`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2025 02:00:49 PM
// Design Name: 
// Module Name: IF_controller
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


module IF_controller
    (
        input wire clk,
        input wire rst,
        input wire start,
        input wire [4:0] image_size, // assuming square image
        input wire [5:0] number_channel, // assuming square image
        input wire [3:0] kernel_size, // assuming square kernel
        input wire padding, // assuming square padding
        input wire [1:0] stride, // assuming square stride
        input wire port_input,

        output reg [15:0] address_ifmap,
        output wire [31:0] channel_en,

        output wire [1:0] input_choose, // choose BRAM 1 or 2 and wheter to use padding or not


        // PE register controller
        output reg PE_start,

        output wire last_channel,
        output wire first_channel


        // Weight control signal
    );



    reg [3:0] count;
    // memory counter
    reg [5:0]  row_pos1,row_pos2,row_pos3;
    reg [5:0]  row_y1,row_y2,row_y3;
    typedef enum logic [3:0] {
        idle,
        row1,
        row2,
        row3,
        side1,
        side2,
        side3,
        new_row,
        continue_row,
        finish_row1,
        finish_row2,
        finish_row3
    } state_def;

    state_def state;



// memoery state
reg [1:0] memory_state;

always_comb begin : IF_address
    case (memory_state)
        0 : begin
            address_ifmap = row_pos1 + row_y1*image_size;
        end
        1 : begin
            address_ifmap = row_pos2 + row_y2*image_size;
        end
        2 : begin
            address_ifmap = row_pos3 + row_y3*image_size;
        end
        3 : begin
            address_ifmap = 0;
        end
    endcase
end

reg [8:0] top_start;

// FSM
always @(posedge clk ) begin
    if (!rst) begin
        state <= idle;
        count <= 0;
        PE_start <= 0;
        top_start <=0;

        row_pos1    <= 0;
        row_pos2    <= 0;
        row_pos3    <= 0;
        row_y1 <= 0;
        row_y2 <= 1;
        row_y3 <= 2;


        memory_state <=0;
    end
    else begin
        case (state)
            idle            : begin
                if(start) begin
                    state <= row1;
                    // weight signal
                    // position
                    row_pos1 <= 0;
                    row_pos2 <= 0;
                    row_pos3 <= 0;
                    top_start <= 9'b000000001;

                    // memory
                end
                PE_start <= 0;
            end
            row1            : begin
                if (count == 2) begin
                    count <= 0;
                    state <= row2;
                    PE_start <= 1;
                    memory_state <=1;
                end
                else begin
                    count <= count + 1;
                    row_pos1 <= row_pos1 +1;
                    PE_start <= 0;
                end
                top_start <= top_start <<1;
                

            end
            row2            : begin
                if (count == 3) begin
                    count <= 0;
                    state <= row3;
                    PE_start <= 1;
                    top_start <= top_start << 1;
                    top_start <= 9'b001000000;
                    memory_state <= 2;

                end
                else begin
                    if (count == 2) begin
                        row_pos1 <= row_pos1 +1;
                        top_start <= 9'b000000100;
                        memory_state <=0;
                    end
                    else begin
                        row_pos2 <= row_pos2 +1;
                        top_start <= top_start << 1;
                    end
                    count <= count + 1;
                    PE_start <= 0;
                end
            end   
            row3            : begin
                if (count == 4) begin
                    count <= 0;
                    state <= side1;
                    PE_start <= 1;
                    memory_state <= 2;
                    top_start <= 9'b100000000;
                end
                else begin
                    if (count == 3) begin
                        top_start <= 9'b000000100;
                        row_pos1 <= row_pos1 +1;
                        memory_state <= 0;
                    end
                    else if(count ==2) begin
                        row_pos2 <= row_pos2 +1;
                        top_start <= 9'b000100000;
                        memory_state <=1;
                    end
                    else begin
                        row_pos3 <= row_pos3 +1;
                        top_start <= top_start << 1;
                    end
                    count <= count + 1;
                    PE_start <= 0;
                end
            end
            side1           : begin
                case (count)
                    0:  begin
                        row_pos3 <= row_pos3 +1;
                        count <= count + 1;
                        PE_start <= 0;
                        memory_state <= 1;
                        top_start <= 9'b000100000;
                    end 
                    1:  begin
                        row_pos2 <= row_pos2 +1;
                        count <= count + 1;
                        memory_state <= 0;
                        top_start <= 9'b000000100;
                    end
                    2:  begin
                        row_pos1 <= (row_pos1==image_size-1) ? 0:row_pos1 +1;
                        count <=0;
                        state <= (row_pos1==image_size-1) ? side2:side1;
                        PE_start <= 1;
                        memory_state <= 2;
                        top_start <= 9'b100000000;
                    end
                endcase
                
            end
            side2           : begin
                case (count)
                    0 : begin
                            PE_start <= 0;
                            row_pos3 <= row_pos3 +1;
                            count <= count + 1;
                            memory_state <=1;                      
                    end 
                    1 : begin
                        PE_start <= 1;
                        row_pos2 <= 0;
                        count <= 0;    
                        state <= side3;
                        memory_state <=2;
                    end
                endcase
                
            end
            side3           : begin
                state <= new_row;
                row_pos3 <= 0;
                top_start <= 9'b001000000;
            end
            new_row         : begin
                case (count)
                    2 : begin
                        PE_start <= 1;
                        count <=0;
                        state <= continue_row;
                    end 
                    default: begin
                        count <= count + 1;
                        row_pos3 <= row_pos3 + 1;
                        PE_start <= 0;
                        top_start <= top_start <<1;
                    end 
                endcase
                
            end
            continue_row    : begin
                row_pos3 <= row_pos3 + 1;
                if (row_pos3 ==  image_size-5) begin
                    state <= finish_row1;
                end
                else if (row_pos3 == image_size-1) begin
                    if (row_y3 == image_size -1 ) begin
                        state <= idle;
                    end
                    else begin
                        state <= new_row;
                        row_pos3 <= 0;
                        row_y3 <= row_y3+1;  
                    end
                end
            end
            finish_row1     : begin
                case (count)
                    0: begin
                        count <= count +1;
                        row_pos3 <= row_pos3 + 1;
                        
                    end
                    1: begin
                        state <= finish_row2;
                        count <= 0;
                    end 
                endcase
                
            end
            finish_row2     : begin
                case (count)
                    0: begin
                        row_pos3 <= row_pos3 + 1;
                        count <= count + 1;
                        
                    end
                    1: begin
                        count <= count + 1;

                    end 
                    2: begin
                        count <= 0;

                        state <= finish_row3;
                    end 
                endcase
                
            end
            finish_row3     : begin
                case (count)
                    0: begin
                        count <= count + 1;
                        row_pos3 <= row_pos3 + 1;
                    end
                    1: begin
                        count <= 0;
                        state <= continue_row;
                    end 
                endcase
                
            end
        endcase
    end
end
    

// address calculation
typedef enum logic [1:0] {
        BRAM_A,
        BRAM_B,
        padded
} input_choose_state;

    input_choose_state input_choose_logic;

assign input_choose = input_choose_logic;

always_comb begin : address_calculation
    // check padding option is active or not
    if (padding) begin
        if (row_pos1 == 0 || row_pos1 == image_size-1 || row_y1 == 0 || row_y1 == image_size-1) begin
            input_choose_logic = padded;
        end
        else begin
            input_choose_logic = port_input;
            
        end
    end
end




    
endmodule
