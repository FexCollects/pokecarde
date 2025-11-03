REGION ?= EN

all: build/$(REGION)/08-O001-01.raw verify
.PHONY: verify
verify: build/$(REGION)/08-O001.z80 
	md5sum --check decoration.md5

OBJS := $(patsubst %.asm, build/$(REGION)/%.o, $(wildcard *.asm))

build/$(REGION)/08-O001.tx: 08-O001.asm
	python3 ../scripts/ereadertext.py $< $@ $(REGION)
build/$(REGION)/%.tx: %.asm
	python3 ../scripts/regionalize.py $< $@ $(REGION) $(REGION)
build/$(REGION)/%.o: build/$(REGION)/%.tx
	../bin/rgbds/v0.9.1/rgbasm -M $@.d -o $@ $<

build/$(REGION)/08-O001.gbc: $(OBJS)
	../bin/rgbds/v0.9.1/rgblink -l linker.ld -o $@ $^
build/$(REGION)/08-O001.um: build/$(REGION)/08-O001.gbc
	python3 ../scripts/stripgbc.py $< $@
build/$(REGION)/08-O001.z80: build/$(REGION)/08-O001.um
	python3 ../scripts/checksum_regi.py $< $@
build/$(REGION)/08-O001.vpk: build/$(REGION)/08-O001.z80
	../bin/nedc/v1.4.1/nevpk -c -i $< -o $@
build/$(REGION)/08-O001-01.raw: build/$(REGION)/08-O001.vpk
	../bin/nedc/v1.4.1/nedcmake -i $< -o $(subst -01.raw,,$@) -type 1 -region 1 -save 1 -fill 1 -name "Decor Gift"

# Automatically create build dirs if missing
BUILD_DIRS=build/EN
$(info $(shell mkdir -p $(BUILD_DIRS)))

.PHONY: clean
clean:
	rm -rf build && mkdir -p $(BUILD_DIRS)

# Automatically generated dep files
-include build/*.d
