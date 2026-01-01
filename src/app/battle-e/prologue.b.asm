SECTION "app/battle-e/prologue.b", ROM0

MACRO RGB
	dw (\1) | ((\2) << 5) | ((\3) << 10)
	ENDM

DoorPalette:: ; A74
	INCBIN "build/gfx/battle-e/door.gbapal"

BackdropTilemap:: ; A7C
	INCBIN "sprites/battletrainer.tilemap"

