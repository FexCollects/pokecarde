SECTION "payload/berry/yago", ROM0
INCLUDE "include/berry.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
	Enigma_Berry

	db "BITMEL@"
	; Text_JP "ヤゴ@@@@@"7
	Firmness VERY_HARD
	Size 3,6
	Yield_Range 2, 3
	dl 0
	dl 0
	Growth_Stage_Hours 18
	Flavor 0, 0, 0, 0, 40
	Smoothness 65

BerrySprite::
	INCBIN "build/gfx/berries/yago.4bpp"
BerryPalette::
	INCBIN "build/gfx/berries/yago.gbapal"

        db "This BERRY is amazingly bitter.@             "
        db "It feels weightless when held.@              "
	
	; Text_JP "とてつもなく　にがい。　てで　もっても"45
	; Text_JP "おもさを　かんじない　くらい　かるい。"45	

	db 0,0,0
	db $08 ; cures burn
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db $05 ; self-cures burn
	db 0,0,0

	End_Berry

	ds 2 ; padding

POPC
