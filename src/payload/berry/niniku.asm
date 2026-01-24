SECTION "payload/berry/niniku", ROM0
INCLUDE "include/berry.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
    Enigma_Berry

dstruct BerryData, \
  GarlikBerryData, \
    .Name="GARLIK@", \
    .Firmness=HARD, \
    .Size=249, \
    .MaxYield=2, \
    .MinYield=1, \
    .Description=0, \
    .StageDuration=1, \
    .Spicy=0, \
    .Dry=30, \
    .Sweet=0, \
    .Bitter=30, \
    .Sour=0, \
    .Smoothness=85

    ds 1  ; end marker?

BerrySprite::
    INCBIN "build/gfx/berries/niniku.4bpp"
BerryPalette::
    INCBIN "build/gfx/berries/niniku.gbapal"

    db "This sparse BERRY grows quickly.@            "
    db "Its stem gives off a pleasant aroma.@        "
    
    ; Text_JP "そだちは　はやいが　あまり　みが　つかない。"45
    ; Text_JP "くきを　とおって　よい　かおりが　でてくる。"45    

    ds 22 ; Pokéblock ingredient only

    End_Berry

    ds 2 ; padding

POPC
