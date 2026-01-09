SECTION "payload/battle/satoe", ROM0
INCLUDE "include/trainer.asm"
INCLUDE "include/charmaps.asm"

PUSHC gen3text

DataPacket::
    Battle_Trainer

    BT_Level 50
    db PSYCHIC_F
    BT_Floor 12
    db "PORTIA@ "
    ; Text_JP "サトエ"8
    OT_ID 00000, 00000

    Intro_EN I, GOT, THESE, POKEMON, WITH, POKEBLOCK    
    Win_EN MY, POKEMON, NEED, MORE, POKEBLOCK, _EX    
    Loss_EN I, AM, OUT, OF, POKEBLOCK, _ELIP

    Intro_JP $26b6, $0e0c, $0e1d, $0e12, $1225, $103e
    Win_JP $26b6, $061e, $1034, $0619, $1032, $0c00
    Loss_JP $0408, $0408, $1610, $0637, $0827, $1018

    Pokemon ALAKAZAM
    Holds TWISTEDSPOON
    Moves REFLECT, LIGHT_SCREEN, ICE_PUNCH, PSYCHIC
    Level 50
    PP_Ups 0,0,0,0
    EVs 6,0,0,252,252,0
    OT_ID 00000, 00000
    IVs 15,15,15,31,31,15, 0
    PV $0000000F
    db "ALAKAZAM@  "
    ; Text_JP "フーディン"11
    Friendship 255

    Pokemon GOLDUCK
    Holds MYSTIC_WATER
    Moves LIGHT_SCREEN, IRON_TAIL, SURF, ICE_BEAM
    Level 50
    PP_Ups 0,0,0,0
    EVs 252,0,0,6,252,0
    OT_ID 00000, 00000
    IVs 31,15,15,15,31,15, 1
    PV $000000E0
    db "GOLDUCK@   "
    ; Text_JP "ゴルダック"11
    Friendship 255

    Pokemon MAGNETON
    Holds MAGNET
    Moves REFLECT, TRI_ATTACK, THUNDER_WAVE, THUNDERBOLT
    Level 50
    PP_Ups 0,0,0,0
    EVs 0,0,6,252,252,0
    OT_ID 00000, 00000
    IVs 15,15,15,31,31,15, 1
    PV $0000000F
    db "MAGNETON@  "
    ; Text_JP "レアコイル"11
    Friendship 255

    End_Trainer

        ds 44 ; Pad to 256

POPC
