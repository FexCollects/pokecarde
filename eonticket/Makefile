all: build/00-C000-EN-01.raw build/00-C000-DE-01.raw verify

.PHONY: verify
verify: build/00-C000-EN.z80 
	md5sum --check eonticket.md5

build/prologue-%.tx: prologue.asm
	python3 ../scripts/regionalize.py $< $@ $* $*
build/prologue-%.o: build/prologue-%.tx
	../bin/rgbds/v0.9.1/rgbasm -M $@.d -o $@ $<
build/prologue-%.gbc: build/prologue-%.o
	../bin/rgbds/v0.9.1/rgblink -o $@ $<
build/prologue-%.bin: build/prologue-%.gbc
	python3 ../scripts/stripgbc.py $< $@

.PRECIOUS: build/prologue-%.tx build/prologue-%.o build/prologue-%.gbc build/prologue-%.bin

build/eonticket-%.tx: eonticket.asm
	python3 ../scripts/regionalize.py $< $@ $* $*
build/eonticket-%.o: build/eonticket-%.tx
	../bin/rgbds/v0.9.1/rgbasm -M $@.d -o $@ $<
build/eonticket-%.gbc: build/eonticket-%.o
	../bin/rgbds/v0.9.1/rgblink -o $@ $<
build/eonticket-%.bin: build/eonticket-%.gbc
	python3 ../scripts/stripgbc.py $< $@
build/eonticket-%.mev: build/eonticket-%.bin
	python3 ../scripts/checksum.py $< $@

.PRECIOUS: build/eonticket-%.tx build/eonticket-%.o build/eonticket-%.gbc build/eonticket-%.bin build/eonticket-%.mev

build/00-C000-%.tx: 00-C000.asm build/eonticket-%.mev build/prologue-%.bin
	python3 ../scripts/ereadertext.py $< $@ $*
build/00-C000-%.o: build/00-C000-%.tx
	../bin/rgbds/v0.9.1/rgbasm -M $@.d -I build -o $@ $<
build/00-C000-%.gbc: build/00-C000-%.o
	../bin/rgbds/v0.9.1/rgblink -o $@ $<
build/00-C000-%.z80: build/00-C000-%.gbc
	python3 ../scripts/stripgbc.py $< $@
build/00-C000-%.vpk: build/00-C000-%.z80
	../bin/nedc/v1.4/nevpk -c -i $< -o $@

# Sub maps 00-C000-LANG-01.raw -> 00-C000-LANG so the tool output matches
build/00-C000-%-01.raw: build/00-C000-%.vpk
	../bin/nedc/v1.4/nedcmake -i $< -o $(subst -01.raw,,$@) -type 1 -region 1 -save 1 -fill 1 -name "Eon Ticket"

.PRECIOUS: build/00-C000-%.tx build/00-C000-%.o build/00-C000-%.gbc build/00-C000-%.z80 build/00-C000-%.vpk build/00-C000-%-01.raw

# Automatically create build dirs if missing
BUILD_DIRS=build
$(info $(shell mkdir -p $(BUILD_DIRS)))

.PHONY: clean
clean:
	rm -rf build && mkdir -p $(BUILD_DIRS)

# Automatically generated dep files
-include build/*.d
