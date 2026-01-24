SECTION "payload/berry/ginema", ROM0
INCLUDE "include/berry.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
    Enigma_Berry

dstruct BerryData, \
  OnyonBerryData, \
    .Name="ONYON@@", \
    .Firmness=VERY_HARD, \
    .Size=35, \
    .MaxYield=3, \
    .MinYield=2, \
    .Description=0, \
    .StageDuration=18, \
    .Spicy=0, \
    .Dry=30, \
    .Sweet=0, \
    .Bitter=0, \
    .Sour=30, \
    .Smoothness=70

    ds 1  ; end marker?

BerrySprite::
    INCBIN "build/gfx/berries/ginema.4bpp"
BerryPalette::
    INCBIN "build/gfx/berries/ginema.gbapal"

    db "If you peel off its thin skin,@              "
    db "this sour BERRY is perfectly round.@         "
    
    ; Text_JP "うすい　かわを　すべて　むくと　まんまるい"45
    ; Text_JP "みに　なる。　とても　しぶくて　すっぱい。"45    

    db 0,0,0
    db $00
    db 0,0,0,0,0,0,0,0,0,0,0,0,0,0
    db $17 ; self-restores a lowered stat
    db 0,0,0

    End_Berry

    ds 2 ; padding

POPC
