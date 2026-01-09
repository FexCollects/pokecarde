SECTION "payload/berry/topo", ROM0
INCLUDE "include/berry.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
    Enigma_Berry

    db "TOPO@@@"
    ; Text_JP "トポ@@@@@"7    
    Firmness VERY_HARD
    Size 8,8
    Yield_Range 4, 12
    dl 0
    dl 0
    Growth_Stage_Hours 24
    Flavor 0, 0, 30, 0, 30
    Smoothness 85

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
