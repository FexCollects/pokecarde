SECTION "app/battle-e/prologue.a", ROM0

BattleTrainerBackdrop:: ; 104
	INCBIN "build/gfx/battle-e/background1.4bpp"
DoorSprite:: ; 604
	INCBIN "build/gfx/battle-e/door.4bpp"

BackdropPalettes:: ; A04
	INCBIN "build/gfx/battle-e/background1.gbapal"
	INCBIN "build/gfx/battle-e/background2.gbapal"
	INCBIN "build/gfx/battle-e/background3.gbapal"
        ; The 4th palette is only 4 colors for some reason??
        ; This doesn't actually make sense and most likely the
        ; remaining bytes are hidden somewhere. Needs more research
	INCLUDE "gfx/battle-e/background4.pal"
