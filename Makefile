COMPILER = aarch64-elf

COPS = -nostdlib -nostartfiles -ffreestanding -I$(HEADER_DIR)
ASMOPS = -nostdlib -nostartfiles -ffreestanding -I$(HEADER_DIR)

BUILD_DIR = build
SRC_DIR = src
HEADER_DIR = include

all : clean build

clean :
	rm -rf $(BUILD_DIR)
	rm -f kernel8.elf

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	mkdir -p $(@D)
	$(COMPILER)-gcc $(COPS) -I$(HEADER_DIR) -c $<  -o $@

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.S
	mkdir -p $(@D)
	$(COMPILER)-gcc $(ASMOPS)  -c $< -o $@

C_FILES = $(wildcard $(SRC_DIR)/*.c)
ASM_FILES = $(wildcard $(SRC_DIR)/*.S)

OBJ_FILES = $(C_FILES:$(SRC_DIR)/%.c=$(BUILD_DIR)/%.o)
OBJ_FILES += $(ASM_FILES:$(SRC_DIR)/%.S=$(BUILD_DIR)/%.o)

HEADER_FILES += $(wildcard $(HEADER_DIR))

build: $(OBJ_FILES) $(HEADER_FILES)
	$(COMPILER)-ld -g -T linker.ld -o kernel8.elf  $(OBJ_FILES)
	$(COMPILER)-objcopy kernel8.elf -O binary kernel8.img