SECTION "payload/berry/chilan", ROM0
INCLUDE "include/berry.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
	Enigma_Berry

	db "CHILAN@"
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

	db "This sparse BERRY grows quickly.@            "
	db "Its skin is quite tough.@                    "

        ds 22 ; Pokéblock ingredient only

	End_Berry

POPC
