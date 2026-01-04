SECTION "payload/berry/chilan", ROM0
INCLUDE "include/berry.asm"

DataPacket::
	Enigma_Berry

	Text_EN "CHILAN"7
	Firmness SOFT
	Size 27,2
	Yield_Range 1, 2
	dl 0
	dl 0
	Growth_Stage_Hours 1
	Flavor 30, 0, 30, 0, 0
	Smoothness 85

BerrySprite::
	INCBIN "build/gfx/berries/chilan.4bpp"
BerryPalette::
	INCBIN "build/gfx/berries/chilan.gbapal"

	Text_EN "This sparse BERRY grows quickly."45
	Text_EN "Its skin is quite tough."45

        ds 22 ; Pokéblock ingredient only

	End_Berry
