all: 00-C000-EN.raw verify
verify:
	md5sum --check eonticket.md5


eonticket-%.tx: eonticket.asm
	python3 ../scripts/regionalize.py $< $@ $* $*
eonticket-%.o: eonticket-%.tx
	../bin/rgbds/v0.9.1/rgbasm -o $@ $<
eonticket-%.gbc: eonticket-%.o
	../bin/rgbds/v0.9.1/rgblink -o $@ $<
eonticket-%.bin: eonticket-%.gbc
	python3 ../scripts/stripgbc.py $< $@
eonticket-%.mev: eonticket-%.bin
	python3 ../scripts/checksum.py $< $@

prologue-%.tx: prologue.asm
	python3 ../scripts/regionalize.py $< $@ $* $*
prologue-%.o: prologue-%.tx
	../bin/rgbds/v0.9.1/rgbasm -o $@ $<
prologue-%.gbc: prologue-%.o
	../bin/rgbds/v0.9.1/rgblink -o $@ $<
prologue-%.bin: prologue-%.gbc
	python3 ../scripts/stripgbc.py $< $@

00-C000-%.tx: 00-C000.asm eonticket-%.mev prologue-%.bin
	python3 ../scripts/ereadertext.py $< $@ $*
00-C000-%.o: 00-C000-%.tx
	../bin/rgbds/v0.9.1/rgbasm -o $@ $<
00-C000-%.gbc: 00-C000-%.o
	../bin/rgbds/v0.9.1/rgblink -o $@ $<
00-C000-%.z80: 00-C000-%.gbc
	python3 ../scripts/stripgbc.py $< $@
00-C000-%.vpk: 00-C000-%.z80
	../bin/nedc/v1.4/nevpk -c -i $< -o $@
00-C000-%.raw: 00-C000-%.vpk
	../bin/nedc/v1.4/nedcmake -i $< -o $@ -type 1 -region 1

clean:
	rm -f *.tx *.o *.gbc *.z80 *.bin *.mev *.vpk *.raw
