# Digital Systems - W03 Cheat Sheet

## Sequential Logic & Registers

- D flip-flop: Captures input D on the clock edge. Used for data storage, counters, and synchronization.
- Syntax: `q <= d;` inside an `always @(posedge clk)` block.
- Shift registers: Connect D flip-flops in series.
- Conversion: Translates serial data to parallel, or parallel to serial.
- Implementation: `q <= {q[2:0], shift_in};`
- LFSR (Linear Feedback Shift Register): Generates pseudo-random numbers using XOR feedback.
- Feedback logic: `assign feedback = ^(out & TAP_MASK);`

## Clock Domain Crossing (CDC)

- Definition: Signals moving between different synchronous clock domains.
- Metastability: Violating setup/hold times causes the flip-flop to enter an undefined, metastable state.
- CDC strategies:
	- Double flopping: Use two D flip-flops in series to allow a metastable signal time to stabilize.
	- Pulse stretching: When moving from a fast to a slow clock domain, artificially widen the pulse so the slow domain does not miss it.

## Clock Dividers

- Used to interface high-speed clocks with slow physical peripherals such as blinking LEDs and switch debouncing.
- Architecture: A counter increments to a constant number. When reached, toggle the output clock and reset the counter.

## Finite State Machines (FSM)

- Moore machine: Output depends only on the current state. Used for traffic controllers, digital clocks, and washing machines.
- Mealy machine: Output depends on the current state and current inputs. Used for vending machines and smart locks.
- Standard Verilog FSM structure:
  - State encoding (parameter).
  - State register (sequential logic updating `current_state`).
  - Next-state logic (combinational logic using `case`).
  - Output logic.