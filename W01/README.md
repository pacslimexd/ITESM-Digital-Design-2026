# Digital Systems — W01 Cheat Sheet
## PLD Family Tree

| Acronym | Full Name |
|---|---|
| PLD | Programmable Logic Device |
| CPLD | Complex PLD |
| FPGA | Field Programmable Gate Array |
| GAL | Gate Array Logic |
| FPLA | Field Programmable Logic Array |
| PAL | Programmable Array Logic |
| ASIC | Application Specific IC |

---

## Quick History

- **1950s-70s:** DRL (diode-resistor logic), Stanley Frankel — fuse-based matrices
- **1978:** PAL — programmable AND array, fixed OR
- **1983:** GAL — same as PAL but reprogrammable
- **1985:** FPGA (Xilinx XC2064) — LUTs + programmable interconnect matrix

---

## FPGA vs Microcontroller

|  | DE10-Lite (FPGA) | Nucleo STM32 |
|---|---|---|
| Execution | Parallel | Line by line |
| Timing | Deterministic | Variable |
| Cost | ~7,000 MXN | ~500 MXN |
| Code | Non-intuitive | Familiar C/C++ |
| Power consumption | High | Low |

> Use an FPGA when you need extreme speed, precise timing, or custom hardware design.

---

## FPGA Anatomy

- **LUT (Look-Up Table):** implements any N-input logic function
- **CLB (Configurable Logic Block):** LUT + D Flip-Flop + output MUX
- **Switch Block:** programmable interconnect matrix between CLBs
- **I/O Pads:** interface with the outside world

---

## DE10-Lite — Key Specs

- **Device:** Intel MAX 10 — `10M50DAF484C7G`
- **Logic Elements:** 50,000 LEs
- **Internal Memory:** 1,638 Kbit (M9K blocks)
- **Internal Flash:** dual-boot, retains design without power
- **Clock:** 50 MHz crystal oscillator
- **Peripherals:** 10 switches, 10 LEDs, 6x 7-seg displays, 2 buttons, VGA, GPIO

---

## Quartus Prime — Compilation Flow

```
your .v  ->  Analysis & Elaboration  ->  Synthesis  ->  Fitter (P&R)  ->  Timing Analyzer  ->  .sof
```

- **RTL Viewer:** see your design as a schematic before synthesis
- **Technology Map Viewer:** see how it was mapped to actual LUTs
- **Pin Planner:** assign signals to physical chip pins

---

## Verilog — Data Types

| Value | Meaning |
|---|---|
| `0` | Logic zero |
| `1` | Logic one |
| `X` | Unknown (useful for don't cares) |
| `Z` | High impedance / floating |

**Literals:** `4'b1011` = 4-bit binary | `8'hFF` = 8-bit hex | `32'd42` = decimal

---

## Verilog — `wire` vs `reg`

|  | `wire` | `reg` |
|---|---|---|
| Assigned with | `assign` | `always @(*)` or `always @(posedge clk)` |
| Implies a flip-flop? | No | **Not necessarily** — depends on the `always` block |
| Default on ports? | Yes (implicit) | Must be declared explicitly |

```verilog
// These two lines are identical:
input [1:0] sel          // implicit wire
input wire [1:0] sel     // explicit wire — same result

// This is mandatory if assigned inside always:
output reg [3:0] out
```

> `reg` does NOT mean there is a flip-flop. It just tells Verilog the signal is driven
> by a procedural block. The synthesizer decides whether to infer a register or
> combinational logic based on how you write the always block.

---

## Verilog — Design Styles

| Style | How | When |
|---|---|---|
| **Dataflow** | `assign out = a & b;` | Simple combinational logic |
| **Behavioral** | `always @(*) begin ... end` | Logic with conditions or cases |
| **Structural** | Instantiate modules with `.port(wire)` | Hierarchy and reuse |

---

## W01 Exercise — Digital Vault

Switches `SW[9:0]` + LEDs `LEDR[9:0]`:

```verilog
module digitalvault (
    input  wire [9:0] SW,    // 10 Switches
    output wire [9:0] LEDR   // 10 LEDs
);
    wire master;
    wire password;
    wire vault_unlocked;

    assign master         = SW[9];                    // Master switch
    assign password       = (SW[3:0] == 4'b1011);    // Secret key: 1011
    assign vault_unlocked = master & password;

    assign LEDR[9]   = vault_unlocked;  // Lock indicator
    assign LEDR[8]   = master;          // Master status
    assign LEDR[3:0] = SW[3:0];         // Input feedback
    assign LEDR[7:4] = 4'b0000;         // Unused LEDs off
endmodule
```

---

## Real-World Applications

- **Telecomm:** Software Defined Radio (SDR) — real-time signal processing
- **AI Acceleration:** custom matrix multiply units, LLM quantization hardware
- **Space & Defense:** radiation-hardened FPGAs for satellite systems