SERIES_1_NUMS = A001 A002 A003 A004 A005 A006 A007 A008 A009 A010 A011 A012 A013 A014 A015 A016 A017 A018 A019 A020 A021 A022 A023 A024 A025 A026 A027 A028 A029 A030 A031 A032 A033 A034 A035 A036 A037 A038 A039 A040 A041 A042 A043 A044 A045 A046 A047 A048
SERIES_1_TRAINERS = alana annie antonio april belford bryce candice celina clayton devin dominic dustin ellie fay fuego goro griffin hayden heather hillary hugo irazu irvin jeffrey judith justine kendall logan maggie mandy marcus natalie natasha oscar patrick raquel renee rudy sandia sandy sofia sonya sophie stuart tsutomu tyler wilson zuril
SERIES_1_BERRYNUMS = K001 K002 K003 K004 K005 K006
SERIES_1_BERRIES = chilan drash eggant nutpea pumkin strib
SERIES_2_NUMS = B001 B002 B003 B004 B005 B006 B007 B008 B009 B010 B011 B012 B013 B014 B015 B016 B017 B018 B019 B020 B021 B022 B023 B024 B025 B026 B027 B028 B029 B030 B031 B032 B033 B034 B035 B036 B037 B038 B039 B040 B041 B042 B043 B044 B045 B046 B047 B048
SERIES_2_TRAINERS = anthony chisa daikichi danpei fiennes fugen fukune harue hoyoshi ihara jo junji junpei kiyoshi koto kuen kyohei makio mami masaru matsuo miyoko moet momoko natsuko noriko nozomu otoya reina rina ruizo ryo sadayo satoe shigeko shigenobu shinji shizu suekichi sueno tomoyasu toshinao toshitsugu umami yoko yu yuka yukio
SERIES_2_BERRYNUMS = K007 K008 K009 K010 K011 K012
SERIES_2_BERRIES = ginema kuo yago touga niniku topo
PROMO_EN_NUMS = B001 B002
PROMO_EN_TRAINERS = astrid nils
P_PROMO_NUMS = P001 P002 P003 P004 P005 P006 P007 P008
P_PROMO_TRAINERS = craig yasuo darlene mattego hidehiko yufu sagami mattegoDEMO
N_PROMO_NUMS = N001 N002 N003 N004 N005 N006 N007 N008
N_PROMO_TRAINERS = teruko kimiko norton simon hozumi ritsue yuuma taisen

all: series_1 series_2 promo_en p_promo n_promo berries berries_2
series_1: $(SERIES_1_TRAINERS:%=trainers/%-EN.mev) $(SERIES_1_NUMS:%=08-%-EN.raw)
series_2: $(SERIES_2_TRAINERS:%=trainers/%-EN.mev) $(SERIES_2_NUMS:%=08-%-EN.raw)
berries: $(SERIES_1_BERRIES:%=berries/%-EN.mev) $(SERIES_1_BERRYNUMS:%=08-%-EN.raw)
berries_2: $(SERIES_2_BERRIES:%=berries/%-EN.mev) $(SERIES_2_BERRYNUMS:%=08-%-EN.raw)
promo_en: $(PROMO_EN_TRAINERS:%=trainers/%-EN.mev) $(PROMO_EN_NUMS:%=129-%-EN.raw)
p_promo: $(P_PROMO_TRAINERS:%=trainers/%-EN.mev) $(P_PROMO_NUMS:%=08-%-EN.raw)
n_promo: $(N_PROMO_TRAINERS:%=trainers/%-EN.mev) $(N_PROMO_NUMS:%=08-%-EN.raw)

series_1_z80: $(SERIES_1_TRAINERS:%=trainers/%-EN.mev) $(SERIES_1_NUMS:%=08-%-EN.z80)
berries_z80: $(SERIES_1_BERRIES:%=berries/%-EN.mev) $(SERIES_1_BERRYNUMS:%=08-%-EN.z80)
berries_2_z80: $(SERIES_2_BERRIES:%=berries/%-EN.mev) $(SERIES_2_BERRYNUMS:%=08-%-EN.z80)
promo_en_z80: $(PROMO_EN_TRAINERS:%=trainers/%-EN.mev) $(PROMO_EN_NUMS:%=129-%-EN.z80)
p_promo_z80: $(P_PROMO_TRAINERS:%=trainers/%-EN.mev) $(P_PROMO_NUMS:%=08-%-EN.z80)
n_promo_z80: $(N_PROMO_TRAINERS:%=trainers/%-EN.mev) $(N_PROMO_NUMS:%=08-%-EN.z80)

# series_2_z80 doesn't match right now
verify: series_1_z80 berries_z80 berries_2_z80 promo_en_z80 p_promo_z80 n_promo_z80
	md5sum --ignore-missing --check battle-e.md5


trainers/%-EN.tx: trainers/%.asm
	python3 ../scripts/regionalize.py $< $@ EN EN
trainers/%.o: trainers/%.tx
	../bin/rgbds/v0.2.0/rgbasm -o $@ $<
trainers/%.gbc: trainers/%.o
	../bin/rgbds/v0.2.0/rgblink -o $@ $<
trainers/%.bin: trainers/%.gbc
	python3 ../scripts/stripgbc.py $< $@
trainers/%.z80: trainers/%.gbc
	python3 ../scripts/stripgbc.py $< $@
trainers/%.mev: trainers/%.bin
	python3 ../scripts/checksum.py $< $@


berries/%-EN.tx: berries/%.asm
	python3 ../scripts/regionalize.py $< $@ EN EN
