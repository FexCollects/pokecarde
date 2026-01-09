SECTION "payload/battle/craig", ROM0
INCLUDE "include/trainer.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
    Battle_Trainer

    BT_Level 50
    Class DRAGON_TAMER
    BT_Floor 5
    db "CRAIG@  "
    ; Text_JP "リュウタ"8
    OT_ID 00000, 00000

    Intro_JP $0a14, $1034, $123a, $043e, $1028, $1027
    Win_JP $0a14, $1034, $0415, $043e, $2816, $100c
    Loss_JP $0a14, $1034, $044a, $043e, $2817, $0c06

    Intro_EN DO, YOU, HAVE, RARE, POKEMON, _QU
    Win_EN MY, RARE, DRAGON, IS, ALWAYS, POPULAR
    Loss_EN MY, DRAGON, POKEMON, GOT, DEFEATED, _ELIP

    Pokemon ALTARIA
    Holds LAX_INCENSE
    Moves PROTECT, PERISH_SONG, SING, DRAGON_CLAW
    Level 50
    PP_Ups 0,0,0,0
    EVs 6,0,0,252,0,252
    OT_ID 00000, 00000
    IVs 15,15,15,31,15,31, 0
    PV $000000DC
    db "ALTARIA@   "
    ; Text_JP "チルタリス"11
    Friendship 255

    Pokemon KINGDRA
    Holds CHESTO_BERRY
    Moves SURF, ICE_BEAM, TOXIC, REST
    Level 50
    PP_Ups 0,0,0,0
    EVs 6,0,0,0,252,252
    OT_ID 00000, 00000
    IVs 15,15,15,15,31,31, 0
    PV $0000000F
    db "KINGDRA@   "
    ; Text_JP "キングドラ"11
    Friendship 255

    Pokemon SALAMENCE
    Holds SCOPE_LENS
    Moves FLAMETHROWER, EARTHQUAKE, AERIAL_ACE, PROTECT
    Level 50
    PP_Ups 0,0,0,0
    EVs 0,252,0,6,0,252
    OT_ID 00000, 00000
    IVs 15,31,15,15,15,31, 0
    PV $000000DF
    db "SALAMENCE@ "
    ; Text_JP "ボーマンダ"11
    Friendship 255

    End_Trainer

        ds 44 ; Pad to 256

POPC
