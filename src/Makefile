REGION ?= EN

# Use `make V=1` to print commands.
#$(V).SILENT:

# GFX Rules
build/%.4bpp: %.png
	../bin/pret/gbagfx $< $@
build/%.gbapal: %.png
	../bin/pret/gbagfx $< $@

# Asm -> Object Rules
# TODO: notdir below is wrong
build/$(REGION)/%.o: %.asm
	../bin/rgbds/v0.9.1/rgbasm -M build/deps/$(notdir $@).d -DREGION=REGION_$(REGION) -o $@ $<

# ROM -> Card .raw Rules
build/$(REGION)/%.z80: build/$(REGION)/%.gbc
	python3 ../scripts/stripgbc2.py $< $@
build/$(REGION)/%.crc: build/$(REGION)/%.z80
	python3 ../scripts/checksum_regi.py $< $@
build/$(REGION)/%.vpk: build/$(REGION)/%.crc
	../bin/nedc/v1.4.1/nevpk -c -i $< -o $@
build/$(REGION)/%-01.raw: build/$(REGION)/%.vpk
	@echo " [CC]  $@"
	../bin/nedc/v1.4.1/nedcmake -i $< -o $(subst -01.raw,,$@) -type 1 -region 1

.PRECIOUS: build/$(REGION)/%.z80

# Baseline ROM generation rule, deps for specfic files are generated
build/$(REGION)/%.gbc:
	../bin/rgbds/v0.9.1/rgblink -m $@.map -t -l card/$(notdir $(basename $@)).ld -o $@ $^

# Baseline verify rule, deps for each card are generated
verify: 
	md5sum --check checksum.md5

# Generate necessary dep files
CARDS := $(wildcard card/*.ld)
ASMS := $(shell find * -name "*.asm" -not -path "include/*")
build/deps/checksum.d: checksum.md5
	python3 ../scripts/generate_deps_verify.py $< $@
build/deps/cards.d: $(CARDS) 
	python3 ../scripts/generate_deps_linkers.py $@ $(REGION) $^
build/deps/asms.d: $(ASMS)
	python3 ../scripts/generate_deps_genfile.py $@ $(REGION) $^
generate: build/deps/checksum.d build/deps/asms.d build/deps/cards.d

# Automatically create build dirs if missing
BUILD_DIRS := build/EN/common build/EN/app/battle-e build/EN/app/berry-e build/EN/payload/battle build/EN/payload/berry build/EN/payload/event build/EN/card build/gfx/trainers build/gfx/battle-e build/gfx/berries build/gfx/berry-e build/gfx/decoration build/deps
$(info $(shell mkdir -p $(BUILD_DIRS)))

.PHONY: clean
clean:
	rm -rf build && mkdir -p $(BUILD_DIRS)

# Automatically generated dep files
-include build/deps/*.d
