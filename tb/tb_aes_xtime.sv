`timescale 1ns/1ps

module tb_aes_xtime;

    logic [7:0] data_i;
    logic [7:0] data_o;

    int tests_passed;
    int tests_failed;

    aes_xtime dut (
        .data_i(data_i),
        .data_o(data_o)
    );

    task automatic check_xtime (
        input logic [7:0] input_value,
        input logic [7:0] expected_value
    );
        begin
            data_i = input_value;
            #1;

            if (data_o !== expected_value) begin
                $error(
                    "FAIL: xtime(%02h) = %02h, expected %02h",
                    input_value,
                    data_o,
                    expected_value
                );

                tests_failed++;
            end else begin
                $display(
                    "PASS: xtime(%02h) = %02h",
                    input_value,
                    data_o
                );

                tests_passed++;
            end
        end
    endtask

    initial begin
        $dumpfile("build/aes_xtime.vcd");
        $dumpvars(0, tb_aes_xtime);

        data_i      = 8'h00;
        tests_passed = 0;
        tests_failed = 0;

        // Known AES GF(2^8) multiplication results.
        check_xtime(8'h00, 8'h00);
        check_xtime(8'h01, 8'h02);
        check_xtime(8'h57, 8'hae);
        check_xtime(8'hae, 8'h47);
        check_xtime(8'h83, 8'h1d);
        check_xtime(8'hff, 8'he5);

        $display("");
        $display("Tests passed: %0d", tests_passed);
        $display("Tests failed: %0d", tests_failed);

        if (tests_failed == 0) begin
            $display("ALL TESTS PASSED");
        end else begin
            $fatal(1, "TESTBENCH FAILED");
        end

        $finish;
    end

endmodule