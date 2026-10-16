# Parameterized Synchronous Up/Down Counter

## Overview
This project implements a parameterized synchronous up/down counter using Verilog HDL. The counter supports incrementing, decrementing, synchronous reset, and preset operations.

## Features
- **Parameterized Width:** The counter width can be configured using the `width` parameter.
- **Synchronous Reset:** Sets the counter output to `0` on the rising edge of the clock when `reset` is asserted.
- **Preset:** Loads the maximum counter value, \(2^{width}-1\), when `preset` is asserted and `reset` is not asserted.
- **Up Counting:** Increments the counter by `1` when `ud = 1`.
- **Down Counting:** Decrements the counter by `1` when `ud = 0`.
- **Natural Wraparound:** The counter wraps around automatically due to its fixed bit width.

## Design Specifications

| Signal | Direction | Description |
|---|---|---|
| `clk` | Input | Clock signal |
| `reset` | Input | Synchronous active-high reset |
| `preset` | Input | Loads the maximum counter value |
| `ud` | Input | `1` for up-counting, `0` for down-counting |
| `q` | Output | Current counter value |

### Default Configuration
- Counter width: `4 bits`
- Minimum value: `0`
- Maximum value: `15`
- Reset value: `0`
- Preset value: `15`

## Operation

| Condition | Counter behavior |
|---|---|
| `reset = 1` | `q = 0` |
| `reset = 0`, `preset = 1` | `q = 15` for the default width |
| `reset = 0`, `preset = 0`, `ud = 1` | Increment by `1` |
| `reset = 0`, `preset = 0`, `ud = 0` | Decrement by `1` |

**Priority:** Reset has the highest priority, followed by preset, then counting.

## Verification
A Verilog testbench is used to verify the counter through simulation.

The testbench includes:
- Clock generation
- Directed test cases
- A reference model for expected counter values
- Automatic comparison of expected and actual outputs
- Pass/fail messages using `$display`
- Waveform generation using `$dumpfile` and `$dumpvars`

### Test Cases
- Synchronous reset
- Preset operation
- Up-counting and down-counting
- Overflow from the maximum value to zero
- Underflow from zero to the maximum value
- Simultaneous reset and preset assertion

## Tools
- Verilog HDL
- Icarus Verilog (`iverilog`) for simulation
- GTKWave for waveform inspection

## Running the Simulation

Compile the design and testbench:

```bash
iverilog -g2005 -o counter_sim top.v tb.v
```

Run the simulation:

```bash
vvp counter_sim
```

Open the generated waveform in GTKWave:

```bash
gtkwave counter.vcd
```

Make sure the filenames match your actual project files.

## Learning Objectives
- Understand synchronous sequential logic
- Design parameterized counters in Verilog
- Understand reset and preset priority
- Verify boundary conditions and wraparound
- Develop self-checking Verilog testbenches
- Inspect simulation waveforms

## Future Improvements
- Add a counter enable input
- Extend verification with randomized stimulus
- Test multiple parameter widths
- Explore SystemVerilog assertions and more advanced verification techniques

## Author
Created as a Verilog HDL learning project focused on digital design and functional verification.
