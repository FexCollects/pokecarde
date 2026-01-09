SECTION "payload/battle/renee", ROM0
INCLUDE "include/trainer.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
    Battle_Trainer

    BT_Level MOSSDEEP
    Class PICNICKER
    BT_Floor MOSSDEEP
    db "RENEE@  "
    ; Text_JP "モトコ"8
    OT_ID 00000, 00000

    Intro_EN MY,NATURE,IS,_ELIP,STATIC,_EX
    Win_EN   MY,FEELING,IS,NOW,LIKE,_SUNNY_DAY
    Loss_EN  MY,FEELING,IS,NOW,LIKE,DRIZZLE

    Intro_JP $0a48, $0206, $0c06, $0444, $103b, $0c03
    Win_JP $1c07, $1034, $0e09, $26f1, $103b, $0c03
    Loss_JP $1c07, $1034, $0e09, $0404, $103b, $0c03

    Pokemon CASTFORM
    Holds PETAYA_BERRY
    Moves WEATHER_BALL, SOLARBEAM, SUNNY_DAY, FLAMETHROWER
    Level 72
    PP_Ups 0,0,0,0
    EVs 0,0,0,255,255,0
    OT_ID 00000, 00000
    IVs 15,15,15,31,31,15, CASTFORM_FORECAST
    PV $00000012 ; ♀ Bashful
    db "CASTFORM@  "
    ; Text_JP "ポワルン"11
    Friendship 255

    Pokemon CASTFORM
    Holds SALAC_BERRY
    Moves WEATHER_BALL, THUNDER, RAIN_DANCE, THUNDERBOLT
    Level 70
    PP_Ups 0,0,0,0
    EVs 0,0,0,255,255,0
    OT_ID 00000, 00000
    IVs 15,15,15,31,31,15, CASTFORM_FORECAST
    PV $000000DA ; ♂ Bashful
    db "CASTFORM@  "
    ; Text_JP "ポワルン"11
    Friendship 255

    Pokemon CASTFORM
    Holds APICOT_BERRY
    Moves WEATHER_BALL, BLIZZARD, HAIL, ICE_BEAM
    Level 74
    PP_Ups 0,0,0,0
    EVs 0,0,0,255,255,0
    OT_ID 00000, 00000
    IVs 15,15,15,31,31,15, CASTFORM_FORECAST
    PV $00000012 ; ♀ Bashful
    db "CASTFORM@  "
    ; Text_JP "ポワルン"11
    Friendship 255

    End_Trainer

        ds 44 ; Pad to 256

POPC