berries/%.o: berries/%.tx
	../bin/rgbds/v0.2.0/rgbasm -o $@ $<
berries/%.gbc: berries/%.o
	../bin/rgbds/v0.2.0/rgblink -o $@ $<
berries/%.bin: berries/%.gbc
	python3 ../scripts/stripgbc.py $< $@
berries/%.z80: berries/%.gbc
	python3 ../scripts/stripgbc.py $< $@
berries/%.mev: berries/%.bin
	python3 ../scripts/checksum.py $< $@


prologue-%.tx: prologue.asm
	python3 ../scripts/regionalize.py $< $@ $* $*
prologue-%.o: prologue-%.tx
	../bin/rgbds/v0.2.0/rgbasm -o $@ $<
prologue-%.gbc: prologue-%.o
	../bin/rgbds/v0.2.0/rgblink -o $@ $<
prologue-%.bin: prologue-%.gbc
	python3 ../scripts/stripgbc.py $< $@


battletrainer-%.tx: battletrainer.asm prologue-%.bin
	python3 ../scripts/ereadertext.py $< $@ $*
08-A%-EN.tx: 08-A%.asm battletrainer-EN.tx
	python3 ../scripts/ereadertext.py $< $@ EN
08-A%.o: 08-A%.tx
	../bin/rgbds/v0.2.0/rgbasm -o $@ $<
08-A%.gbc: 08-A%.o
	../bin/rgbds/v0.2.0/rgblink -o $@ $<
08-A%.z80: 08-A%.gbc
	python3 ../scripts/stripgbc.py $< $@
08-A%.vpk: 08-A%.z80
	./nevpk.exe -c -i $< -o $@
08-A%.raw: 08-A%.vpk
	./nedcmake.exe -i $< -o $@ -type 1 -region 1

08-B%-EN.tx: 08-B%.asm battletrainer-EN.tx
	python3 ../scripts/ereadertext.py $< $@ EN
08-B%.o: 08-B%.tx
	../bin/rgbds/v0.2.0/rgbasm -o $@ $<
08-B%.gbc: 08-B%.o
	../bin/rgbds/v0.2.0/rgblink -o $@ $<
08-B%.z80: 08-B%.gbc
	python3 ../scripts/stripgbc.py $< $@
08-B%.vpk: 08-B%.z80
	./nevpk.exe -c -i $< -o $@
08-B%.raw: 08-B%.vpk
	./nedcmake.exe -i $< -o $@ -type 1 -region 1

129-B%-EN.tx: 129-B%.asm battletrainer-EN.tx
	python3 ../scripts/ereadertext.py $< $@ EN
129-B%.o: 129-B%.tx
	../bin/rgbds/v0.2.0/rgbasm -o $@ $<
129-B%.gbc: 129-B%.o
	../bin/rgbds/v0.2.0/rgblink -o $@ $<
129-B%.z80: 129-B%.gbc
	python3 ../scripts/stripgbc.py $< $@
129-B%.vpk: 129-B%.z80
	./nevpk.exe -c -i $< -o $@
129-B%.raw: 129-B%.vpk
	./nedcmake.exe -i $< -o $@ -type 1 -region 1

enigmaberry-%.tx: enigmaberry.asm prologue-%.bin
	python3 ../scripts/ereadertext.py $< $@ $*
08-K%-EN.tx: 08-K%.asm enigmaberry-EN.tx
	python3 ../scripts/ereadertext.py $< $@ EN
08-K%.o: 08-K%.tx
	../bin/rgbds/v0.2.0/rgbasm -o $@ $<
08-K%.gbc: 08-K%.o
	../bin/rgbds/v0.2.0/rgblink -o $@ $<
08-K%.z80: 08-K%.gbc
	python3 ../scripts/stripgbc.py $< $@
08-K%.vpk: 08-K%.z80
	./nevpk.exe -c -i $< -o $@
08-K%.raw: 08-K%.vpk
	./nedcmake.exe -i $< -o $@ -type 1 -region 1 -raw

08-N%-EN.tx: 08-N%.asm battletrainer-EN.tx
	python3 ../scripts/ereadertext.py $< $@ EN
08-N%.o: 08-N%.tx
	../bin/rgbds/v0.2.0/rgbasm -o $@ $<
08-N%.gbc: 08-N%.o
	../bin/rgbds/v0.2.0/rgblink -o $@ $<
08-N%.z80: 08-N%.gbc
	python3 ../scripts/stripgbc.py $< $@
08-N%.vpk: 08-N%.z80
	./nevpk.exe -c -i $< -o $@
08-N%.raw: 08-N%.vpk
	./nedcmake.exe -i $< -o $@ -type 1 -region 1

08-P%-EN.tx: 08-P%.asm battletrainer-EN.tx
	python3 ../scripts/ereadertext.py $< $@ EN
08-P%.o: 08-P%.tx
	../bin/rgbds/v0.2.0/rgbasm -o $@ $<
08-P%.gbc: 08-P%.o
	../bin/rgbds/v0.2.0/rgblink -o $@ $<
08-P%.z80: 08-P%.gbc
	python3 ../scripts/stripgbc.py $< $@
08-P%.vpk: 08-P%.z80
	./nevpk.exe -c -i $< -o $@
08-P%.raw: 08-P%.vpk
	./nedcmake.exe -i $< -o $@ -type 1 -region 1


clean:
	rm -f *.z80 *.tx *.o *.gbc *.bin *.raw \
	trainers/*.tx trainers/*.o trainers/*.gbc trainers/*.bin trainers/*.mev \
	berries/*.tx berries/*.o berries/*.gbc berries/*.bin berries/*.mev
