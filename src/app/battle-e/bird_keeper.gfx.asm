SECTION "app/battle-e/bird_keeper.gfx", ROM0
INCLUDE "include/erapi.asm"

TrainerSprite:: ; 0F38
    INCBIN "build/gfx/trainers/bird_keeper.4bpp"

dstruct ER_CustomSprite, \
  TrainerSpriteData, \
    .TilePtr=TrainerSprite, \
    .PalettePtr=TrainerPalette, \
    .Width=8, \
    .Height=8, \
    .FramesPerBank=1, \
    .Unknown=1, \
    .HitBoxWidth=1, \
    .HitBoxHeight=1, \
    .FrameCount=1
