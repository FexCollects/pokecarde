SECTION "app/battle-e/ruin_maniac.gfx", ROM0

TrainerSprite:: ; 0F38
	INCBIN "build/gfx/trainers/ruin_maniac.4bpp"

TrainerSpriteData:: ; 1738
	dw TrainerSprite
	dw TrainerPalette
	db $08,$08,$01,$01,$01,$01,$01
