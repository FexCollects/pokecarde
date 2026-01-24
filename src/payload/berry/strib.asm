SECTION "payload/berry/strib", ROM0
INCLUDE "include/berry.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
    Enigma_Berry

dstruct BerryData, \
  StripBerryData, \
    .Name="STRIB@@", \
    .Firmness=HARD, \
    .Size=122, \
    .MaxYield=12, \
    .MinYield=4, \
    .Description=0, \
    .StageDuration=24, \
    .Spicy=30, \
    .Dry=0, \
    .Sweet=0, \
    .Bitter=30, \
    .Sour=0, \
    .Smoothness=85

    ds 1  ; end marker?

BerrySprite::
    INCBIN "build/gfx/berries/strib.4bpp"
BerryPalette::
    INCBIN "build/gfx/berries/strib.gbapal"

    db "It grows slowly, but abundantly.@            "
    db "Makes a soothing sound when shaken.@         "

    ds 22 ; Pokéblock ingredient only

    End_Berry

    ds 2 ; padding

POPC
