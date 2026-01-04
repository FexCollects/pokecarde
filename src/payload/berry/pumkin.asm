SECTION "payload/berry/pumkin", ROM0
INCLUDE "include/berry.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
	Enigma_Berry

	db "PUMKIN@"
	Firmness SUPER_HARD
	Size 4,8
	Yield_Range 2, 3
	dl 0
	dl 0
	Growth_Stage_Hours 18
	Flavor 0, 0, 0, 0, 40
	Smoothness 65

BerrySprite::
	INCBIN "build/gfx/berries/pumkin.4bpp"
BerryPalette::
	INCBIN "build/gfx/berries/pumkin.gbapal"

        db "This BERRY is amazingly sour.@               "
        db "It’s heavy due to its dense filling.@        "

	db 0,0,0
	db $04 ; cures freeze
	db 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0
	db $06 ; self-cures freeze
	db 0,0,0

	End_Berry

POPC
