`timescale 1ns / 1ps

module stream_parity_gen_tb;

    // Testbench signals
    reg clk;
    reg reset;
    reg serial_in;
    wire parity_out;

    // Loop and tracking variables
    integer i;
    integer errors;

    // Instantiate the Device Under Test (DUT)
    stream_parity_gen dut (
        .clk(clk),
        .reset(reset),
        .serial_in(serial_in),
        .parity_out(parity_out)
    );

    // Clock generation (10ns period -> 100MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end


    task apply_check_pattern(input [7:0] pattern);
        integer bit_idx;
        reg expected_parity;
        begin
            // parity expectation
            expected_parity = ^pattern;


            for (bit_idx = 7; bit_idx >= 0; bit_idx = bit_idx - 1) begin
                @(negedge clk);
                serial_in = pattern[bit_idx];
            end

            @(posedge clk);

            #1;

            if (parity_out !== expected_parity) begin
                $display("ERROR: Pattern %8b | Expected Parity: %b | Got: %b", pattern, expected_parity, parity_out);
                errors = errors + 1;
            end
        end
    endtask

    // stimulus generation
    initial begin
        // Initialize signals
        reset = 1;
        serial_in = 0;
        errors = 0;

        // Apply reset
        @(negedge clk);
        reset = 0;
        
        $display("Starting exhaustive test of all 256 combinations...");

        // Exhaustive test loop: 0 to 255
        for (i = 0; i < 256; i = i + 1) begin
            apply_check_pattern(i);
        end

        $display("-------------------------------------------------");
        if (errors == 0) begin
            $display("SUCCESS: All 256 combinations passed seamlessly!");
        end else begin
            $display("FAILED: Test completed with %0d errors.", errors);
        end
        $display("-------------------------------------------------");

        $stop;
    end

endmodule