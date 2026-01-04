SECTION "payload/berry/ginema", ROM0
INCLUDE "include/berry.asm"

DataPacket::
	Enigma_Berry

	Text_EN "ONYON@@"7
	;Text_JP "ギネマ@@@@"7	
	Firmness VERY_HARD
	Size 3,5
	Yield_Range 2, 3
	dl 0
	dl 0
	Growth_Stage_Hours 18
	Flavor 0, 30, 0, 0, 30
	Smoothness 70

BerrySprite::
	INCBIN "build/gfx/berries/ginema.4bpp"
BerryPalette::
	INCBIN "build/gfx/berries/ginema.gbapal"

	Text_EN "If you peel off its thin skin,"45
	Text_EN "this sour BERRY is perfectly round."45
	
	;Text_JP "うすい　かわを　すべて　むくと　まんまるい"45
	;Text_JP "みに　なる。　とても　しぶくて　すっぱい。"45	

	db 0,0,0
	db $00
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db $17 ; self-restores a lowered stat
	db 0,0,0

	End_Berry
