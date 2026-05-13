# Digital Systems - W04 Cheat Sheet

## Serial Communication Protocols

### SPI (Serial Peripheral Interface)

- Synchronous, with a dedicated SCLK.
- 4 wires: SCLK, MOSI, MISO, CS/SS.
- Topology: Single master, multiple slaves selected via the CS pin.
- Full-duplex and extremely fast, typically tens of MHz.

### I2C (Inter-Integrated Circuit)

- Synchronous, with a shared SCL line.
- 2 wires: SDA (data) and SCL (clock). Pull-up resistors are required.
- Topology: Multi-master, multi-slave selected via 7-bit addresses.
- Half-duplex and slower, typically 100 kHz to 400 kHz.

### UART (Universal Asynchronous Receiver-Transmitter)

- Asynchronous, with no clock line. Devices must agree on the baud rate ahead of time.
- 2 wires: TX, RX, plus common ground.
- Full-duplex.

## UART Architecture

- Data frame: Start bit (logic 0) \rightarrow 8 data bits \rightarrow parity bit (optional) \rightarrow stop bit (logic 1).
- Hardware modules:
	- Baud rate generator: Divides the system clock down to the target bit rate.
	- Shift register: Converts a parallel byte to a serial bitstream on TX, or the reverse on RX.
	- Hold register: Implements double buffering to store full bytes while the shift register works.
	- FSM states: IDLE \rightarrow START \rightarrow DATA \rightarrow STOP.