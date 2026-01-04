SECTION "payload/berry/kuo", ROM0
INCLUDE "include/berry.asm"

DataPacket::
	Enigma_Berry

	Text_EN "OCRA@@@"7
	;Text_JP "クオ@@@@@"7	
	Firmness HARD
	Size 22,0
	Yield_Range 1, 3
	dl 0
	dl 0
	Growth_Stage_Hours 18
	Flavor 10, 10, 10, 10, 10
	Smoothness 5

BerrySprite::
	INCBIN "build/gfx/berries/kuo.4bpp"
BerryPalette::
	INCBIN "build/gfx/berries/kuo.gbapal"

	Text_EN "It has a tasty mix of five flavors,"45
	Text_EN "but feels a little rough to eat."45
	
	;Text_JP "５つの　あじが　まざって　おいしいが"45
	;Text_JP "くちの　なかが　ちょっぴり　ザラザラする。"45	

        ds 22 ; Pokéblock ingredient only

	End_Berry
