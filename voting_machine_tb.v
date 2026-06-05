// ============================================================
// Project : Digital Voting Machine (Beginner Level)
// File    : voting_machine_tb.v  — Testbench
//
// Run with Icarus Verilog (free tool):
//   iverilog -o sim voting_machine_tb.v voting_machine.v
//   vvp sim
//
// Run with ModelSim:
//   vlog voting_machine.v voting_machine_tb.v
//   vsim work.voting_machine_tb
//   run -all
// ============================================================

`timescale 1ns/1ps

module voting_machine_tb;

    reg clk, rst;
    reg btn_A, btn_B, btn_C, btn_D;

    wire [7:0] count_A, count_B, count_C, count_D;

    // Connect DUT
    voting_machine uut (
        .clk(clk), .rst(rst),
        .btn_A(btn_A), .btn_B(btn_B),
        .btn_C(btn_C), .btn_D(btn_D),
        .count_A(count_A), .count_B(count_B),
        .count_C(count_C), .count_D(count_D)
    );

    // Clock: toggle every 5 ns = 100 MHz
    initial clk = 0;
    always #5 clk = ~clk;

    // Task: press a button for a few clock cycles
    task press;
        inout reg btn;
        begin
            btn = 1; #20;
            btn = 0; #20;
        end
    endtask

    initial begin
        // Init
        rst = 1; btn_A = 0; btn_B = 0; btn_C = 0; btn_D = 0;
        #30;
        rst = 0;
        #10;

        $display("--- Voting started ---");

        // Cast votes
        btn_A = 1; #20; btn_A = 0; #20;  // A gets 1
        btn_B = 1; #20; btn_B = 0; #20;  // B gets 1
        btn_B = 1; #20; btn_B = 0; #20;  // B gets 2
        btn_C = 1; #20; btn_C = 0; #20;  // C gets 1
        btn_A = 1; #20; btn_A = 0; #20;  // A gets 2
        btn_D = 1; #20; btn_D = 0; #20;  // D gets 1

        #20;
        $display("Results:");
        $display("  A = %0d  (expected 2)", count_A);
        $display("  B = %0d  (expected 2)", count_B);
        $display("  C = %0d  (expected 1)", count_C);
        $display("  D = %0d  (expected 1)", count_D);

        if (count_A==2 && count_B==2 && count_C==1 && count_D==1)
            $display("PASS: All vote counts correct!");
        else
            $display("FAIL: Counts do not match.");

        // Test reset
        rst = 1; #20; rst = 0; #20;
        $display("After reset: A=%0d B=%0d C=%0d D=%0d (all should be 0)",
                 count_A, count_B, count_C, count_D);

        if (count_A==0 && count_B==0 && count_C==0 && count_D==0)
            $display("PASS: Reset works!");
        else
            $display("FAIL: Reset did not clear counts.");

        $display("--- Done ---");
        $finish;
    end

endmodule
