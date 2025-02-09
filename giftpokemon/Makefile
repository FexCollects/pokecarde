all: 00-G000-EN.raw


giftpokemon-%.tx: giftpokemon.asm
	python3 ../scripts/regionalize.py $< $@ $* $*
giftpokemon-%.o: giftpokemon-%.tx
	../bin/rgbds/v0.7.0/rgbasm -o $@ $<
giftpokemon-%.gbc: giftpokemon-%.o
	../bin/rgbds/v0.7.0/rgblink -o $@ $<
giftpokemon1-%.bin: giftpokemon-%.gbc
	python3 ../scripts/stripgbc.py $< $@
giftpokemon-%.bin: giftpokemon1-%.bin
	python3 ../scripts/pokemonstructure.py $< $@
giftpokemon-%.mev: giftpokemon-%.bin
	python3 ../scripts/checksum.py $< $@

prologue-%.tx: prologue.asm
	python3 ../scripts/regionalize.py $< $@ $* $*
prologue-%.o: prologue-%.tx
	../bin/rgbds/v0.7.0/rgbasm -o $@ $<
prologue-%.gbc: prologue-%.o
	../bin/rgbds/v0.7.0/rgblink -o $@ $<
prologue-%.bin: prologue-%.gbc
	python3 ../scripts/stripgbc.py $< $@

00-G000-%.tx: 00-G000.asm giftpokemon-%.mev prologue-%.bin
	python3 ../scripts/ereadertext.py $< $@ $*
00-G000-%.o: 00-G000-%.tx
	../bin/rgbds/v0.7.0/rgbasm -o $@ $<
00-G000-%.gbc: 00-G000-%.o
	../bin/rgbds/v0.7.0/rgblink -o $@ $<
00-G000-%.z80: 00-G000-%.gbc
	python3 ../scripts/stripgbc.py $< $@
00-G000-%.vpk: 00-G000-%.z80
	../bin/nedc/v1.4/nevpk -c -i $< -o $@
00-G000-%.raw: 00-G000-%.vpk
	../bin/nedc/v1.4/nedcmake -i $< -o $@ -type 1 -region 1
	mv $@-01.raw $@


clean:
	rm -f *.tx *.o *.gbc *.z80 *.bin *.mev *.vpk *.raw
