all: build/08-O001-EN-01.raw verify

.PHONY: verify
verify: build/08-O001-EN.z80 
	md5sum --check decoration.md5

build/prologue-%.tx: prologue.asm
	python3 ../scripts/regionalize.py $< $@ $* $*
build/prologue-%.o: build/prologue-%.tx
	../bin/rgbds/v0.9.1/rgbasm -M $@.d -o $@ $<
build/prologue-%.gbc: build/prologue-%.o
	../bin/rgbds/v0.9.1/rgblink -o $@ $<
build/prologue-%.bin: build/prologue-%.gbc
	python3 ../scripts/stripgbc.py $< $@

.PRECIOUS: build/prologue-%.tx build/prologue-%.o build/prologue-%.gbc build/prologue-%.bin

build/decoration-%.tx: decoration.asm
	python3 ../scripts/regionalize.py $< $@ $* $*
build/decoration-%.o: build/decoration-%.tx
	../bin/rgbds/v0.9.1/rgbasm -M $@.d -o $@ $<
build/decoration-%.gbc: build/decoration-%.o
	../bin/rgbds/v0.9.1/rgblink -o $@ $<
build/decoration-%.bin: build/decoration-%.gbc
	python3 ../scripts/stripgbc.py $< $@
build/decoration-%.mev: build/decoration-%.bin
	python3 ../scripts/checksum_regi.py $< $@

.PRECIOUS: build/decoration-%.tx build/decoration-%.o build/decoration-%.gbc build/decoration-%.bin build/decoration-%.mev

build/08-O001-%.tx: 08-O001.asm build/decoration-%.mev build/prologue-%.bin
	python3 ../scripts/ereadertext.py $< $@ $*
build/08-O001-%.o: build/08-O001-%.tx
	../bin/rgbds/v0.9.1/rgbasm -M $@.d -I build -o $@ $<
build/08-O001-%.gbc: build/08-O001-%.o
	../bin/rgbds/v0.9.1/rgblink -o $@ $<
build/08-O001-%.z80: build/08-O001-%.gbc
	python3 ../scripts/stripgbc.py $< $@
build/08-O001-%.vpk: build/08-O001-%.z80
	../bin/nedc/v1.4.1/nevpk -c -i $< -o $@
build/08-O001-%-01.raw: build/08-O001-%.vpk
	../bin/nedc/v1.4.1/nedcmake -i $< -o $(subst -01.raw,,$@) -type 1 -region 1

.PRECIOUS: build/08-O001-%.tx build/08-O001-%.o build/08-O001-%.gbc build/08-O001-%.z80 build/08-O001-%.vpk build/08-O001-%-01.raw

# Automatically create build dirs if missing
BUILD_DIRS=build
$(info $(shell mkdir -p $(BUILD_DIRS)))

.PHONY: clean
clean:
	rm -rf build && mkdir -p $(BUILD_DIRS)

# Automatically generated dep files
-include build/*.d
