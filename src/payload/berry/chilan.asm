SECTION "payload/berry/chilan", ROM0
INCLUDE "include/berry.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
    Enigma_Berry

dstruct BerryData, \
  ChilanBerryData, \
    .Name="CHILAN@", \
    .Firmness=SOFT, \
    .Size=272, \
    .MaxYield=2, \
    .MinYield=1, \
    .Description=0, \
    .StageDuration=1, \
    .Spicy=30, \
    .Dry=0, \
    .Sweet=30, \
    .Bitter=0, \
    .Sour=0, \
    .Smoothness=85

    ds 1  ; end marker?

BerrySprite::
    INCBIN "build/gfx/berries/chilan.4bpp"
BerryPalette::
    INCBIN "build/gfx/berries/chilan.gbapal"

    db "This sparse BERRY grows quickly.@            "
    db "Its skin is quite tough.@                    "

    ds 22 ; Pokéblock ingredient only

    End_Berry

    ds 2 ; padding

POPC
