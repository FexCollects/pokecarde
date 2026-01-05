SECTION "payload/berry/touga", ROM0
INCLUDE "include/berry.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
	Enigma_Berry

	db "CHIPEP@"
	; Text_JP "トウガ@@@@"7
	Firmness SUPER_HARD
	Size 15,3
	Yield_Range 2, 3
	dl 0
	dl 0
	Growth_Stage_Hours 18
	Flavor 40, 0, 00, 0, 0
	Smoothness 65

BerrySprite::
	INCBIN "build/gfx/berries/touga.4bpp"
BerryPalette::
	INCBIN "build/gfx/berries/touga.gbapal"

        db "This BERRY is amazingly spicy.@              "
        db "No one has been able to eat it whole.@       "
	
	; Text_JP "とてつもなく　からい。　１どに　まるごと"45
	; Text_JP "たべられた　ひとは　まだ　だれも　いない。"45	

	db 0,0,0
	db $01 ; cures confusion
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db $08 ; self-cures confusion
	db 0,0,0

	End_Berry

	ds 2 ; padding

POPC
