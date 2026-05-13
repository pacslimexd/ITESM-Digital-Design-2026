# Digital Systems - W02 Cheat Sheet

## Multiplexers (MUX) & Decoders

- MUX: Routes multiple inputs to a single output based on a selector.
- 2-to-1 MUX (Dataflow): `assign y = sel ? b : a;`
- Optimization: Use enable bits to cascade multiple smaller MUXes (for example, 8:1) into larger ones (32:1) without duplicating logic. Combine outputs with an OR gate.
- Decoders: Map an $N$-bit input to $2^N$ outputs.
- Minterm example (2-to-4): $D_0 = \overline{A_1} \cdot \overline{A_0}$, $D_1 = \overline{A_1} \cdot A_0$.
- Applications: Chip selection in buses, 7-segment display control, signal demultiplexing.
- 7-segment (common anode): Logic 0 = ON, logic 1 = OFF.

## Design Styles & ALU

- Assign (continuous): Used for combinational logic. Resolves immediately and applies to wire types.
- Always (procedural): Used for complex combinational or sequential logic. Applies to reg types and updates on sensitivity list triggers such as `always @(*)` or `always @(posedge clk)`.
- ALU (Arithmetic/Logic Unit): Executes binary math and logic operations. The 74181 was the first single-chip ALU.

## Physics Reality: Timing & Pipelines

- Propagation delay: Combinational logic takes physical time to resolve.
- Timing errors: Occur if the clock is faster than the propagation delay. For example, a $10\text{ ns}$ delay fails on a $200\text{ MHz}$ ($5\text{ ns}$) clock.
- Solution (pipelines): Break up massive logic blocks by inserting intermediate D flip-flops, or slow down the master clock.

## Hamming Code

- Provides error correction using parity and syndrome bits.
- Parity example: $p_1 = d_1 \oplus d_2 \oplus d_4$.
- Correction: If syndrome bits $\neq 0$, flip the bit at the index of the syndrome value.