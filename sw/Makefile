
all: exampleLED.hex exampleTimer.hex exampleFastSerial.hex

BIN_DIR = ./bin
INCL_PATH= ./
CXX_FLAGS =-Os -ggdb -std=c++2a -Wall -fdata-sections -ffunction-sections -fno-exceptions -fno-rtti -Wextra  -march=rv32i -mabi=ilp32
LD_FLAGS = --specs=nano.specs  -march=rv32i -mabi=ilp32


exampleLED.hex: exampleLED/main.cpp crt0.S Makefile
	@mkdir -p $(BIN_DIR)
	riscv-none-embed-g++ -I $(INCL_PATH)   exampleLED/main.cpp crt0.S $(CXX_FLAGS) -Tquadsoc.ld -o $(BIN_DIR)/exampleLED.elf -Xlinker -Map=$(BIN_DIR)/exampleLED.map 
	riscv-none-embed-objcopy -O binary $(BIN_DIR)/exampleLED.elf  $(BIN_DIR)/exampleLED.bin
	riscv-none-embed-size $(BIN_DIR)/exampleLED.elf
	riscv-none-embed-objdump --disassemble-all  --source $(BIN_DIR)/exampleLED.elf  >$(BIN_DIR)/exampleLED.S
	python3 makehex.py $(BIN_DIR)/exampleLED.bin 2048 > $(BIN_DIR)/$@

exampleTimer.hex: exampleTimer/main.cpp crt0.S Makefile
	@mkdir -p $(BIN_DIR)
	riscv-none-embed-g++ -I $(INCL_PATH)   exampleTimer/main.cpp crt0.S $(CXX_FLAGS) -Tquadsoc.ld -o $(BIN_DIR)/exampleTimer.elf -Xlinker -Map=$(BIN_DIR)/exampleTimer.map 
	riscv-none-embed-objcopy -O binary $(BIN_DIR)/exampleTimer.elf  $(BIN_DIR)/exampleTimer.bin
	riscv-none-embed-size $(BIN_DIR)/exampleTimer.elf
	riscv-none-embed-objdump --disassemble-all  --source $(BIN_DIR)/exampleTimer.elf  >$(BIN_DIR)/exampleTimer.S
	python3 makehex.py $(BIN_DIR)/exampleTimer.bin 2048 > $(BIN_DIR)/$@

exampleFastSerial.hex: exampleFastSerial/main.cpp crt0.S Makefile
	@mkdir -p $(BIN_DIR)
	riscv-none-embed-g++ -I $(INCL_PATH)   exampleFastSerial/main.cpp crt0.S $(CXX_FLAGS) -Tquadsoc.ld -o $(BIN_DIR)/exampleFastSerial.elf -Xlinker -Map=$(BIN_DIR)/exampleFastSerial.map 
	riscv-none-embed-objcopy -O binary $(BIN_DIR)/exampleFastSerial.elf  $(BIN_DIR)/exampleFastSerial.bin
	riscv-none-embed-size $(BIN_DIR)/exampleFastSerial.elf
	riscv-none-embed-objdump --disassemble-all  --source $(BIN_DIR)/exampleFastSerial.elf  >$(BIN_DIR)/exampleFastSerial.S
	python3 makehex.py $(BIN_DIR)/exampleFastSerial.bin 2048 > $(BIN_DIR)/$@



clean:
	rm -f main.e* main.hex main.bin main.map out.S 
	rm -rf bin
	
