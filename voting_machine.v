// ============================================================
// Project : Digital Voting Machine (Beginner Level)
// File    : voting_machine.v
// Description:
//   4 candidates (A, B, C, D), each has a vote button.
//   Press a button → vote count increases by 1.
//   Press RESET → all counts go to zero.
//   Press SHOW  → results are available on output ports.
//   One vote per press (rising-edge detected).
// ============================================================

module voting_machine (
    input  wire       clk,      // clock
    input  wire       rst,      // reset all votes to 0
    input  wire       btn_A,    // vote for candidate A
    input  wire       btn_B,    // vote for candidate B
    input  wire       btn_C,    // vote for candidate C
    input  wire       btn_D,    // vote for candidate D
    output reg  [7:0] count_A,  // vote count for A
    output reg  [7:0] count_B,  // vote count for B
    output reg  [7:0] count_C,  // vote count for C
    output reg  [7:0] count_D   // vote count for D
);

    // --- Edge detection (detect single press, not held) ---
    reg prev_A, prev_B, prev_C, prev_D;

    wire press_A = btn_A & ~prev_A;  // rising edge
    wire press_B = btn_B & ~prev_B;
    wire press_C = btn_C & ~prev_C;
    wire press_D = btn_D & ~prev_D;

    // --- Store previous button states ---
    always @(posedge clk) begin
        prev_A <= btn_A;
        prev_B <= btn_B;
        prev_C <= btn_C;
        prev_D <= btn_D;
    end

    // --- Vote counting logic ---
    always @(posedge clk) begin
        if (rst) begin
            count_A <= 0;
            count_B <= 0;
            count_C <= 0;
            count_D <= 0;
        end else begin
            if (press_A) count_A <= count_A + 1;
            if (press_B) count_B <= count_B + 1;
            if (press_C) count_C <= count_C + 1;
            if (press_D) count_D <= count_D + 1;
        end
    end

endmodule
