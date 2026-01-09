SECTION "payload/battle/kimiko", ROM0
INCLUDE "include/trainer.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
    Battle_Trainer

    BT_Level 0
    Class TRIATHLETE_F_RUN
    BT_Floor 0
    db "ISABEL@ "
    ; Text_JP "キミコ"8
    OT_ID 00000, 00000

    Intro_JP $142a, $0e29, $062e, $142f, $0620, $0430
    Win_JP $122f, $1c1d, $0e0b, $120f, $26b6, $0c01
    Loss_JP $201e, $0c06, $ffff, $0632, $122d, $0c06

    Intro_EN WITH, MY, INNER_FOCUS, I, NEVER, GIVE_UP
    Win_EN HAVE, YOUR, GUARD, UP, NEXT, TIME
    Loss_EN I, DIDN_T, _PROTECT, MYSELF, ENOUGH, _ELIP

    Pokemon LUDICOLO
    Holds LEFTOVERS
    Moves RAIN_DANCE, TOXIC, PROTECT, GIGA_DRAIN
    Level 68
    PP_Ups 0,0,0,0
    EVs 252,0,252,0,0,6
    OT_ID 00000, 00000
    IVs 31,15,31,15,15,31, 1
    PV $0000001E
    db "LUDICOLO@  "
    ; Text_JP "ルンパッパ"11
    Friendship 255

    Pokemon CRADILY
    Holds LEFTOVERS
    Moves CONFUSE_RAY, INGRAIN, PROTECT, GIGA_DRAIN
    Level 70
    PP_Ups 0,0,0,0
    EVs 252,0,6,0,0,252
    OT_ID 00000, 00000
    IVs 31,15,15,15,15,31, 0
    PV $000000E6
    db "CRADILY@   "
    ; Text_JP "ユレイドル"11
    Friendship 255

    Pokemon WAILORD
    Holds LEFTOVERS
    Moves AMNESIA, WATER_PULSE, PROTECT, REST
    Level 72
    PP_Ups 0,0,0,0
    EVs 252,0,0,6,0,252
    OT_ID 00000, 00000
    IVs 31,15,15,15,15,31, 1
    PV $000000DC
    db "WAILORD@   "
    ; Text_JP "ホエルオー"11
    Friendship 255

    End_Trainer

        ds 44 ; Pad to 256

POPC
