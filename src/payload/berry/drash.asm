SECTION "payload/berry/drash", ROM0
INCLUDE "include/berry.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
    Enigma_Berry

    db "DRASH@@"
    Firmness VERY_HARD
    Size 13,4
    Yield_Range 2, 3
    dl 0
    dl 0
    Growth_Stage_Hours 18
    Flavor 0, 0, 40, 0, 0
    Smoothness 65

BerrySprite::
    INCBIN "build/gfx/berries/drash.4bpp"
BerryPalette::
    INCBIN "build/gfx/berries/drash.gbapal"

        db "When it ripens, this sweet BERRY@            "
        db "falls and sticks into the ground.@           "

    db 0,0,0
    db $10 ; cures poison
    db 0,0,0,0,0,0,0,0,0,0,0,0,0,0
    db $04 ; self-cures poison
    db 0,0,0

    End_Berry

    ds 2 ; padding

POPC
