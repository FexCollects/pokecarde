SECTION "app/battle-e/prologue.a", ROM0

MACRO RGB
	dw (\1) | ((\2) << 5) | ((\3) << 10)
	ENDM

BattleTrainerBackdrop:: ; 104
	INCBIN "sprites/battletrainer.4bpp"
DoorSprite:: ; 604
	INCBIN "build/gfx/battle-e/door.4bpp"

BackdropPalettes:: ; A04
	INCLUDE "sprites/battletrainer1.pal"
	INCLUDE "sprites/battletrainer2.pal"
	INCLUDE "sprites/battletrainer3.pal"
	INCLUDE "sprites/battletrainer4.pal"
