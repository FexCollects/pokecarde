all: 08-O001-EN.raw
.SECONDARY: 08-O002-EN.z80

decoration-%.tx: decoration.asm
	python3 ../scripts/regionalize.py $< $@ $* $*
decoration-%.o: decoration-%.tx
	../bin/rgbds/v0.7.0/rgbasm -o $@ $<
decoration-%.gbc: decoration-%.o
	../bin/rgbds/v0.7.0/rgblink -o $@ $<
decoration-%.bin: decoration-%.gbc
	python3 ../scripts/stripgbc.py $< $@
decoration-%.mev: decoration-%.bin
	python3 ../scripts/checksum_regi.py $< $@

prologue-%.tx: prologue.asm
	python3 ../scripts/regionalize.py $< $@ $* $*
prologue-%.o: prologue-%.tx
	../bin/rgbds/v0.7.0/rgbasm -o $@ $<
prologue-%.gbc: prologue-%.o
	../bin/rgbds/v0.7.0/rgblink -o $@ $<
prologue-%.bin: prologue-%.gbc
	python3 ../scripts/stripgbc.py $< $@

08-O001-%.tx: 08-O001.asm decoration-%.mev prologue-%.bin
	python3 ../scripts/ereadertext.py $< $@ $*
08-O001-%.o: 08-O001-%.tx
	../bin/rgbds/v0.7.0/rgbasm -o $@ $<
08-O001-%.gbc: 08-O001-%.o
	../bin/rgbds/v0.7.0/rgblink -o $@ $<
08-O001-%.z80: 08-O001-%.gbc
	python3 ../scripts/stripgbc.py $< $@
08-O001-%.vpk: 08-O001-%.z80
	../bin/nedc/v1.4.1/nevpk -c -i $< -o $@
08-O001-%.raw: 08-O001-%.vpk
	../bin/nedc/v1.4.1/nedcmake -i $< -o $@ -type 1 -region 1
	mv $@-01.raw $@

decoration-tickets-%.tx: decoration-tickets.asm
	python3 ../scripts/regionalize.py $< $@ $* $*
decoration-tickets-%.o: decoration-tickets-%.tx
	../bin/rgbds/v0.7.0/rgbasm -o $@ $<
decoration-tickets-%.gbc: decoration-tickets-%.o
	../bin/rgbds/v0.7.0/rgblink -o $@ $<
decoration-tickets-%.bin: decoration-tickets-%.gbc
	python3 ../scripts/stripgbc.py $< $@
decoration-tickets-%.mev: decoration-tickets-%.bin
	python3 ../scripts/checksum_regi.py $< $@

08-O002-%.tx: 08-O002.asm decoration-tickets-%.mev prologue-%.bin
	python3 ../scripts/ereadertext.py $< $@ $*
08-O002-%.o: 08-O002-%.tx
	../bin/rgbds/v0.7.0/rgbasm -o $@ $<
08-O002-%.gbc: 08-O002-%.o
	../bin/rgbds/v0.7.0/rgblink -o $@ $<
08-O002-%.z80: 08-O002-%.gbc
	python3 ../scripts/stripgbc.py $< $@
08-O002-%.vpk: 08-O002-%.z80
	../bin/nedc/v1.4.1/nevpk -c -i $< -o $@
08-O002-%.raw: 08-O002-%.vpk
	../bin/nedc/v1.4.1/nedcmake -i $< -o $@ -type 1 -region 1
	mv $@-01.raw $@

clean:
	rm -f *.tx *.o *.gbc *.z80 *.bin *.mev *.vpk *.raw
