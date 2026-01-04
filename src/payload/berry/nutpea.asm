SECTION "payload/berry/nutpea", ROM0
INCLUDE "include/berry.asm"

DataPacket::
	Enigma_Berry

	Text_EN "NUTPEA"7
	Firmness SUPER_HARD
	Size 12,4
	Yield_Range 1, 3
	dl 0
	dl 0
	Growth_Stage_Hours 18
	Flavor 10, 10, 10, 10, 10
	Smoothness 5

BerrySprite::
	INCBIN "build/gfx/berries/nutpea.4bpp"
BerryPalette::
	INCBIN "build/gfx/berries/nutpea.gbapal"

	Text_EN "This BERRY is rigid and cracks open"45
	Text_EN "when the center is squeezed."45

        ds 22 ; Pokéblock ingredient only

	End_Berry
