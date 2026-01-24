SECTION "payload/berry/pumkin", ROM0
INCLUDE "include/berry.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
    Enigma_Berry

dstruct BerryData, \
  PumpkinBerryData, \
    .Name="PUMKIN@", \
    .Firmness=SUPER_HARD, \
    .Size=48, \
    .MaxYield=3, \
    .MinYield=2, \
    .Description=0, \
    .StageDuration=18, \
    .Spicy=0, \
    .Dry=0, \
    .Sweet=0, \
    .Bitter=0, \
    .Sour=40, \
    .Smoothness=65

    ds 1  ; end marker?

BerrySprite::
    INCBIN "build/gfx/berries/pumkin.4bpp"
BerryPalette::
    INCBIN "build/gfx/berries/pumkin.gbapal"

    db "This BERRY is amazingly sour.@               "
    db "It’s heavy due to its dense filling.@        "

    db 0,0,0
    db $04 ; cures freeze
    db 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0
    db $06 ; self-cures freeze
    db 0,0,0

    End_Berry

    ds 2 ; padding

POPC
