SECTION "payload/berry/yago", ROM0
INCLUDE "include/berry.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
    Enigma_Berry

dstruct BerryData, \
  BitmelBerryData, \
    .Name="BITMEL@", \
    .Firmness=VERY_HARD, \
    .Size=36, \
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
    INCBIN "build/gfx/berries/yago.4bpp"
BerryPalette::
    INCBIN "build/gfx/berries/yago.gbapal"

    db "This BERRY is amazingly bitter.@             "
    db "It feels weightless when held.@              "
    
    ; Text_JP "とてつもなく　にがい。　てで　もっても"45
    ; Text_JP "おもさを　かんじない　くらい　かるい。"45    

    db 0,0,0
    db $08 ; cures burn
    db 0,0,0,0,0,0,0,0,0,0,0,0,0,0
    db $05 ; self-cures burn
    db 0,0,0

    End_Berry

    ds 2 ; padding

POPC
