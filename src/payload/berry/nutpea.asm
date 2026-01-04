SECTION "payload/berry/nutpea", ROM0
INCLUDE "include/berry.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
	Enigma_Berry

	db "NUTPEA@"
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

        db "This BERRY is rigid and cracks open@         "
        db "when the center is squeezed.@                "

        ds 22 ; Pokéblock ingredient only

	End_Berry

POPC
