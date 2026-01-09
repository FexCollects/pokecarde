SECTION "payload/berry/niniku", ROM0
INCLUDE "include/berry.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
    Enigma_Berry

    db "GARLIK@"
    ; Text_JP "ニニク@@@@"7    
    Firmness HARD
    Size 24,9
    Yield_Range 1, 2
    dl 0
    dl 0
    Growth_Stage_Hours 1
    Flavor 0, 30, 0, 30, 0
    Smoothness 85

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
