SECTION "payload/berry/pumkin", ROM0
INCLUDE "include/berry.asm"

DataPacket::
	Enigma_Berry

	Text_EN "PUMKIN"7
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

	Text_EN "This BERRY is amazingly sour."45
	Text_EN "It’s heavy due to its dense filling."45

	db 0,0,0
	db $04 ; cures freeze
	db 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0
	db $06 ; self-cures freeze
	db 0,0,0

	End_Berry
