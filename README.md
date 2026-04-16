# RC Filter Demo

Demo project showing Claude Code controlling a LeCroy oscilloscope and running ngspice simulations to characterize an RC low-pass filter built around an ATtiny1614.

Read the full write-up: [lucasgerads.com/blog/lecroy-mcp-spice-demo/](https://lucasgerads.com/blog/lecroy-mcp-spice-demo/)

## What's here

- `main.c` — ATtiny1614 firmware (PWM output on PB1)
- `netlist.cir` — ngspice netlist for the RC filter (R=4.7 kΩ, C=150 nF, f_c ≈ 226 Hz)
- `Makefile` — build and flash via `avr-gcc` / `pymcuprog`
- `.mcp.json` — MCP servers for the LeCroy scope and spicelib/ngspice
