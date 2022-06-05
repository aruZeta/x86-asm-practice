ASM:=nasm
ASM_FORMAT:=elf32
ASM_DEBUG:=-g -F dwarf
ASM_ARGS:=-f $(ASM_FORMAT) $(ASM_DEBUG)

LINKER:=ld
LINKER_EMULATION:=elf_i386
LINKER_ARGS:=-m $(LINKER_EMULATION)

BUILD_DIR:=build
BIN_DIR:=bin
LIB_DIR:=lib
PROJECTS_DIR:=projects

PROJECTS:=$(shell ls -1 --color=never $(PROJECTS_DIR))
BIN_PROJECTS:=$(foreach project,$(PROJECTS),$(BIN_DIR)/$(project))

define SRC
$(1): $(1:$(BUILD_DIR)/%.o=%.asm)
	@mkdir -p $$(@D)
	$(ASM) $(ASM_ARGS) -o $$@ $$^
endef

define PROJECT
$(eval ASM_FILES=$(foreach file,$(2),$(LIB_DIR)/$(file).asm))
$(eval ASM_FILES+=$(shell find $(PROJECTS_DIR)/$(1) -name '*.asm'))
$(eval O_FILES=$(ASM_FILES:%.asm=$(BUILD_DIR)/%.o))

$(BIN_DIR)/$(1): $(O_FILES)
	$(LINKER) $(LINKER_ARGS) -o $$@ $$^

$(foreach file,$(O_FILES),$(eval $(call SRC,$(file))))
endef

all: $(BUILD_DIR) $(BIN_DIR) $(BIN_PROJECTS)

$(BUILD_DIR) $(BIN_DIR):
	mkdir -p $@

.PHONY: clean

clean:
	rm -rf $(BIN_DIR) $(BUILD_DIR)

# Args: project name (folder) and then file names of the libs used
$(eval $(call PROJECT,hello-world))
$(eval $(call PROJECT,test-stdin,read-stdin exit))
$(eval $(call PROJECT,numbers-from-0-to-9))
