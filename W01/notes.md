\# Digital Systems — W01 Resume

\## PLD Family Tree



| Acronym | Full Name |

|---|---|

| PLD | Programmable Logic Device |

| CPLD | Complex PLD |

| FPGA | Field Programmable Gate Array |

| GAL | Gate Array Logic |

| FPLA | Field Programmable Logic Array |

| PAL | Programmable Array Logic |

| ASIC | Application Specific IC |





\## FPGA vs Microcontroller



|  | DE10-Lite (FPGA) | Nucleo STM32 |

|---|---|---|

| Execution | Parallel | Line by line |

| Timing | Deterministic | Variable |

| Cost | \~7,000 MXN | \~500 MXN |

| Code | Non-intuitive | Familiar C/C++ |

| Power consumption | High | Low |



> Use an FPGA when you need extreme speed, precise timing, or custom hardware design.



\---



\## FPGA Anatomy



\- \*\*LUT (Look-Up Table):\*\* implements any N-input logic function

\- \*\*CLB (Configurable Logic Block):\*\* LUT + D Flip-Flop + output MUX

\- \*\*Switch Block:\*\* programmable interconnect matrix between CLBs

\- \*\*I/O Pads:\*\* interface with the outside world



\---



\## DE10-Lite — Key Specs



\- \*\*Device:\*\* Intel MAX 10 — `10M50DAF484C7G`

\- \*\*Logic Elements:\*\* 50,000 LEs

\- \*\*Internal Memory:\*\* 1,638 Kbit (M9K blocks)

\- \*\*Internal Flash:\*\* dual-boot, retains design without power

\- \*\*Clock:\*\* 50 MHz crystal oscillator

\- \*\*Peripherals:\*\* 10 switches, 10 LEDs, 6x 7-seg displays, 2 buttons, VGA, GPIO



\---



\## Quartus Prime — Compilation Flow



```

your .v  ->  Analysis \& Elaboration  ->  Synthesis  ->  Fitter (P\&R)  ->  Timing Analyzer  ->  .sof

```



\- \*\*RTL Viewer:\*\* see your design as a schematic before synthesis

\- \*\*Technology Map Viewer:\*\* see how it was mapped to actual LUTs

\- \*\*Pin Planner:\*\* assign signals to physical chip pins



\---



\## Verilog — Data Types



| Value | Meaning |

|---|---|

| `0` | Logic zero |

| `1` | Logic one |

| `X` | Unknown (useful for don't cares) |

| `Z` | High impedance / floating |



\*\*Literals:\*\* `4'b1011` = 4-bit binary | `8'hFF` = 8-bit hex | `32'd42` = decimal



\---



\## Verilog — `wire` vs `reg`



|  | `wire` | `reg` |

|---|---|---|

| Assigned with | `assign` | `always @(\*)` or `always @(posedge clk)` |

| Implies a flip-flop? | No | \*\*Not necessarily\*\* — depends on the `always` block |

| Default on ports? | Yes (implicit) | Must be declared explicitly |



```verilog

// These two lines are identical:

input \[1:0] sel          // implicit wire

input wire \[1:0] sel     // explicit wire — same result



\---



\## Verilog — Design Styles



| Style | How | When |

|---|---|---|

| \*\*Dataflow\*\* | `assign out = a \& b;` | Simple combinational logic |

| \*\*Behavioral\*\* | `always @(\*) begin ... end` | Logic with conditions or cases |

| \*\*Structural\*\* | Instantiate modules with `.port(wire)` | Hierarchy and reuse |



\---

