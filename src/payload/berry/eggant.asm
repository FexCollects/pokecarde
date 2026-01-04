SECTION "payload/berry/eggant", ROM0
INCLUDE "include/berry.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
	Enigma_Berry

	db "EGGANT@"
	Firmness SOFT
	Size 4,1
	Yield_Range 2, 3
	dl 0
	dl 0
	Growth_Stage_Hours 18
	Flavor 0, 40, 0, 0, 0
	Smoothness 65

BerrySprite::
	INCBIN "build/gfx/berries/eggant.4bpp"
BerryPalette::
	INCBIN "build/gfx/berries/eggant.gbapal"

        db "Very dry tasting, especially the@            "
        db "parts not exposed to the sun.@               "

	db 0,0,0
	db $00
	db 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0
	db $1C ; self-cure infatuation
	db 0,0,0

	End_Berry

POPC
