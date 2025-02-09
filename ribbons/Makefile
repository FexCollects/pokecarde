all: 00-R000-EN.raw


ribbon-%.tx: ribbon.asm
	python3 ../scripts/regionalize.py $< $@ $* $*
ribbon-%.o: ribbon-%.tx
	../bin/rgbds/v0.6.0/rgbasm -o $@ $<
ribbon-%.gbc: ribbon-%.o
	../bin/rgbds/v0.6.0/rgblink -o $@ $<
ribbon-%.bin: ribbon-%.gbc
	python3 ../scripts/stripgbc.py $< $@
ribbon-%.mev: ribbon-%.bin
	python3 ../scripts/checksum.py $< $@

prologue-%.tx: prologue.asm
	python3 ../scripts/regionalize.py $< $@ $* $*
prologue-%.o: prologue-%.tx
	../bin/rgbds/v0.6.0/rgbasm -o $@ $<
prologue-%.gbc: prologue-%.o
	../bin/rgbds/v0.6.0/rgblink -o $@ $<
prologue-%.bin: prologue-%.gbc
	python3 ../scripts/stripgbc.py $< $@

00-R000-%.tx: 00-R000.asm ribbon-%.mev prologue-%.bin
	python3 ../scripts/ereadertext.py $< $@ $*
00-R000-%.o: 00-R000-%.tx
	../bin/rgbds/v0.6.0/rgbasm -o $@ $<
00-R000-%.gbc: 00-R000-%.o
	../bin/rgbds/v0.6.0/rgblink -o $@ $<
00-R000-%.z80: 00-R000-%.gbc
	python3 ../scripts/stripgbc.py $< $@
00-R000-%.vpk: 00-R000-%.z80
	../bin/nedc/v1.4/nevpk -c -i $< -o $@
00-R000-%.raw: 00-R000-%.vpk
	../bin/nedc/v1.4/nedcmake -i $< -o $@ -type 1 -region 1
	mv $@-01.raw $@


clean:
	rm -f *.tx *.o *.gbc *.z80 *.bin *.mev *.vpk *.raw
