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
LIB_ASM_FILES_ALL:=$(shell find $(LIB_DIR)/ -name '*.asm')
LIB_O_FILES_ALL:=$(LIB_ASM_FILES_ALL:%.asm=$(BUILD_DIR)/%.o)

all: $(BUILD_DIR) $(BIN_DIR) $(BIN_PROJECTS)

$(BUILD_DIR) $(BIN_DIR):
	mkdir -p $@

.PHONY: clean

clean:
	rm -rf $(BIN_DIR) $(BUILD_DIR)

define SRC
$(1): $(1:$(BUILD_DIR)/%.o=%.asm)
	@mkdir -p $$(@D)
	$(ASM) $(ASM_ARGS) -o $$@ $$^
endef

define PROJECT
$(eval LIB_ASM_FILES=$(foreach file,$(2),$(LIB_DIR)/$(file).asm))
$(eval ASM_FILES=$(shell find $(PROJECTS_DIR)/$(1) -name '*.asm'))
$(eval LIB_O_FILES=$(LIB_ASM_FILES:%.asm=$(BUILD_DIR)/%.o))
$(eval O_FILES=$(ASM_FILES:%.asm=$(BUILD_DIR)/%.o))

$(BIN_DIR)/$(1): $(O_FILES) $(LIB_O_FILES)
	$(LINKER) $(LINKER_ARGS) -o $$@ $$^

$(foreach file,$(O_FILES),$(eval $(call SRC,$(file))))
endef

# Library asm files
$(foreach file,$(LIB_O_FILES_ALL),$(eval $(call SRC,$(file))))

# Args: project name (folder) and then file names of the libs used
$(eval $(call PROJECT,hello-world,stdout exit))
$(eval $(call PROJECT,test-stdin,stdin stdout exit))
$(eval $(call PROJECT,numbers-from-0-to-9,stdout exit))
$(eval $(call PROJECT,numbers-from-0-to-99,stdout exit))
$(eval $(call PROJECT,even-numbers-from-0-to-99,stdout exit))
$(eval $(call PROJECT,numbers-from-n-to-m,stdout exit))
