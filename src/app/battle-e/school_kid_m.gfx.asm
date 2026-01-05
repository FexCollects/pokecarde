SECTION "app/battle-e/school_kid_m.gfx", ROM0

TrainerSprite:: ; 0F38
	INCBIN "build/gfx/trainers/school_kid_m.4bpp"

TrainerSpriteData:: ; 1738
	dw TrainerSprite
	dw TrainerPalette
	db $08,$08,$01,$01,$01,$01,$01
