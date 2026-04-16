name: flash
description: Build and flash firmware
command: make flash
workdir: .

---

name: build
description: Build firmware
command: make
workdir: .

---

name: clean
description: Clean build artifacts
command: make clean
workdir: .
