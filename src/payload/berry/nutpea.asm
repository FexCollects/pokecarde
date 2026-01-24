SECTION "payload/berry/nutpea", ROM0
INCLUDE "include/berry.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
    Enigma_Berry

dstruct BerryData, \
  NutpeaBerryData, \
    .Name="NUTPEA@", \
    .Firmness=SUPER_HARD, \
    .Size=124, \
    .MaxYield=3, \
    .MinYield=1, \
    .Description=0, \
    .StageDuration=18, \
    .Spicy=10, \
    .Dry=10, \
    .Sweet=10, \
    .Bitter=10, \
    .Sour=10, \
    .Smoothness=5

    ds 1  ; end marker?

BerrySprite::
    INCBIN "build/gfx/berries/nutpea.4bpp"
BerryPalette::
    INCBIN "build/gfx/berries/nutpea.gbapal"

    db "This BERRY is rigid and cracks open@         "
    db "when the center is squeezed.@                "

    ds 22 ; Pokéblock ingredient only

    End_Berry

    ds 2 ; padding

POPC
