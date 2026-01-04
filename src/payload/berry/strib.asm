SECTION "payload/berry/strib", ROM0
INCLUDE "include/berry.asm"

DataPacket::
	Enigma_Berry

	Text_EN "STRIB@@"7
	Firmness HARD
	Size 12,2
	Yield_Range 4, 12
	dl 0
	dl 0
	Growth_Stage_Hours 24
	Flavor 30, 0, 0, 30, 0
	Smoothness 85

BerrySprite::
	INCBIN "build/gfx/berries/strib.4bpp"
BerryPalette::
	INCBIN "build/gfx/berries/strib.gbapal"

	Text_EN "It grows slowly, but abundantly."45
	Text_EN "Makes a soothing sound when shaken."45

        ds 22 ; Pokéblock ingredient only

	End_Berry
