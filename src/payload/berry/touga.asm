SECTION "payload/berry/touga", ROM0
INCLUDE "include/berry.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
    Enigma_Berry

dstruct BerryData, \
  ChipepBerryData, \
    .Name="CHIPEP@", \
    .Firmness=SUPER_HARD, \
    .Size=153, \
    .MaxYield=3, \
    .MinYield=2, \
    .Description=0, \
    .StageDuration=18, \
    .Spicy=40, \
    .Dry=0, \
    .Sweet=0, \
    .Bitter=0, \
    .Sour=0, \
    .Smoothness=65

    ds 1  ; end marker?

BerrySprite::
    INCBIN "build/gfx/berries/touga.4bpp"
BerryPalette::
    INCBIN "build/gfx/berries/touga.gbapal"

    db "This BERRY is amazingly spicy.@              "
    db "No one has been able to eat it whole.@       "
    
    ; Text_JP "とてつもなく　からい。　１どに　まるごと"45
    ; Text_JP "たべられた　ひとは　まだ　だれも　いない。"45    

    db 0,0,0
    db $01 ; cures confusion
    db 0,0,0,0,0,0,0,0,0,0,0,0,0,0
    db $08 ; self-cures confusion
    db 0,0,0

    End_Berry

    ds 2 ; padding

POPC
