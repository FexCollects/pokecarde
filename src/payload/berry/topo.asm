SECTION "payload/berry/topo", ROM0
INCLUDE "include/berry.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
    Enigma_Berry

dstruct BerryData, \
  TopoBerryData, \
    .Name="TOPO@@@", \
    .Firmness=VERY_HARD, \
    .Size=88, \
    .MaxYield=12, \
    .MinYield=4, \
    .Description=0, \
    .StageDuration=24, \
    .Spicy=0, \
    .Dry=0, \
    .Sweet=30, \
    .Bitter=0, \
    .Sour=30, \
    .Smoothness=85

    ds 1  ; end marker?

BerrySprite::
    INCBIN "build/gfx/berries/topo.4bpp"
BerryPalette::
    INCBIN "build/gfx/berries/topo.gbapal"

    db "It grows slowly, but abundantly.@            "
    db "Its full of sweet and sour juice.@           "
    
    ;Text_JP "そだちは　おそいが　たくさんの　みが　つく。"45
    ;Text_JP "なかみは　あまずっぱい　しるで　いっぱい。"45    

    ds 22 ; Pokéblock ingredient only

    End_Berry

    ds 2 ; padding

POPC
