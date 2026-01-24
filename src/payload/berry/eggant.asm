SECTION "payload/berry/eggant", ROM0
INCLUDE "include/berry.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
    Enigma_Berry

dstruct BerryData, \
  EggantBerryData, \
    .Name="EGGANT@", \
    .Firmness=SOFT, \
    .Size=41, \
    .MaxYield=3, \
    .MinYield=2, \
    .Description=0, \
    .StageDuration=18, \
    .Spicy=0, \
    .Dry=40, \
    .Sweet=0, \
    .Bitter=0, \
    .Sour=0, \
    .Smoothness=65

    ds 1  ; end marker?

BerrySprite::
    INCBIN "build/gfx/berries/eggant.4bpp"
BerryPalette::
    INCBIN "build/gfx/berries/eggant.gbapal"

    db "Very dry tasting, especially the@            "
    db "parts not exposed to the sun.@               "

    db 0,0,0
    db $00
    db 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0
    db $1C ; self-cure infatuation
    db 0,0,0

    End_Berry

    ds 2 ; padding

POPC
