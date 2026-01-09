SECTION "payload/battle/suekichi", ROM0
INCLUDE "include/trainer.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
    Battle_Trainer

    BT_Level 0
    db BIRD_KEEPER
    BT_Floor 0
    db "HORACE@ "
    ; Text_JP "スエキチ"8
    OT_ID 00000, 00000

    Intro_EN HOW, ABOUT, SOME, WATER, POKEMON, _EX_EX    
    Win_EN DO, YOU, LIKE, MY, POKEMON, _QU    
    Loss_EN EXCUSE_ME, _EX, MY, POKEMON, ARE, GREAT

    Intro_JP $0a3a, $161a, $063e, $0a1e, $1e1b, $1628
    Win_JP $274c, $060e, $0e08, $0c33, $120a, $ffff
    Loss_JP $274c, $060e, $0e0a, $122f, $0628, $1014

    Pokemon KECLEON
    Holds QUICK_CLAW
    Moves AERIAL_ACE, DOUBLE_TEAM, FAINT_ATTACK, PSYBEAM
    Level 55
    PP_Ups 0,0,0,0
    EVs 0,255,0,0,255,0
    OT_ID 00000, 00000
    IVs 15,31,15,15,31,15, 0
    PV $000000E7
    db "KECLEON@   "
    ; Text_JP "カクレオン"11
    Friendship 255

    Pokemon SWELLOW
    Holds SHARP_BEAK
    Moves AERIAL_ACE, ENDEAVOR, STEEL_WING, DOUBLE_TEAM
    Level 58
    PP_Ups 0,0,0,0
    EVs 255,255,0,0,0,0
    OT_ID 00000, 00000
    IVs 15,31,15,31,15,15, 0
    PV $0000001C
    db "SWELLOW@   "
    ; Text_JP "オオスバメ"11
    Friendship 255

    Pokemon SANDSLASH
    Holds SOFT_SAND
    Moves AERIAL_ACE, SLASH, EARTHQUAKE, SAND_TOMB
    Level 56
    PP_Ups 0,0,0,0
    EVs 255,255,0,0,0,0
    OT_ID 00000, 00000
    IVs 31,31,15,15,15,15, 0
    PV $000000E4
    db "SANDSLASH@ "
    ; Text_JP "サンドパン"11
    Friendship 255

    End_Trainer

        ds 44 ; Pad to 256

POPC
