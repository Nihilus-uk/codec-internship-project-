# Project 10 — Digital Voting Machine in Verilog

A beginner-level 4-candidate voting machine in Verilog.

## Files
| File | What it does |
|------|-------------|
| `voting_machine.v` | Main module — counts votes per candidate |
| `voting_machine_tb.v` | Testbench — simulates voters pressing buttons |

## Features
- 4 candidates: A, B, C, D
- Each button press adds 1 vote (rising-edge detected — no double count)
- Reset clears all vote counts to zero
- 8-bit counters (up to 255 votes each)

## How It Works
1. Each button uses a **rising-edge detector** (`btn & ~prev_btn`) so holding the button only counts once
2. On each clock edge, if a rising edge is detected, that candidate's counter increments
3. `rst = 1` resets all counters to zero

## How to Simulate (Icarus Verilog — free)
```bash
# Install on Linux
sudo apt install iverilog

# Compile and run
iverilog -o sim voting_machine_tb.v voting_machine.v
vvp sim
```

## How to Simulate (ModelSim)
```tcl
vlog voting_machine.v
vlog voting_machine_tb.v
vsim work.voting_machine_tb
run -all
```

## Expected Output
```
--- Voting started ---
Results:
  A = 2  (expected 2)
  B = 2  (expected 2)
  C = 1  (expected 1)
  D = 1  (expected 1)
PASS: All vote counts correct!
After reset: A=0 B=0 C=0 D=0 (all should be 0)
PASS: Reset works!
--- Done ---
```
