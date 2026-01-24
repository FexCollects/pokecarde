SECTION "payload/berry/kuo", ROM0
INCLUDE "include/berry.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
    Enigma_Berry

dstruct BerryData, \
  OcraBerryData, \
    .Name="OCRA@@@", \
    .Firmness=HARD, \
    .Size=220, \
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
    INCBIN "build/gfx/berries/kuo.4bpp"
BerryPalette::
    INCBIN "build/gfx/berries/kuo.gbapal"

    db "It has a tasty mix of five flavors,@         "
    db "but feels a little rough to eat.@            "
    ; Text_JP "５つの　あじが　まざって　おいしいが"45
    ; Text_JP "くちの　なかが　ちょっぴり　ザラザラする。"45

    ds 22 ; Pokéblock ingredient only

    End_Berry

    ds 2 ; padding

POPC
