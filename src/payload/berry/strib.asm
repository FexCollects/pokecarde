SECTION "payload/berry/strib", ROM0
INCLUDE "include/berry.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
    Enigma_Berry

    db "STRIB@@"
    Firmness HARD
    Size 12,2
    Yield_Range 4, 12
    dl 0
    dl 0
    Growth_Stage_Hours 24
    Flavor 30, 0, 0, 30, 0
    Smoothness 85

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
