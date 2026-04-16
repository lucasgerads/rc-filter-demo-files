# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

The firmware should be a single `main.c` file compiled with `avr-gcc`. Python tooling (`pymcuprog`) handles flashing via UART UPDI on `/dev/ttyUSB0`. Python dependencies are managed with `uv` and a `.venv`.

## Build & Flash Commands

```sh
make            # compile → rc-filter.elf → rc-filter.hex
make clean      # remove .elf and .hex
make rebuild    # clean + compile
make flash      # erase, write, and verify in one step
make erase      # chip erase only
make write      # write hex to chip (no erase)
make verify     # verify flash matches hex
make ping       # ping the MCU to confirm it is reachable
```

Programmer: `pymcuprog` over serial UPDI adapter at `/dev/ttyUSB0`.

## Python Environment

Claude inside a Python venv and all dependencies (`matplotlib`, `numpy`, `scipy`, `pymcuprog`) are available directly without any activation step.

## Attiny1614: Package & Pinout (SOIC-14)

Pins marked **(alt)** require `PORTMUX` configuration to activate. Unmarked peripherals are active **by default** — do not touch PORTMUX unless switching to an alternate.

| Pin | Name | Analog         | TCA0 PWM      | TCB PWM  | USART0 / SPI0 / TWI0     | Other                           |
|-----|------|----------------|---------------|----------|--------------------------|---------------------------------|
| 1   | VDD  | —              | —             | —        | —                        | Power supply                    |
| 2   | PA4  | AIN4, DAC-AIN0 | WO4           | —        | SS, XDIR **(alt)**       | PTC X0/Y0, CCL WOA, LUT0-OUT    |
| 3   | PA5  | AIN5, DAC-AIN1 | WO5           | TCB0-WO  | —                        | PTC X1/Y1, VREFA, CCL WOB       |
| 4   | PA6  | AIN6           | —             | —        | —                        | PTC X2/Y2                       |
| 5   | PA7  | AIN7           | —             | —        | —                        | PTC X3/Y3                       |
| 6   | PB3  | —              | WO0 **(alt)** | —        | RxD **(alt)**            | TOSC1                           |
| 7   | PB2  | —              | WO2           | —        | TxD **(alt)**            | TOSC2, EVOUT1                   |
| 8   | PB1  | AIN10          | WO1           | —        | XCK, SDA **(alt)**       | PTC X4/Y4                       |
| 9   | PB0  | AIN11          | WO0           | —        | XDIR, SCL **(alt)**      | PTC X5/Y5                       |
| 10  | PA0  | AIN0           | —             | —        | —                        | **UPDI** (programmer), LUT0-IN0 |
| 11  | GND  | —              | —             | —        | —                        | Ground                          |
| 12  | PA1  | AIN1           | WO1 **(alt)** | —        | TxD, MOSI, SDA **(alt)** | LUT0-IN1                        |
| 13  | PA2  | AIN2           | WO2 **(alt)** | —        | RxD, MISO, SCL **(alt)** | EVOUT0, LUT0-IN2                |
| 14  | PA3  | AIN3           | WO3           | TCB1-WO  | XCK **(alt)**, SCK       | EXTCLK, LUT0-IN3                |

**Notes:**
- All pins can be used as GPIO, event input, and external interrupt source.
- Pins Px2 and Px6 support full async interrupt detection (wake from any sleep mode).
- PTC lines can each be configured as X- or Y-line.


## Scope Probes Channel Assignments

| Ch | Connected to  |
|----|---------------|
| C1 | not connected |
| C2 | not connected |
| C3 | PB1           | 
| C4 | RC output     |
