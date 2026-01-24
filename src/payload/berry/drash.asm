SECTION "payload/berry/drash", ROM0
INCLUDE "include/berry.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
    Enigma_Berry

dstruct BerryData, \
  DrashBerryData, \
    .Name="DRASH@@", \
    .Firmness=VERY_HARD, \
    .Size=134, \
    .MaxYield=3, \
    .MinYield=2, \
    .Description=0, \
    .StageDuration=18, \
    .Spicy=0, \
    .Dry=0, \
    .Sweet=40, \
    .Bitter=0, \
    .Sour=0, \
    .Smoothness=65

    ds 1  ; end marker?

BerrySprite::
    INCBIN "build/gfx/berries/drash.4bpp"
BerryPalette::
    INCBIN "build/gfx/berries/drash.gbapal"

    db "When it ripens, this sweet BERRY@            "
    db "falls and sticks into the ground.@           "

    db 0,0,0
    db $10 ; cures poison
    db 0,0,0,0,0,0,0,0,0,0,0,0,0,0
    db $04 ; self-cures poison
    db 0,0,0

    End_Berry

    ds 2 ; padding

POPC
