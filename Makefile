# TOOLCHAIN
ASSEMBLER := aarch64-rpi4-linux-gnu-as
ASSEMBLER_FLAGS := -I include --warn --fatal-warnings --gen-debug
LINKER := aarch64-rpi4-linux-gnu-ld

# FILES
BINARY_DIR := bin
BINARY := ${BINARY_DIR}/gpioctl 
SOURCE_DIR := src
SOURCES = $(wildcard $(SOURCE_DIR)/*.s)
BUILD_DIR = build
BUILD_FILES = $(patsubst $(SOURCE_DIR)/%.s,$(BUILD_DIR)/%.o,$(SOURCES))

# TARGET
TARGET_IP := botelhorasp@192.168.2.28
TARGET := ${TARGET_IP}:/home/botelhorasp

all: $(BINARY)
	@scp ${BINARY} ${TARGET}
	@echo "All done."

# ASSEMBLING
$(BUILD_DIR)/%.o: $(SOURCE_DIR)/%.s
	@mkdir -p $(@D)
	@$(ASSEMBLER) $(ASSEMBLER_FLAGS) -o $@ $<

# LINKING
$(BINARY): $(BUILD_FILES)
	@mkdir -p $(@D)
	@$(LINKER) -o $@ $^

clean:
	@rm -rf $(BUILD_DIR) $(BINARY_DIR)

.PHONY: all clean
