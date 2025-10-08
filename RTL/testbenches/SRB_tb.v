module SRB_tb;

    // Parameters
    parameter N = 12; // number of SRB modules in the chain

    // Testbench signals
    reg clk;
    reg rst;
    reg start;
    reg [N-1:0] toggle;

    reg first_input;
    wire  in1 [N-1:0];  // shifted input
    wire  in2 [N-1:0];  // shortcut input
    wire out [N-1:0];  // outputs of each SRB


    // chain generation
    genvar j;
    generate
        for (j = 0; j < N; j = j + 1) begin : IN2_CHAIN
            assign in2[j] = first_input;
        end
    endgenerate
    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin : SRB_CHAIN

            SRB srb_inst (
                .clk(clk),
                .rst(rst),
                .start(start),
                .in1(in1[i]),
                .in2(in2[i]),
                .toggle(toggle[i]),
                .out1(out[i])
            );
        end
    endgenerate


    assign in1[0] = first_input;
    genvar k;
    generate
        for (k = 1; k < N; k = k + 1) begin : IN1_CHAIN
            assign in1[k] = out[k-1];
        end
    endgenerate


    always #5 clk = ~clk;


    initial begin
        clk=1;
        // Initialize signals
        rst = 0;
        start = 0;
        first_input = 0;
        toggle = 0;

        // Apply reset
        #10;
        rst = 1;

        // Test case 1: All toggles are 0, first input is 1
        #10;
        first_input = 1;
        toggle = 12'b000000000000; // All toggles are 0
        start = 1;
        #10;
        first_input = 0;

        // Wait for a few clock cycles to observe the output
        #150;
        start = 0;
        // Test case 2: Alternate toggles, first input is 0
        #50;
        first_input = 1;
        toggle = 12'b001000000000; // Alternate toggles
        start = 1;
        #10;
        first_input = 0;

        // Wait for a few clock cycles to observe the output
        #120;

        // Wait for a few clock cycles to observe the output
        #10;

        // Finish simulation
        $finish;
    end



endmodule
