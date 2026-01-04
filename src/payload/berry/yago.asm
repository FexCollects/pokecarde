SECTION "payload/berry/yago", ROM0
INCLUDE "include/berry.asm"

DataPacket::
	Enigma_Berry

	Text_EN "BITMEL@"7
	;Text_JP "ヤゴ@@@@@"7
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

	Text_EN "This BERRY is amazingly bitter."45
	Text_EN "It feels weightless when held."45
	
	;Text_JP "とてつもなく　にがい。　てで　もっても"45
	;Text_JP "おもさを　かんじない　くらい　かるい。"45	

	db 0,0,0
	db $08 ; cures burn
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db $05 ; self-cures burn
	db 0,0,0

	End_Berry
