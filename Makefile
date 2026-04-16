# ---- MCU / Build config ----
TARGET := rc-filter
MCU    := attiny1614
F_CPU  := 20000000UL
CC     := avr-gcc
OBJCOPY:= avr-objcopy

CFLAGS := -mmcu=$(MCU) -DF_CPU=$(F_CPU) -Os -Wall -std=c11
LIBS   := -lm

# ---- Programmer config ----
DEVICE := $(MCU)
PORT   := /dev/ttyUSB0
TOOL   := uart
FILE   := $(TARGET).hex

# ---- Targets ----
.PHONY: all clean erase write verify flash rebuild ping

all: $(TARGET).hex

$(TARGET).elf: main.c
	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)

$(TARGET).hex: $(TARGET).elf
	$(OBJCOPY) -O ihex -R .eeprom $< $@

clean:
	rm -f $(TARGET).elf $(TARGET).hex

rebuild: clean all

# ---- Flashing ----
erase:
	pymcuprog erase -d $(DEVICE) -t $(TOOL) -u $(PORT)

write: $(TARGET).hex
	pymcuprog write -d $(DEVICE) -t $(TOOL) -u $(PORT) -f $(FILE)

verify: $(TARGET).hex
	pymcuprog verify -d $(DEVICE) -t $(TOOL) -u $(PORT) -f $(FILE)

flash: erase write verify

ping:
	pymcuprog ping -d $(DEVICE) -t $(TOOL) -u $(PORT)
