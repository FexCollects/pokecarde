REGION ?= EN

# Use `make V=1` to print commands.
$(V).SILENT:

# GFX Rules
build/%.4bpp: %.png
	../bin/pret/gbagfx $< $@
build/%.gbapal: %.png
	../bin/pret/gbagfx $< $@

# Asm -> Object Rules
build/$(REGION)/app/%.tx: app/%.asm
	python3 ../scripts/ereadertext.py $< $@ $(REGION)
build/$(REGION)/%.tx: %.asm
	python3 ../scripts/regionalize.py $< $@ $(REGION) $(REGION)
build/$(REGION)/%.o: build/$(REGION)/%.tx
	../bin/rgbds/v0.9.1/rgbasm -MG -M build/deps/$(notdir $@).d -DCREGION=REGION_$(REGION) -o $@ $<

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

# Baseline ROM generation rule, deps for specfic files are generated
build/$(REGION)/%.gbc:
	../bin/rgbds/v0.9.1/rgblink -m $@.map -t -l card/$(notdir $(basename $@)).ld -o $@ $^

# Baseline verify rule, deps for each card are generated
verify: 
	md5sum --check checksum.md5

# Generate necessary dep files
build/deps/scripts.checksum.d: checksum.md5
	python3 ../scripts/generate_deps_verify.py $< $@
build/deps/scripts.%.d: card/%.ld
	python3 ../scripts/generate_deps_linkers.py $< $@ $(REGION)

CARDS := $(subst card/,,$(patsubst %.ld, build/deps/scripts.%.d, $(wildcard card/*.ld)))
OBJS := $(patsubst %.asm, build/$(REGION)/%.o, $(shell find * -name "*.asm" -not -path "include/*"))
generate: build/deps/scripts.checksum.d $(CARDS) $(OBJS)

# Automatically create build dirs if missing
BUILD_DIRS=build/EN/common build/EN/app/battle-e build/EN/payload/battle build/EN/payload/event build/EN/card build/gfx/trainers build/gfx/battle-e build/deps
$(info $(shell mkdir -p $(BUILD_DIRS)))

.PHONY: clean
clean:
	rm -rf build && mkdir -p $(BUILD_DIRS)

# Automatically generated dep files
-include build/deps/*.d
